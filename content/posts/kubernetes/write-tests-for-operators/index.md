---
author: leovct
title: 🧪 Write tests for Kubernetes operators
date: 2022-08-01
description: Learn how to write unit and e2e tests for Kubernetes operators
tags:
  - kubernetes
  - go
  - infra
cover:
  image: fig-1-cover.png
  caption: Fig 1. Photo from [Unsplash](https://unsplash.com/photos/aYHzEnSEH-w)
---

You know how to build a kubernetes operator? Cool. Now, it’s time to get serious!

Let's write some tests to use our operator in production!

In my previous [article](https://leovct.github.io/posts/build-a-kubernetes-operator-in-10-minutes/), I showed how to build a Kubernetes operator in about ten minutes - but you must be quick haha! I’ve also described the functioning of an operator, the custom resource definition and custom resources, the controllers, and the manager. If you want to learn more about these concepts, I highly recommend you read the article.

But now it’s time to write some tests to use our operator in production! It’s a subject in its own right that is less complicated than it seems. Most people don’t like writing tests, but they are necessary. They help to improve code quality, detect bugs, and save time and money. So, let’s do some testing!

> **✨ The article was updated to use the latest version of kubebuilder ([v3.14.0](https://github.com/kubernetes-sigs/kubebuilder/releases/tag/v3.14.0)), released in January 2024!**

## The Different Types of Tests

There are three major types of testing in software development: unit, integration, and end-to-end testing. It is even more complex than that in theory, but it gives an idea of what we’ll see in this article.

- **Unit tests** are used to test small pieces of code, for example, methods or functions.
- **Integration tests** are used to test the integration of the different parts of an application. For example, the functioning of an operator in a Kubernetes environment with an API server and other resources.
- **End-to-end tests**, also known as e2e, aim to simulate a user’s step-by-step experience. They should cover the main functionalities of the application. In the practical work that follows, we’ll see how to write unit tests in Go as well as integration tests for Kubernetes controllers. It’s interesting, you’ll see!

## Practical Work

### 1. Set up your environment

I choose to use the [Kubebuilder](https://book.kubebuilder.io/) framework to build Kubernetes operators. It’s very easy to use, the documentation is easy to read, and it’s a battle-tested product. It’s one of the two most popular Go frameworks to build operators, along with [Operator SDK](https://sdk.operatorframework.io/).

I assume you already have the necessary tools to design an operator (`go`, `docker`, `kubectl`, `kubebuilder` and a small local Kubernetes cluster). But if this is not the case, I strongly recommend that you follow the following [installation steps](https://leovct.github.io/posts/build-a-kubernetes-operator-in-10-minutes/#1-set-up-your-environment) so that you can follow along with me during this tutorial.

To focus only on the testing part, I have prepared a simple Kubernetes operator, designed with Kubebuilder. This practical work will be to write tests to validate that the operator’s code meets our expectations and ensure that it does not contain any bugs. I’m going to ask you to clone the project and move to the `operator-v2` directory so we all start from the same base.

```sh
$ git clone git@github.com:leovct/kubernetes-operator-tutorial.git \
    && cd kubernetes-operator-tutorial/operator-v2
```

If you try to run tests, you’ll see that the coverage equals 0%. Indeed, we haven’t written any tests yet! But this is going to change!

```sh
$ make test
...
KUBEBUILDER_ASSETS="/Users/leovct/Documents/projects/kubernetes-operator-tutorial/operator-v2/bin/k8s/1.28.0-darwin-amd64" go test ./... -coverprofile cover.out
?       my.domain/tutorial/api/v1       [no test files]
?       my.domain/tutorial/cmd  [no test files]
?       my.domain/tutorial/internal/color       [no test files]
ok      my.domain/tutorial/internal/controller  2.129s  coverage: 0.0% of statements
```

### 2. Some context on the operator

The “Foo” operator you cloned is similar to the one I built in my “[Build a Kubernetes Operator in 10 minutes](https://leovct.github.io/posts/build-a-kubernetes-operator-in-10-minutes/)” article. It has no real purpose except to show how you can use operators to perform simple tasks in Kubernetes.

How does the operator work?

Because a diagram explains ideas way better than three paragraphs, here it is.

<!-- prettier-ignore-start -->
{{< figure
  src="fig-2-foo-operator-overview.svg"
  caption="Fig 2. Overview of the operator's functioning"
  height="400"
  width="700"
  align="center"
>}}
<!-- prettier-ignore-end -->

First, there is the Foo Custom Resource Definition or CRD (see `api/v1/foo_types.go`). It has a `name` field in its specification which refers to the name of the friend Foo is looking for. If Foo finds a friend (a Pod with the same name as his friend), its `happy` status will be set to `true`. A small addition since the previous tutorial, the status of Foo also contains a `color` field, determined according to its name and the namespace in which it evolves.

Second, there is the Foo Controller (see `controllers/foo_controller.go`). It fetches the Foo resource that triggered the reconciliation request to get the name of Foo’s friend. Then, it lists all the pods with the same name as Foo’s friend. If at least one friend has been found, it updates Foo’s `happy` status to `true`, else we set it to `false`. It also updates Foo’s `color` status.

Note that the controller also reacts to Pod events (see `mapPodsReqToFooReq`). Indeed, if a new pod is created, we want the Foo resource to be able to update its status accordingly. This method will be triggered each time a Pod event happens (creation, update, or deletion). It then triggers a reconciliation loop of the Foo controller only if the Pod's name is a “friend” of one of the Foo custom resources deployed in the cluster.

Now that we know how the operator works, we can get on with testing it.

### 3. Unit tests

At this stage, we will test small pieces of code like methods and functions. Of course, we won’t test the controller `Reconcile` method here because it involves setting up a testing Kubernetes environment with a local Kubernetes API server, the CRD, the controller, the manager, etc. We’ll see this in the 4. Integration tests section instead.

What are we going to test then? If you take the time to read the code of the Foo controller, you’ll notice that I use the `ConvertStrToColor` function from the `color` package to update Foo’s `color` status. Let’s write the unit tests of this simple method!

{{< gist leovct 786b5c520dbbfaa60d16b5897b0532fb >}}

Our goal here is to make sure that the function returns what is expected given the input parameters. Here are the three tests I’d like to write to test this function:

1. Convert an empty string to a colour of the colour wheel.
2. Convert a short string to a colour of the colour wheel.
3. Convert a very long string (with numbers and dashes) to a colour of the colour wheel.

To write unit tests in Go, you create a list of tests describing the name, input parameters and expected result. Then you run a loop and compare the function's output with the expected result. Here is my test function to check that `ConvertStrToColor` works correctly:

{{< gist leovct e0d7563e278c1a4d25ea3e823d3515aa >}}

Now, if you attempt to run the tests a second time, you’ll see that the code coverage of the `color` package is equal to 100%! Awesome, we did it! The function works as expected.

```sh
$ make test
...
KUBEBUILDER_ASSETS="/Users/leovct/Documents/projects/kubernetes-operator-tutorial/operator-v2/bin/k8s/1.28.0-darwin-amd64" go test ./... -coverprofile cover.out
?       my.domain/tutorial/api/v1       [no test files]
?       my.domain/tutorial/cmd  [no test files]
ok      my.domain/tutorial/internal/color       0.319s  coverage: 100.0% of statements
ok      my.domain/tutorial/internal/controller  2.109s  coverage: 0.0% of statements
```

Now, let’s get down to business. We’re going to test how the operator’s reconciliation loop! Trust me, this is the most interesting part of the article!

### 4. Integration tests

Kubebuilder provided a test boilerplate (see `controllers/suite_test.go`) that sets up a testing environment with a local Kubernetes API server. The only thing we need to do is first instantiate and run the controller and then write tests with [Ginkgo](https://onsi.github.io/ginkgo/) (framework used by Kubebuilder) to verify that our operator behaves well when it evolves in a Kubernetes environment.

Of course, this test environment is very simple and often does not represent the environment of a production cluster. This is why running the operator’s tests in an existing cluster is also possible to get closer to a real production environment. You can learn more about that [here](https://book.kubebuilder.io/reference/envtest.html).

First, we’ll need to instantiate and start the Foo controller. To do this, we need to create another client. Why do we need two clients? Because when running tests, you want to assert against the live state of the API server. If you use the client from the manager in your tests, you’d end up asserting against the content of the cache instead. First, this is slower. Second, this can introduce flaws. That’s why we’ve got two clients: `k8sclient`, the client we’ll use in our tests, and `k8sManager.getClient()`, the manager's client.

Here is the modified source code of the test environment setup.

{{< gist leovct 47dceaf7d524ae7be9850ad8ae02b791 >}}

Now that our test environment is properly set up, we can write integration tests! Let’s create a new test file called `foo_controller_test.go` under the `controllers` folder. In this file, we’ll define our tests using the Ginkgo framework. Here’s a simple test example that creates two Foo custom resources and ensures that the resources have been created.

{{< gist leovct 025628faea88b93c561f490d2a1e51f2 >}}

Great! Now let’s write a test that creates a pod with the same name as one of the Foo custom resources’ friends. The controller should update the status of the custom resource and set it to `true`. The other custom resource should still have its status set to `false`.

{{< gist leovct b65dcf88ae6218f1d9fa7e7cc1d6502a >}}

Let’s write another test that updates the name of the second Foo custom resource’s friend to the name of the previously created pod. The controller should update the status of the custom resource and set it to `true`. Again, the other custom resource should still have its status set to `false`.

{{< gist leovct 0f7398a6facaf18451a91ce68891cf8f >}}

Our final test for today will be to delete the pod we created and check that the controller updates the status of all the custom resources to `false`.

{{< gist leovct d1d2c55cdd54bce15312807940d76217 >}}

These are fairly simple tests, but they show you the possibilities. You can do very complex things using the various tools provided by Ginkgo. If you paid attention during the tutorial, you should have seen various instructions such as `Expect`, `Eventually`, or `Consistently`, which are very useful methods to test the behaviour of the operator and the resources running in Kubernetes.

We’ve written many great tests that cover our controller's scope. Now it’s time to run them to see if the operator passes them all.

```sh
$ make test
...
KUBEBUILDER_ASSETS="/Users/leovct/Documents/projects/kubernetes-operator-tutorial/operator-v2/bin/k8s/1.28.0-darwin-amd64" go test ./... -coverprofile cover.out
?       my.domain/tutorial/api/v1       [no test files]
?       my.domain/tutorial/cmd  [no test files]
ok      my.domain/tutorial/internal/color       0.443s  coverage: 100.0% of statements
ok      my.domain/tutorial/internal/controller  16.166s coverage: 81.8% of statements
```

Nice, we’ve got no errors! In addition, we went from 0% coverage to over 82%! The last 18% corresponds to the parts of the code that we can’t test (or maybe using mocks but it would be a lot of work for not much). For example, when the controller can’t find the custom resource that triggered the reconciliation loop or when it can’t list the pods in the cluster. It doesn’t matter because we know that we have tested all the operator’s scope.

Here’s the link to the [GitHub repository](https://github.com/leovct/kubernetes-operator-tutorial) if you need to browse the code. The `operator-v2` directory contains the source code of the operator without the tests, while the `operator-v2-with-tests` directory contains the source code with all the tests.

## To Go Further

We’ve seen how to write unit tests and integration tests for Kubernetes controllers using the Ginkgo framework. It is a crucial step in developing Kubernetes operators as it allows for validating the correct functioning of the reconciliation logic.

Also, here’s a list of resources you can use to dig deeper into the subject.

- <https://book.kubebuilder.io/cronjob-tutorial/writing-tests.html>
- <https://book.kubebuilder.io/reference/envtest.html>
- <http://onsi.github.io/ginkgo>

Have fun! :)

_NB: This article was published on Medium in Better Programming, you can find it [here](https://medium.com/better-programming/write-tests-for-your-kubernetes-operator-d3d6a9530840)_.
