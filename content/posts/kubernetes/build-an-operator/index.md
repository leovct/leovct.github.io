---
author: leovct
title: Build a Kubernetes operator in 10 minutes
description: Learn how Kubernetes operators work and how to build one using go and the kubebuilder framework
date: 2022-07-07
tags:
  - kubernetes
  - go
  - infra
cover:
  image: fig-1-cover.png
  caption: Fig 1. Photo from [Unsplash](https://unsplash.com/photos/Esq0ovRY-Zs)
---

You’re probably familiar with Kubernetes, but do you know what operators are, how they work, and how to build one?
If you want to know more, you've come to the right place!

Kubernetes operators is a complicated subject but fortunately, since [their creation](https://web.archive.org/web/20170129131616/https://coreos.com/blog/introducing-operators.html) in 2016, many tools have been developed to simplify the life of engineers.

Without further ado, let’s dive in and learn more about operators!

> **tl;dr** Kubernetes operators allow to incorporate custom logic into Kubernetes to automate a large number of tasks, beyond what the software can do natively. While one could build an operator from scratch, it's highly recommended to use a framework like [Kubebuilder](https://book.kubebuilder.io/) or [OperatorSDK](https://sdk.operatorframework.io/), as shown in this article.

## What is an operator?

Wait a minute, do you know what [Kubernetes](https://kubernetes.io/) (or k8s) is? Just a quick reminder for everyone, it’s an “open source system to deploy, scale, and manage containerized applications anywhere” developed by [Google Cloud](https://cloud.google.com/learn/what-is-kubernetes).

Most people use Kubernetes by deploying their applications using native resources such as pods, deployments, services, etc. However, it is possible to extend the capabilities of the software to incorporate its logic to meet specific needs. That’s where the operator comes into place.

> The main goal of an operator is to translate an engineer’s logic into code in order to automate certain tasks beyond what Kubernetes can do natively.

Engineers dealing with applications or services have a deep knowledge of how the system should behave, how it should be deployed, and how to react in case of a problem. The ability to encapsulate this technical knowledge in code and automate actions means less time is spent on repetitive tasks and more on important issues.

For example, one can imagine an operator deploying and maintaining tools such as [MySQL](https://www.mysql.com/), [Elasticsearch](https://www.elastic.co/), or [Gitlab runners](https://docs.gitlab.com/runner/) in Kubernetes. An operator could configure these tools, adjust the state of the system according to events and react to failures.

Sounds interesting, right? Let’s get our hands dirty.

## Practical Work

You could either build an operator from scratch using the [controller-runtime](https://github.com/kubernetes-sigs/controller-runtime) project developed by Kubernetes or you could use one of the most popular frameworks to accelerate your development cycle and reduce the complexity ([Kubebuilder](https://book.kubebuilder.io/) or [OperatorSDK](https://sdk.operatorframework.io/)). I’d choose the Kubebuilder framework because it’s very easy to use, the documentation is good, and it’s a battle-tested product. In any case, the two projects are currently being aligned to merge into a single project.

### 1. Set up your environment

You’ll need some tools to develop your operator. Here are the requisites:

- [go](https://go.dev/doc/install) version v1.17.9+
- [docker](https://docs.docker.com/get-docker/) version 17.03+
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) version v1.11.3+

You'll also need access to a Kubernetes v1.11.3+ cluster. I highly suggest using [kind](https://kind.sigs.k8s.io/) to set up your own local k8s cluster, it’s very easy to use!

We can then install kubebuilder.

```sh
$ curl -L -o kubebuilder \
    kuhttps://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH) \
    && chmod +x kubebuilder \
    && mv kubebuilder /usr/local/bin/
```

If everything goes fine, you should see a similar output (the version might have changed depending on when you read this article).

```sh
$ kubebuilder version
Version: main.version{KubeBuilderVersion:"3.4.1", KubernetesVendor:"1.23.5", GitCommit:"d59d7882ce95ce5de10238e135ddff31d8ede026", BuildDate:"2022-05-06T13:58:56Z", GoOs:"darwin", GoArch:"amd64"}
```

Awesome, now we can get started!

### 2. Create a simple operator

Let’s do a little exercise: we’ll build a simple foo operator which has no real use, except to demonstrate the capabilities of an operator.

Initialise a new project by running the following command. It will download the controller-runtime binary and scaffold a project that’s ready for us to customise.

```sh
$ kubebuilder init --domain my.domain --repo my.domain/tutorial
Writing kustomize manifests for you to edit...
Writing scaffold for you to edit...
Get controller runtime:
$ go get sigs.k8s.io/controller-runtime@v0.11.2
go: downloading sigs.k8s.io/controller-runtime v0.11.2
...
Update dependencies:
$ go mod tidy
go: downloading github.com/onsi/gomega v1.17.0
...
```

Here’s the structure of the project (as you can notice, it’s a Go project):

```sh
$ ls -a
-rw-------   1 leovct  staff    129 Jun 30 16:08 .dockerignore
-rw-------   1 leovct  staff    367 Jun 30 16:08 .gitignore
-rw-------   1 leovct  staff    776 Jun 30 16:08 Dockerfile
-rw-------   1 leovct  staff   5029 Jun 30 16:08 Makefile
-rw-------   1 leovct  staff    104 Jun 30 16:08 PROJECT
-rw-------   1 leovct  staff   2718 Jun 30 16:08 README.md
drwx------   6 leovct  staff    192 Jun 30 16:08 config
-rw-------   1 leovct  staff   3218 Jun 30 16:08 go.mod
-rw-r--r--   1 leovct  staff  94801 Jun 30 16:08 go.sum
drwx------   3 leovct  staff     96 Jun 30 16:08 hack
-rw-------   1 leovct  staff   2780 Jun 30 16:08 main.go
```

Let’s go through the most important components of the operator:

- `main.go` is the entry point of the project; it sets up and runs the manager
- `config/` contains the manifests to deploy the operator in Kubernetes
- `Dockerfile` is the container file used to build the manager’s image

**Wait, what’s this manager component?!**

This is going to be a bit theoretical. Hang on!

> An operator is made of two components, a custom resource definition (CRD) and a controller.

A CRD is a “Kubernetes custom type” or a blueprint of the resource, used to describe its specification and status. We can define instances of the CRD, called custom resources (or CR).

{{< figure
  src="fig-2-crd-cr.png"
  caption="Fig 2. Custom Resource Definition (CRD) and Custom Resources (CR)"
  height="150"
  width="400"
  align="center"
>}}

The controller (also called the control loop) continuously monitors the state of the cluster and, depending on events, makes changes. Its goal is to bring the current state of a resource towards its desired state, defined by the user in the specification of the custom resource.

{{< figure
  src="fig-3-controller.png"
  caption="Fig 3. High-level operation of a controller by [Stefanie Lai](https://medium.com/swlh/kubernetes-operator-for-beginners-what-why-how-21b23f0cb9b1)"
  height="120"
  width="620"
  align="center"
>}}

In general, a controller is specific to a type of resource but it can perform CRUD (Create, Read, Update and Delete) operations on a set of different resources.

An example of a controller, presented in the Kubernetes documentation, is the thermostat. When we set the temperature, we tell the thermostat the desired state. The actual state is determined by the actual temperature of the room. The thermostat then reacts to bring the actual state closer to the desired state by turning the heat on or off.

What about the manager then? The goal of this component is to start all the various controllers and makes the set of control loops coexist. Let’s say you have two CRDs in your project. You’ll then have two controllers: one for each CRD. The manager will start these two controllers and make them coexist.

_If you want more details on how operators work, you can leave questions in the comments or explore the list of resources provided at the end of the article. I will certainly do a detailed article on this concept in the future_.

Now that we know how an operator works, we can start to create one using the Kubebuilder framework. We’ll start by creating a new API (group/version) and a new Kind (CRD). Press yes when asked to create a CRD and a controller.

```sh
$ kubebuilder create api --group tutorial --version v1 --kind Foo
Create Resource [y/n] y
Create Controller [y/n] y
Writing kustomize manifests for you to edit...
Writing scaffold for you to edit...
api/v1/foo_types.go
controllers/foo_controller.go
Update dependencies:
$ go mod tidy
Running make:
$ make generate
mkdir -p /Users/leovct/Documents/tutorial/bin
GOBIN=/Users/leovct/Documents/tutorial/bin go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.8.0
/Users/leovct/Documents/tutorial/bin/controller-gen object:headerFile="hack/boilerplate.go.txt" paths="./..."
```

This is where the fun starts now! We’ll customise the CRD and the controller to meet our needs. You’ll notice that two new folders have been created:

- `api/v1/` which contains our Foo CRD (see `foo_types.go`)
- `controllers/` which contain the Foo controller (see `foo_controller.go`)

### 3. Customize the CRD and the controller

Here’s our lovely Foo CRD customised (see `api/v1/foo_types.go`). As I said previously, this CRD has no purpose. It simply shows how you can use operators to perform simple tasks in Kubernetes.

The Foo CRD has a `name` field in its specification which refers to the name of the friend Foo is looking for. If Foo finds a friend (a pod with the same name as his friend), its `happy` status will be set to `true`.

{{< gist leovct aa3b494eafdc9bdbc2dc705936d9a451 >}}

Now, let’s implement the logic of the controller. Nothing very complicated here. We fetch the Foo resource that triggered the reconciliation request to get the name of Foo’s friend. Then, we list all the pods that have the same name as Foo’s friend. If we find one (or more), we update Foo’s `happy` status to `true`, else we set it to `false`.

Note that the controller also reacts to Pod events (see mapPodsReqToFooReq). Indeed, if a new pod is created, we want the Foo resource to be able to update its status accordingly. This method will be triggered each time a Pod event happens (creation, update, or deletion). It then triggers a reconciliation loop of the Foo controller only if the name of the Pod is a “friend” of one of the Foo custom resources deployed in the cluster.

A picture is worth more than 1000 words so here is an overview of how the operator works.

{{< figure
  src="fig-4-foo-operator-overview.png"
  caption="Fig 4. Overview of the operator's functioning"
  height="300"
  width="600"
  align="center"
>}}

And now, here is the implementation of the controller.

{{< gist leovct 24b53d11662fa7b8d14721edc3f58b0d >}}

We’re done editing the API definitions and the controller so we can run the following command to update the operator manifests. If you pay attention, you’ll see that some manifest files have been updated.

```sh
$ make manifests
/Users/leovct/Documents/tutorial/bin/controller-gen rbac:roleName=manager-role crd webhook paths="./..." output:crd:artifacts:config=config/crd/bases
```

### 4. Run the controller

I’m using a local Kubernetes cluster set up with kind, and I advise you to do the same. It’s very easy to use.

First, we install the CRDs into the cluster.

```sh
$ make install
/Users/leovct/Documents/tutorial/bin/controller-gen rbac:roleName=manager-role crd webhook paths="./..." output:crd:artifacts:config=config/crd/bases
kubectl apply -k config/crd
customresourcedefinition.apiextensions.k8s.io/foos.tutorial.my.domain created
```

You can see that the Foo CRD has been created.

```sh
$ kubectl get crds
NAME                               CREATED AT
foos.tutorial.my.domain            2022-06-30T17:02:45Z
```

Then we run the controller in the terminal. Keep in mind that we can also deploy it as deployment in the Kubernetes cluster.

```sh
$ make run
/Users/leovct/Documents/tutorial/bin/controller-gen rbac:roleName=manager-role crd webhook paths="./..." output:crd:artifacts:config=config/crd/bases
/Users/leovct/Documents/tutorial/bin/controller-gen object:headerFile="hack/boilerplate.go.txt" paths="./..."
go fmt ./...
go vet ./...
go run ./main.go
INFO controller-runtime.metrics Metrics server is starting to listen {"addr": ":8080"}
INFO setup starting manager
INFO Starting server {"path": "/metrics", "kind": "metrics", "addr": "[::]:8080"}
INFO Starting server {"kind": "health probe", "addr": "[::]:8081"}
INFO controller.foo Starting EventSource {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "source": "kind source: *v1.Foo"}
INFO controller.foo Starting EventSource {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "source": "kind source:*v1.Pod"}
INFO controller.foo Starting Controller {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo"}
INFO controller.foo Starting workers {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "worker count": 1}
```

As you can see, the manager started and then the Foo controller started. The controller is now running and listening to events!

### 5. Test the controller

To test that everything works properly, we’ll create two Foo custom resources and some pods just to see how the controller behaves.

First, create the Foo custom resources manifests in config/samples and run the following command to create the resources in your local Kubernetes cluster.

{{< gist leovct c41cb1ded81ac74486dd01e776545daf >}}

```sh
$ kubectl apply -f config/samples
foo.tutorial.my.domain/foo-1 created
foo.tutorial.my.domain/foo-2 created
```

You should see that the controller triggered two reconciliation loops for each Foo custom resource creation event. You may wonder why two loops were triggered for each custom resource and not one, this is a more technical topic, I invite you to read this [thread](https://github.com/leovct/kubernetes-operator-tutorial/issues/2).

```sh
INFO controller.foo reconciling foo custom resource {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default"}
INFO controller.foo foo's happy status updated {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default", "status": "false"}
INFO controller.foo foo custom resource reconciled {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default"}
INFO controller.foo reconciling foo custom resource {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-2", "namespace": "default"}
INFO controller.foo foo's happy status updated {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-2", "namespace": "default", "status": "false"}
INFO controller.foo foo custom resource reconciled {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-2", "namespace": "default"}
```

If you check the status of the Foo custom resources, you can see that their status is empty. That’s exactly what we expect so everything’s good so far!

```sh
$ kubectl describe foos
Name:         foo-1
Namespace:    default
API Version:  tutorial.my.domain/v1
Kind:         Foo
Metadata:     ...
Spec:
  Name:       jack
Status:
Name:         foo-2
Namespace:    default
API Version:  tutorial.my.domain/v1
Kind:         Foo
Metadata:     ...
Spec:
  Name:       joe
Status:
```

Now, let’s spice things up! We’ll deploy a pod named `jack` to see how the system reacts.

{{< gist leovct fa9cc578ada581f0c32cff14515cc2e2 >}}

Once done, you should see that the controller reacts to the pod creation event. It then updates the status of the first Foo custom resource as expected. You can verify by yourself by describing the Foo custom resources.

```sh
INFO pod linked to a foo custom resource issued an event {"name": "jack"}
INFO controller.foo reconciling foo custom resource {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default"}
INFO controller.foo pod linked to a foo custom resource found {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default", "name": "jack"}
INFO controller.foo foo's happy status updated {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default", "status": true}
INFO controller.foo foo custom resource reconciled {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-1", "namespace": "default"}
```

Let’s update the specification of the second Foo custom resource and change the value of its name field from `joe` to `jack`. The controller should catch the update event and trigger a reconciliation loop.

```sh
INFO controller.foo pod linked to a foo custom resource found {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-2", "namespace": "default", "name": "jack"}
INFO controller.foo foo's happy status updated {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-2", "namespace": "default", "status": true}
INFO controller.foo foo custom resource reconciled {"reconciler group": "tutorial.my.domain", "reconciler kind": "Foo", "name": "foo-2", "namespace": "default"}
```

Yeah, it worked! Enough tests for today; I think you got it! If you delete the pod named `jack`, the custom resources’ `happy` status will be set back to `false`.

We can confirm that the operator works as expected! It would be better to write unit and e2e tests but that’s not the purpose of this article, i’ll cover this topic in another article.

You can be proud of yourself. You have designed, deployed, and tested your very first operator! Congratulations!!

Here’s the link to the [GitHub repository](https://github.com/leovct/kubernetes-operator-tutorial) if you need to browse the code.

## To go further

We’ve seen how to create a very basic Kubernetes operator and it’s far from being perfect. There are many ways to improve it. Here’s a list of topics you can explore if you want.

- Optimise event filtering (sometimes, events are submitted twice…)
- Refine RBAC permissions
- Improve the logging system
- Issue Kubernetes events when resources are updated by the operator
- Add custom fields when getting Foo custom resources (display the `happy` status maybe?)
- Write unit tests and e2e tests

Here’s a list of resources you can use to dig deeper into the subject.

- <https://youtu.be/i9V4oCa5f9I>
- <https://book.kubebuilder.io/>
- <https://cloudark.medium.com/kubernetes-custom-controllers-b6c7d0668fdf>
- <https://medium.com/swlh/kubernetes-operator-for-beginners-what-why-how-21b23f0cb9b1>
- <https://medium.com/swlh/advanced-kubernetes-operators-development-988edad5f58a>
- <https://operatorhub.io/>

Have fun! :)

_NB: A first version of this article was published on Medium in [Better Programming](https://betterprogramming.pub/), you can find it [here](https://betterprogramming.pub/build-a-kubernetes-operator-in-10-minutes-11eec1492d30). This article is an improved version with a little more content, including the diagram of the Foo operator's functioning_.
