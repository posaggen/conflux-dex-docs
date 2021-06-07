# Custodian Node

Each member of custodian alliance need to run a custodian node, all custodian nodes form
a p2p network.

## Design Goals

The custodian node have following design goals:

* Monitor conflux, ethereum smart contract events and bitcoin transactions to synchronize 
user requests and custodian operations, e.g. mint, burn.
* Collect signatures from other custodian nodes in p2p network, automatically send transactions on 
different blockchain to process user request or custodian operations when over 2/3 signatures are collected.
* Since the custodian alliance share one hot multi-signature wallet for bitcoin and ethereum, different 
custodian node should be consistent in the way to process an request, e.g., pick the same utxos of
bitcoin hot wallet for a user withdraw request.
* All communications with other custodian nodes should be validated.

## Components Design and Implementation

### Configuration

A custodian node should be configured with the private keys and other information 
of a custodian member, see [README](../README.md) for detail.

### P2P Network

All custodian nodes broadcast messages in a gossip p2p network with following 
configurations:

| Name   | Description  |
|---|---|
| p2p_throttle_duration  | p2p message throttle time window duration  |
| p2p_throttle_max  | maximum number of message from a socket in one time window  |
| fanout  | fan-out of p2p network  |

#### Connection Authentication

All new connection to a p2p server of custodian node will be authenticated. The request 
header of any new connection must has following three fields:

|  |   |
|---|---|
| timestamp  | utc timestamp when clients try to connect to server  |
| signer  | conflux address of a custodian member  |
| signature  | the signature of a custodian member for a message which is the concatenation of server host ip and timestamp |

On the server side, the signature is checked and the connection is authenticated if 
the timestamp is larger than any successful connections of signer before, which ensure 
the signature of same timestamp cannot be reused.


#### RPC

Custodian node provides multiple RPC for the frontend to display process of user operation and 
custodian alliance status. See JSON-RPC part of [README](../README.md).

#### Message Authentication

All incoming messages from other custodian node will be authenticated in two steps:

* The whole message should be signed by a current custodian member with its conflux private key. Furthermore, 
for different type of user operations, this ensure the message is sent by a custodian member.
* Each message contains the parameters of a specific operation, the hash of the operation and signature of hash of 
a valid custodian member. The custodian node who received this message will first compute the operation hash
with the operation parameters in the message and check if it is equal to the hash provided in the message, then 
validate the signature of hash. The operation hash here will also be checked in the smart contract of Shuttleflow when an
operation is settled on chain.

Since custodian member can change, if the message from a peer is signed by address which is not member 
of current custodian alliance, the connection will be dropped.

### User Payment Wallet

#### Ethereum Payment Wallet

The ethereum payment wallet for user is a smart contract on ethereum chain, 
which is used to receive eth and erc20 token from user. 

Each user has a unique payment wallet contract for specific conflux defi registered in conflux cross chain governance contract. When user transfer eth or erc20 token
to the payment wallet contract, the custodian alliance will mint corresponding cToken and CRC-L token 
for user.

#### Bitcoin Payment Wallet

The bitcoin payment wallet for user is a special multi-sig wallet with following bitcoin script(scriptPubKey):
```
${user_conflux_address}
${conflux_defi_address}
OP_DROP
${M}
${public_key_1}
${public_key_2}
...
${public_key_N}
${N}
OP_CHECKMULTISIG
````
where `${N}` is the total number of custodian members, `${M}` denotes the required minimum number of signatures 
from different custodian members, `${public_key_i}` is the public key of i-th custodian member.

Any one want to spend the utxo with the scriptPubKey above need to provide a scriptSig:
```
OP_0
${signature_1}
${signature_2}
...
${signature_M}
```

### Blockchain Monitoring

Custodian node will monitor the contract events emitted by Shuttleflow smart contract 
and bitcoin transaction to user payment wallet.

This table shows the contract event monitored by custodian node:

|Contract|Event|Description|
|---|---|---|
|CustodianCore|MemberChange|Custodian membership changed|
|CustodianCore|BtcHotToCold|New transfer operation from bitcoin hot wallet to cold wallet|
|TokenBase|Minted|User mint operation finished|
|TokenBase|Burnt|New user withdraw operation|
|EthFactory|BurnSuccess|User ETH withdraw operation finished|
|EthFactory|BurnSuccessERC20|User ERC20 withdraw operation finished|
|EthFactory|WalletTransfer|An operation using cold private key finished|
|EthFactory|shareProfitETH|Transferred profit(ETH) to a custodian member|
|EthFactory|shareProfitERC20|Transferred profit(ERC20) to a custodian member|
|EthFactory|HotToCold|Transfer from hot wallet to cold wallet finished|
|EthFactory|HotToColdDetail|Detail of a specific token of a HotToCold operation|
|ERC20(e.g. USDT)|Transfer|User pay to the payment wallet, new mint operation|

For bitcoin, since there is no smart contract and event, the operation params will be 
stored in `OP_RETURN` of any transaction sent from custodian alliance, the custodian monitor the 
bitcoin transactions to update local operation status.