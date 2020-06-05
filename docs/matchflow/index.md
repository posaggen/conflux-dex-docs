# Welcome to MatchFlow

**MatchFlow** provides REST API and WebSocket API to place/cancel orders or query market data. Now, MatchFlow have two environments main net and test net, which are used for real trading and simulated trading respectively.

## Environments

|API|MAINNET|TESTNET|COMMENT|
|---|-------|-------|-------|
|REST API|https://api.matchflow.io|https://dev.matchflow.io|<a href="conflux-dex-api.html" target="_blank">Document</a>|
|WebSocket API|wss://api.matchflow.io/ws|wss://dev.matchflow.io/ws|[Document](ws.md)|

***Note, only whitelisted users could access the APIs of main net.***

## Change Logs

### 2020/04/17
- Add new REST API: get incompleted orders.
- System Optimization: WebSocket, on-chain settlement.
- Fix bug in FC smart contract.
- Auto-pause mechansim in case of on-chain settlement exception.

### 2020/04/09
- Server migrate to Tokyo region.
- System optimization.

### 2020/03/26
- New features
    - Transfer in Conflux DEX
- REST API changes
    - New added
        - Transfer
        - List transfer records
    - Updated
        - Place order: add fee related fields

### 2020/03/11
- New features
    - Daily limit
- REST API changes
    - New added
        - Get daily limit of product
        - Get daily limit rate of product
        - Get last closing price of product
    - Updated
        - Currency: add ERC777 contract address

### 2020/03/06
- New features
    - Instant exchange
- REST API changes
    - New added
        - Get Boomflow address
    - Updated
        - Withdraw: add timestamp field
        - Place order: add timestamp field
        - Cancel order: add timestamp field
        - Cancel order by client order ID: add timestamp field
        - Get user: nonce removed
    - Removed
        - Batch cancel orders
        - User login/logout
