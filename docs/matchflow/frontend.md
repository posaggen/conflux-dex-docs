If you want to develop a decentralized exchange (DEX) on Conflux chain, MatchFlow is a good choice for you to quickly get start.

# Why MatchFlow
MatchFlow provides APIs to place/cancel orders and query market data. Therefore, you need only to develop a mobile app or web page, and integrates with MatchFlow <a href="../conflux-dex-api.html" target="_blank">REST API</a> and [WebSocket API](ws.md). Besides, MatchFlow API allow to set specific trade fee rate/recipient, app could earn trade fee from every order matching.

# Migrate from CEX
MatchFlow provides standard REST and WebSocket APIs following popular centralized exchanges. Any centralized exchange app or web page could easily migrate to Conflux DEX. The only difference between decentralized exchange (DEX) and centralized exchange (DEX) is that Conflux DEX do not requires username/password based login. Instead, Conflux DEX requires user signature to validate authority when user want to place or cancel orders.

# EIP712 Signature
Some REST APIs requires user signature to change user assets:

- Place order
- Cancel order
- Withdraw
- Transfer

Conflux DEX follow the way of EIP712 to validate signed messages, any app based on MatchFlow is required to follow the [type schema](eip712.md) to sign messages. [boomflow frontend SDK](https://www.npmjs.com/package/boomflow-frontend) is the recommended SDK to interact with MatchFlow for signature required REST APIs.