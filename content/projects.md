---
title: Projects
url: /projects
summary: projects
---

Some of the projects I have been working on, ranging from blockchain infrastructure to developer tooling and platform engineering.

## 2023-2026

Developer tooling and reliability for blockchain infrastructure at [Polygon Labs](https://polygon.technology/).

---

### 🛡️ Reliability

Measuring the reliability and performance of Polygon's critical services, so that regressions and outages are caught by data, as early as possible, rather than reported by users.

- Defined user journeys and service level indicators/objectives across blockchain networks (PoS, AggLayer, etc.) and applications (OMS/BPN, Sequence, Trails, wallets, web apps, etc.).
- Worked on an in-house synthetic monitoring stack that exercises services the way a user would: independent checks run on a schedule from several locations around the world. For example, sending transactions to blockchain networks (PoS, AggLayer, etc.) and measuring how long they take to be included, or how long assets take to be bridged from one network to another.
- Automated PoS network health reporting, replacing a manual check every 30 minutes.

---

### 📦 Kurtosis Packages

Packages that spin up a complete blockchain network on a laptop or in CI in minutes, for local development and integration testing.

Before, there was no unified development platform and no automated end-to-end tests in CI: testing a component against the rest of the stack was possible, but manual, painful to set up and hard to maintain.

Maintainer of:

- [0xPolygon/kurtosis-cdk](https://github.com/0xPolygon/kurtosis-cdk/)
- [0xPolygon/kurtosis-pos](https://github.com/0xPolygon/kurtosis-pos)
- [agglayer/optimism-package](https://github.com/agglayer/optimism-package)
- [leovct/kurtosis-test](https://github.com/leovct/kurtosis-test)

---

### 🧪 Testing

Automated end-to-end tests that exercise a complete network the way a user would (sending transactions, bridging assets). They run against Kurtosis devnets, in CI or locally, and can also be run by AI agents, for example during nightly test campaigns.

Contributor to:

- [agglayer/e2e](https://github.com/agglayer/e2e)
- 0xPolygon/pos-e2e

---

### 🔧 Blockchain Tools

Command-line tools that standardise and automate everyday blockchain development and operations tasks.

Contributor to:

- [0xPolygon/polygon-cli](https://github.com/0xPolygon/polygon-cli/)

---

### 💖 Open-source Contributions

Contributions to open-source tools and clients used across the Ethereum ecosystem.

- [kurtosis-tech/kurtosis](https://github.com/kurtosis-tech/kurtosis)
- [foundry-rs/foundry](https://github.com/foundry-rs/foundry)
- [paradigmxyz/reth](https://github.com/paradigmxyz/reth)
- [mds1/evm-diff](https://github.com/mds1/evm-diff)

## 2021-2022

A fresh start in the world of platform engineering at [Renault Software Factory](https://x.com/renaultgroup).

---

### ☸️ Kubernetes Operators

- Designed and implemented a Kubernetes operator to standardize configurations and automate deployments and updates of GitLab runners.
- Production deployment managing 50+ runners, operating 24/7, and executing thousands of jobs per week.
- Wrote [technical articles](https://github.com/leovct/kube-operator-tutorial) on building and testing Kubernetes operators.

---

### 👀 Monitoring

- Managed Kubernetes monitoring stack using Prometheus, Grafana, Karma, and Thanos.
- Infrastructure and application metrics monitoring

---

### 🌸 Chainlink Spring Hackathon

- [Everest Protocol](https://devpost.com/software/everest-ab708o): Attempted to build a DeFi protocol for trading synthetic assets (crypto following traditional asset prices like $TSLA) with two other crypto nerds (cc [@yvesbou](https://x.com/boutellier_yves)).
- Top 40 out of 400+ projects and 1,500+ participants
- Based on Chainlink oracles and Uniswap
- Deployed on Avalanche Fuji testnet
- 6-week hackathon
