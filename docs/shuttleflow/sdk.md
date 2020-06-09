Conflux Shuttleflow SDK
====
https://www.npmjs.com/package/conflux-crosschain
## Functions 
```
// get ethereum receive wallet address (used for both eth & usdt) of user.
// when user send money to receive wallet, custodian will directly deposit the 
// money to conflux dex.
// user_address: conflux address of user
// node_url: url of running crosschain custodian node
async function getUserReceiveWalletEth(user_address, node_url);

// get bitcoin receive wallet address (used for both eth & usdt) of user.
// when user send money to receive wallet, custodian will directly deposit the 
// money to conflux dex.
// user_address: conflux address of user
// node_url: url of running crosschain custodian node
async function getUserReceiveWalletBtc(user_address, node_url);

// burn request are processed by dex CRC-L and is deprecated in this sdk.

// get user mint/burn operation list.
// data: JSON object
// {
//    address: (String) user conflux address,
//    types: (array of String) subset of {"eth_mint", "eth_burn", "erc20_mint", "erc20_burn", "btc_mint", "btc_burn"},
//    status: (array of String) subset of {"doing", "finished"},
// }
// skip: the number of leading results to be ignored
// cnt: the maximum number of results to return
// node_url: url of running crosschain custodian node
async function getUserOperationList(data, skip, cnt, node_url);
```
## Const parameters for test
```
crosschain.test_conf = {
  usdt_addr: // usdt address on rinkeby testnet,
  node_url: // custodian node url,
};
```
## Examples
Import crosschain module.
```
const crosschain = require('crosschain');
const test_conf = crosschain.test_conf;
```
get receive wallet address of a user:
```
let receive_wallet = crosschain.getUserReceiveWalletEth(
    '0x6B6C3A1eC5C689C3dd158b1a6E8Bc722373a2BfA', 
    test_conf.node_url
);

// send eth to receive_wallet, custodian will mint cETH for users and then transfer them to CRC-L.
// user's cETH will be locked in the address of CRC-L of cETH.
```
get user operation list:
```
crosschain.getUserOperationList({
  address: '0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5',// for example
  types: ['eth_mint', 'eth_burn', 'erc20_mint'],
  status: ['finished', 'doing'],
}, 0, 100, test_conf.node_url).then(console.log);

/*
{ txs:
   [ { type: 'eth_mint',
       nonce_or_txid:
        '0xacf0ae864689f19789ea43cdc3daf0fa41fdeb5392dfe5291c6aab1a4b6c128b',
       amount: '1000000000000000',
       user_addr: '0x65CF2b2c91e6eff901F10ab7363ae58cf1bfCCc5',
       to_addr: '0x65CF2b2c91e6eff901F10ab7363ae58cf1bfCCc5',
       signer: [ 'fafa' ],
       has_signed: true,
       need: 2,
       status: 'doing' },
     { type: 'cUSDT_mint',
       nonce_or_txid:
        '0x6eb599af3ab6242260dada6f6b57dad91faa64518d7cf1ac4a975f7f718a8b29',
       amount: '100000',
       user_addr: '0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5',
       to_addr: '0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5',
       status: 'finished' },
     { type: 'cUSDT_mint',
       nonce_or_txid:
        '0x490ae855b02c50d57eafd96351359e21bc689a1385443f33a764121f22b84b2b',
       amount: '100000',
       user_addr: '0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5',
       to_addr: '0x65cf2b2c91e6eff901f10ab7363ae58cf1bfccc5',
       status: 'finished' } ],
  total: 3 }
*/
```
get mintable status:
```
crosschain.isMintable(test_conf.node_url).then(console.log);

true
```
