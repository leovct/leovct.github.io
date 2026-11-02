---
author: leovct
title: 🔭 What does my work as a software engineer involve?
description: A layered explanation of my day-to-day work, from the simplest to the most technical
date: 2026-11-02
altUrl: /posts/ce-que-je-fais/
altLang: fr
altLabel: 🇫🇷 Version française
tags:
  - blockchain
  - reliability
  - infra
---

When someone asks me what I do for a living, the conversation often goes like this:

{{< chat right Someone >}}What do you do for a living?{{< /chat >}}
{{< chat left Me >}}I'm a software engineer{{< /chat >}}
{{< chat right Someone >}}Nice!{{< /chat >}}
{{< chat right Someone >}}So you code apps?{{< /chat >}}
{{< chat left Me >}}Not really{{< /chat >}}
{{< chat left Me >}}I do infra{{< /chat >}}
{{< chat right Someone >}}Hmmm ok...{{< /chat >}}
{{< chat right Someone >}}And who do you work for?{{< /chat >}}
{{< chat left Me >}}Polygon{{< /chat >}}
{{< chat left Me >}}We build blockchains and payment solutions{{< /chat >}}
{{< chat right Someone >}}Wait{{< /chat >}}
{{< chat right Someone >}}What's a blockchain?!{{< /chat >}}
{{< chat left Me >}}Well...{{< /chat >}}
{{< chat left Me >}}&lt;complex explanation nobody understands&gt;{{< /chat >}}

Not an easy question to answer: blockchain and infrastructure are technical subjects that are hard to explain... People usually picture apps and websites, but not the hidden part of the iceberg that keeps the internet running.

So, to cut it short, I often end up answering:

{{< chat left Me >}}Basically...{{< /chat >}}
{{< chat left Me >}}I write code, you know...{{< /chat >}}
{{< chat left Me >}}I talk to computers all day{{< /chat >}}

And when someone has already heard of blockchain, the conversation quickly turns to speculation:

{{< chat right Someone >}}Oh, you work in the blockchain space?{{< /chat >}}
{{< chat right Someone >}}I invested in Bitcoin back in 2021{{< /chat >}}
{{< chat right Someone >}}I bought this meme coin{{< /chat >}}
{{< chat right Someone >}}I also bought some NFTs...{{< /chat >}}
{{< chat right Someone >}}Do you think Bitcoin will go back above $100k before the end of the bull run?{{< /chat >}}
{{< chat left Me >}}No idea{{< /chat >}}
{{< chat left Me >}}I'm not a financial advisor{{< /chat >}}
{{< chat left Me >}}I work on the networks, not on the prices{{< /chat >}}
{{< chat right Someone >}}And what is your company's crypto?{{< /chat >}}
{{< chat left Me >}}POL{{< /chat >}}
{{< chat left Me >}}It's the network's token{{< /chat >}}
{{< chat left Me >}}It used to be called MATIC{{< /chat >}}
{{< chat right Someone >}}And how much is it worth?{{< /chat >}}
{{< chat left Me >}}Honestly, I'm the wrong person to ask{{< /chat >}}
{{< chat left Me >}}I just help keep the networks running{{< /chat >}}

So here is my attempt at an answer, in two layers, from the simplest to the most technical, followed by a look at how AI changed my day-to-day.

## The short version

Blockchains are networks that move money and data without relying on a single company to keep the records. When they break, people can lose money, or trust. I help make sure Polygon's networks and applications work, and keep working, by building the tools that let engineers test them before release and detect problems as early as possible once they are live.

Take aviation, for example: some people design the planes, others build the flight simulators and the instruments that warn the crew before something goes wrong. I work on the simulators and the warning systems. Nobody wants to see a plane crash, and it is the same for us: nobody wants users to lose their money, a security flaw to be exploited or a chain to halt and freeze the assets flowing through it.

### What is a blockchain, and what is it useful for?

Today, to send money or pay for something, you go through an intermediary. A bank has its own processes and can block a transfer. Fintech apps like Revolut or PayPal are faster, but they are still intermediaries and can also freeze your funds. Well... Revolut is now a bank in some countries, but you get the idea.

A blockchain is instead run by many independent computers, so in principle no single company has to hold your funds or approve your payments. With a wallet you control yourself, the money is yours. It matters most where banks fall short: sending money abroad quickly and cheaply, or reaching people who have no bank account.

Not all blockchains are alike: they are more or less decentralised, faster or slower, and offer different levels of security, and each fits a different use case. Bitcoin favours security and decentralisation, as a store of value. Ethereum is a general-purpose platform for applications and smart contracts. Solana and Polygon PoS aim for speed and low fees, for payments and consumer apps.

## For technical people

Think of a blockchain as a tamper-resistant database shared by many computers, with no central operator. These computers do not have to trust each other: they follow the same rules (the consensus) to agree on the order of transactions, and the data is stored in blocks chained together with cryptographic hashes, so any rewrite of history is detectable, and the consensus makes it extremely hard.

On top of that, smart contracts are programs that run on this shared database. They are used, for example, to lend and borrow money without a bank, to swap one currency for another, or to issue stablecoins (tokens pegged to currencies like the dollar or the euro). They can also represent unique items as tokens (NFTs), tokenise real-world assets or bridge funds from one network to another.

Polygon builds several blockchain networks and products, each made of many components (nodes, bridges, smart contracts, APIs, wallets) that have to work together. Two questions drive my work:

- Can I test a change against the rest of the stack, quickly and reproducibly?
- Would we know, before our users tell us, that something is degraded?

To answer those two questions, my work is organised around four areas.

### Devnets

Spinning up a complete blockchain network used to be slow, painful to set up and hard to maintain. I maintain [Kurtosis](https://github.com/kurtosis-tech/kurtosis) packages ([kurtosis-cdk](https://github.com/0xPolygon/kurtosis-cdk/), [kurtosis-pos](https://github.com/0xPolygon/kurtosis-pos), [optimism-package](https://github.com/agglayer/optimism-package)) that do it in minutes, on a laptop or in CI. As of November 2026, kurtosis-cdk alone has 80 stars, 131 forks and 48 contributors on GitHub.

### Monitoring

Once a service is live, the goal is to detect problems as soon as possible, especially before our users do. To get there, we use our services the way a user would: independent checks run on a schedule from several regions around the world, across dozens of types of checks. For example, sending transactions to a network and measuring how long they take to be included, or how long assets take to be bridged from one network to another. On top of that, we define service level indicators and objectives (what "working well" means, as a number) for the services that matter most.

### Testing

Automated tests that run against those devnets, and beyond: they only need an RPC endpoint, so they can also target other environments, including real networks. They send transactions, bridge assets and check that everything behaves, up to more complex scenarios such as hard forks (network upgrades). They run in CI, locally, and can also be run by AI agents, for example during nightly test campaigns. Together, the AggLayer and PoS suites hold hundreds of test cases.

### Tooling

A command-line toolbox for blockchain developers and operators, in the spirit of [foundry](https://github.com/foundry-rs/foundry). [polygon-cli](https://github.com/0xPolygon/polygon-cli/) puts everyday operations behind one consistent tool: load-testing a network, browsing blocks with a blockchain explorer in the terminal, creating and funding wallets, and more.

## A typical day

Before generative AI, my work followed a simple loop: backlog, tickets, design, implementation, tests, delivery. When a bug or an incident came in, I would spend a few hours to several days digging until I found the cause, sometimes a whole week, then ship the fix. Proofs of concept (small prototypes to check that an idea works) could take just as long, sometimes weeks.

With strong generative AI, the work looks different. I write specs, have them reviewed by AI agents, ask other agents to implement them, others to test, and I deliver after checking that everything runs. It is not less work, just different work: less time writing code, more time deciding what to build, defining what "done" means and verifying the result.

The result is a change of scale. I can handle far more work than before, because several agents work in parallel while I write specs and review results, instead of doing each step one after the other. And I can tackle harder problems, including some I did not master: an agent can write code in a language or a tool I know less well, explore several approaches in a few minutes, or explain an unfamiliar codebase.

The other half of the job is building the harness around the agents (the instructions, tools and checks they work with) and tightening the feedback loop.

In plain words: I used to be a bit like a blacksmith, shaping every piece by hand and polishing it to make it as perfect as possible. Today I am closer to an orchestra conductor: I do not play every instrument myself, I brief a team of very capable AI assistants, check what they deliver, and keep improving the instructions and checklists I give them, so that they get it right more often, for less money, without me watching over their shoulder.

The [projects](/projects) page has more on what I have worked on.

_This article was written with the help of AI (Claude Sonnet 5.5), from my ideas and under my review. Which, fittingly, is the way of working it describes._
