+++
author = "leovct"
title = "Master advanced Kubernetes operator concepts"
date = "2022-08-01"
description = "Learn how to write unit and e2e tests for Kubernetes operators"
tags = [
    "kubernetes",
    "go",
]
categories = [
    "themes",
    "syntax",
]
series = ["Themes Guide"]
aliases = ["migrate-from-jekyl"]
+++

You've probably built some Kubernetes operators in the past and you want to write production-ready operators? Then you're at the right place.
<!--more-->

{{< figure
  src="fig-1-photo.png"
  caption="Fig 1. Photo from [Unsplash](https://unsplash.com/photos/FPKnAO-CF6M)"
  height="350"
  width="600"
>}}

And maybe you haven't, no problem! I've got what you need to explore the fascinating world of Kubernetes operators. You'll first learn how to build a simple operator using the Kubebuilder framework and then how to write robuts tests to ensure its proper functioning. Let's dive in!

## Advanced CRD concepts

### 1. Validate CRD input using webhooks

https://medium.com/r/?url=https%3A%2F%2Fbook.kubebuilder.io%2Freference%2Fgenerating-crd.html%23validation

https://medium.com/swlh/advanced-kubernetes-operators-development-988edad5f58a

### 2. Add additional printer columns

https://medium.com/r/?url=https%3A%2F%2Fbook.kubebuilder.io%2Freference%2Fgenerating-crd.html%23additional-printer-columns

### 3. Keep unkown fields

Stop the api server from pruning fields that are not specified
// +kubebuilder:pruning:PreserveUnknownFields

## Advanced controller concepts

### 1. Watch resources (operator or externally managed)

https://medium.com/r/?url=https%3A%2F%2Fbook.kubebuilder.io%2Freference%2Fwatching-resources.html

+ provide multiple code samples (see operators created for Renault)

### 2. Delete sub-resources automatically

TODO: check ownerRef field

### 3. Emit logs And events

TODO: condition status, liveness and readiness probes.
https://medium.com/r/?url=https%3A%2F%2Fbook.kubebuilder.io%2Freference%2Fgenerating-crd.html%23status

### 4. Add health checks and set conditions

TODO: see Stefanie Lai article and check that it's not already implemented by Kubebuilder by default

### 5. Expose prometheus metrics

TODO: default and custom Prometheus metrics
https://medium.com/r/?url=https%3A%2F%2Fbook.kubebuilder.io%2Freference%2Fmetrics.html

## To go further

TODO
