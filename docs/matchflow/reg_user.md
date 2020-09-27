Unlike the centralized exchange, Conflux DEX do not require user to register an account via REST API in MatchFlow. Because, Conflux DEX is a decentralized exchange and user assets are all locked in smart contracts on Conflux chain. User need to interact with CRC-L contract for user registration in Conflux DEX.

# Add User
When user deposit assets into CRC-L contracts, MatchFlow listens and polls the `deposit` event data once the `deposit` transaction executed and confirmed on Conflux chain. After that, MatchFlow will add or update the account balance in off-chain ledger (database). Generally, the transaction confirmation time on Conflux chain is no more than one minute, so user will be able to place orders after one minute of deposit.

# API
The recommended way to deposit assets is using [boomflow frontend SDK](https://www.npmjs.com/package/boomflow-frontend), and the available asset list could be retrieved from MatchFlow REST API <a href="../conflux-dex-api.html#_get_currencies" target="_blank">getCurrencies</a>. Each asset has two contract addresses:

- `contractAddress`: asset CRC-L contract address, which is used for DEX only.
- `tokenAddress`: asset ERC777 token contract address, which is used for any dapps.

With boomflow frontend SDK, user assets could be easily depsoited from ERC777 contract to CRC-L contract.