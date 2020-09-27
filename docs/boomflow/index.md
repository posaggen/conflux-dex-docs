# Welcome to BoomFlow

**BoomFlow** contains two kinds of smart contracts: CRC-L and Boomflow. CRC-L stands for **CRC Lock**, it is used to lock user assets and only the authrized user or contract could change the user assets. Now, each asset has a separate CRC-L contract. Boomflow contract is responsible for trade settlement and authrized to change user assets in CRC-L contracts. Now, these contracts are not open sourced yet, and only the [Matchflow](../matchflow/index.md) has authrity to access these contracts.

# Javascript SDK
There are two Javascript SDKs available on `npm` for frontend and backend respectively. Each SDK enables whitelisted users to call functions in smart contracts directly or interact with Conflux DEX REST APIs to place/cancel orders.

- [boomflow](https://www.npmjs.com/package/boomflow): SDK for backend development. Usually, it uses private key or keyfile to sign messages.
- [boomflow frontend](https://www.npmjs.com/package/boomflow-frontend): SDK for frontend development. Usually, it uses [Conflux Portal](http://portal.conflux-chain.org/) to sign messages.
