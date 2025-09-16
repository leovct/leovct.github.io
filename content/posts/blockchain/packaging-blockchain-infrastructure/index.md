---
author: leovct
title: 📦 Packaging blockchain infrastructure with Kurtosis
description: A look at how Kurtosis simplifies spinning up L2 blockchain stacks like Polygon CDK
date: 2025-09-15
tags:
  - blockchain
  - layer 2
  - polygon
  - kurtosis
cover:
  image: fig-1-cover.png
  caption: Fig 1. Photo from [Unsplash](https://unsplash.com/photos/a-brown-paper-bag-with-a-smile-drawn-on-it-0auL0z5579o)
---

If you've ever built on Ethereum, chances are you've used tools like [Anvil](https://github.com/foundry-rs/foundry) and [Hardhat](https://github.com/NomicFoundation/hardhat) to spin up local blockchain nodes. Simple, fast, effective, and usually enough for most projects.

But what happens when your use case gets more complex? How do you test multi-chain interactions between Ethereum and different L2s? How do you test your system's behavior against a specific rollup stack? What if a change in a protocol could affect your system? How do you safely test that?

Public testnets are a great option, but they can be slow, costly, missing certain protocols or infrastructure components and, as the name suggests, they're not private.

Now you’re hacking your way through [Docker Compose](https://github.com/docker/compose), [Ansible](https://github.com/ansible/ansible) or [Helm](https://github.com/helm/helm) charts. Trying to get execution and consensus clients running for your local blockchain stack. Configuring all these services is tricky, but eventually, you manage to get an L1 up and running. It’s messy, complicated, and a nightmare to maintain - but hey, it works.

Great! Now do the same for the rollup stack. Suddenly, you’re looking at a dozen services and fifteen smart contracts that must be deployed in a precise order… And the nightmare only grows from there. One small mistake and nothing works: batches fail to create, the prover can’t prove blocks, or batches aren’t settled on L1. So many ways to mess up… Oh, and did I mention? _Nothing is documented_.

<!-- prettier-ignore-start -->
{{< figure
  src="fig-2-side-eyeing-chloe-meme.png"
  caption="Fig 2. Side eyeing chloe meme"
  height="400"
  width="700"
  align="center"
>}}
<!-- prettier-ignore-end -->

Fortunately, some brilliant engineers (not to say giga chads) went through this pain before us and decided to make our lives a little easier. They built a framework that lets you define your infrastructure as real code. [Starlark](https://github.com/bazelbuild/starlark), a subset of Python, not some YAML configuration. You can define services sequentially, add conditional logic to deploy components, customise configurations based on user input, and more. That’s the power and promise of [Kurtosis](https://github.com/kurtosis-tech/kurtosis). It simplifies packaging distributed system stacks and makes running them on Docker or Kubernetes effortless.

Feeling hyped? Let’s see how to get full L2 local devnets running in just a few minutes.

## Concrete Example

- Spin up kurtosis-cdk (ethereum l1 + l2 stack built on top of op-geth)
- Include commands and snippets to show how services are defined sequentially
- Show small test interaction (e.g. send a tx on L2)
- Show how long it takes and say that's it's not fully optimised yet
- Introduce a brief diagram of the whole stack and how it works (2/3 paragraphs max) to show the complexity

## Dive into Theory

- Explain Starlark & infrastructure-as-code concepts: sequential services, conditional logic, variable reuse.
- Highlight core Kurtosis features: reproducibility, isolated environments, CI/CD friendliness, debugging.
- Compare briefly to Docker Compose/Ansible pitfalls.

## Conclusion

- Key takeaways / lessons learned

  - Pros of Kurtosis: speed, reproducibility, and easy experimentation with complex L1+L2 stacks.
  - Cons / Tradeoffs: complexity creep, occasional maintenance overhead, not usable in production, bugs and lacking some features (e.g. restarting an enclave).
  - Surprises: adoption internally and in the community—what worked, what didn’t, and how developers reacted.
  - Reflection: “Infrastructure as Code” is becoming as important as protocol R&D; managing complex stacks reliably is no longer optional.

- The Bigger Picture

  - For Polygon engineers: faster iteration and safer testing of CDK rollups.
  - For external developers: easier onboarding, local experimentation, and fewer blockers.
  - For researchers/validators: a reproducible sandbox for testing protocol upgrades safely.
  - Future potential: community contributions, a standardized “Polygon-in-a-box,” and integration with the EthPandaOps ecosystem.

- Call to action

Try out these projects:

- [kurtosis-cdk](https://github.com/0xPolygon/kurtosis-cdk)
- [kurtosis-pos](https://github.com/0xPolygon/kurtosis-pos)

Many thanks to the maintainers of these projects - feel free to also give them a try:

- [ethereum-package](https://github.com/ethpandaops/ethereum-package)
- [optimism-package](https://github.com/ethpandaops/optimism-package)

Share feedback, contribute, or explore what’s next in local devnet tooling.

## To Go Further

- https://ethpandaops.io/posts/kurtosis-deep-dive/
- https://ethpandaops.io/posts/kurtosis-l2/
