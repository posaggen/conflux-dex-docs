#Conflux Shuttleflow SDK
https://www.npmjs.com/package/conflux-crosschain
## Functions 
```
// get ethereum receive wallet address (used for both eth & usdt) of user.
// when user send money to receive wallet, custodian will directly deposit the 
// money to specified defi.
// user_address: conflux address of user
// defi: the address of defi user want deposit to, see getDefiList below
// node_url: url of running crosschain custodian node
async function getUserReceiveWalletEth(user_address, defi, node_url);

// get bitcoin receive wallet address (used for both eth & usdt) of user.
// when user send money to receive wallet, custodian will directly deposit the 
// money to specified defi.
// user_address: conflux address of user
// defi: the address of defi user want deposit to, see getDefiList below
// node_url: url of running crosschain custodian node
async function getUserReceiveWalletBtc(user_address, defi, node_url);

// get user mint/burn operation list.
// data: JSON object
// {
//    address: (String) user conflux address,
//    type: 'mint' or 'burn'
//    defi: defi address
//    token: btc/eth/erc20 token address
//    status: (array of String) subset of {"doing", "finished"},
// }
// skip: the number of leading results to be ignored
// cnt: the maximum number of results to return (maximum 100)
// node_url: url of running crosschain custodian node
async function getUserOperationList(data, skip, cnt, node_url);

// get supported token list.
// return value: array of object:
 {
    reference: string ('btc'/'eth'/ erc20 token address),
    burn_fee: string (withdraw fee),
    mint_fee: string (mint fee),
    wallet_fee: string (receive wallet deployment fee),
    minimal_mint_value: string,
    symbol: string (cToken name),
    decimals: number (token decimals, e.g. btc is 8, eth is 18, usdt is 6),
    sponsor_value: string (amount of cETH sponsored),
    is_admin: bool (is admin token or not),
    ctoken: string (cToken conflux address)
 }
async function getTokenList(node_url);

// get supported defi list.
// return value: array of object: 
{ 
    defi_name: string (defi name),
    defi_addr: string (defi conflux address) 
}
async function getDefiList(node_url);

// get burn fee of specific token. In 18 decimals.
// token: 'eth' / 'btc' / erc20 address
// return value: string, burn fee of corresponding erc777 token
{
    burn_fee: string,
    mint_fee: string,
    wallet_fee: string,
}
async function getTokenBurnFee(token, node_url);
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
    '0x0000000000000000000000000000000000000000',
    test_conf.node_url
);

0xcc3b0e18c91fc1cd665dc9ec4d4f733971e8f556
// send eth to receive_wallet, custodian will mint cETH for users and then transfer them to CRC-L.
// user's cETH will be locked in the address of CRC-L of cETH.
```
get user operation list:
```
crosschain.getUserOperationList({
  address: '0x1f04dcc0432b2df7ce604f0ad4736cadf5ed04ea',// for example
  type: 'mint',
  token: 'eth',
  defi: '0x0000000000000000000000000000000000000000',
  status: ['finished', 'doing'],
}, 0, 100, test_conf.node_url).then(console.log);

{ txs:
   [ { token: 'eth',
       type: 'cETH_mint',
       nonce_or_txid:
        '0x19d57ec6f769dd42e75d339ada0a2c6ce94ecb6a0eea99447ba05898cdc4a421',
       amount: '495000000000000000',
       user_addr: '0x1f04dcc0432b2df7ce604f0ad4736cadf5ed04ea',
       defi: '0x0000000000000000000000000000000000000000',
       to_addr: '0x1f04dcc0432b2df7ce604f0ad4736cadf5ed04ea',
       status: 'finished',
       settled_tx:
        '0x6fca35357dcb1f8f0a4bfab4bf09a4386568742dab1b312da3beb8863171dafe' },
     { token: 'eth',
       type: 'cETH_mint',
       nonce_or_txid:
        '0x8f5ff6efaafe224223e87e1291b9684bc07f09293793a903b0ec94ff8f623fde',
       amount: '505000000000000000',
       user_addr: '0x1f04dcc0432b2df7ce604f0ad4736cadf5ed04ea',
       defi: '0x0000000000000000000000000000000000000000',
       to_addr: '0x1f04dcc0432b2df7ce604f0ad4736cadf5ed04ea',
       status: 'finished',
       settled_tx:
        '0x29fe0c47e79934b16ba71d40e3c9c124c4ae7ee03e61336568fd3b9870313872' } ],
  total: 2 }
```
get mintable status:
```
crosschain.isMintable(test_conf.node_url).then(console.log);

true
```
get defi list:
```
crosschain.getDefiList(test_conf.node_url).then(console.log);

[ { defi_name: 'Conflux Token',
    defi_addr: '0x0000000000000000000000000000000000000000' },
  { defi_name: 'Conflux DEX',
    defi_addr: '0x8595b7822db70040b6bb30e87bd26eeb66576b37' } ]
```
get token list:
```
crosschain.getTokenList(test_conf.node_url).then(console.log);

[ { reference: 'eth',
    burn_fee: '5000000000000000',
    mint_fee: '5000000000000000',
    wallet_fee: '5000000000000000',
    minimal_mint_value: '10000000000000000',
    symbol: 'cETH',
    decimals: 18,
    sponsor_value: '5000000000000000000',
    is_admin: true,
    ctoken: '0x83dfad4705a2bcf8b961bf0fdeac2f22738dc74f' },
  { reference: 'btc',
    minimal_mint_value: '100000',
    symbol: 'cBTC',
    decimals: 8,
    sponsor_value: '0',
    ctoken: '0x8a957d0e7b9b607ef71f4505c3f4bc73b65130d5' },
  { reference: '0x54cc2fbf8733c27984503025d5d2537b29af8054',
    burn_fee: '1000000',
    mint_fee: '1000000',
    wallet_fee: '1000000',
    minimal_mint_value: '1000000',
    symbol: 'cUSDT',
    decimals: 6,
    sponsor_value: '10000000000000000000',
    is_admin: true,
    ctoken: '0x8ea4eefd4fcdb6ad659584166f4c8f083133002d' },
  { reference: '0x6b175474e89094c44da98b954eedeac495271d0f',
    burn_fee: '1000000000000000000',
    mint_fee: '1000000000000000000',
    wallet_fee: '1000000000000000000',
    minimal_mint_value: '1000000000000000000',
    symbol: 'cDAI',
    decimals: 18,
    sponsor_value: '1000000000000000000',
    is_admin: true,
    ctoken: '0x8008e2134e001a946fe52e011aef0d01ba834762' },
  { reference: '0xc00e94cb662c3520282e6f5717214004a7f26888',
    burn_fee: '5000000000000000',
    mint_fee: '5000000000000000',
    wallet_fee: '5000000000000000',
    minimal_mint_value: '5000000000000000',
    symbol: 'cCOMP',
    decimals: 18,
    sponsor_value: '1000000000000000000',
    is_admin: false,
    ctoken: '0x80f14a1b69dae80bcbc4bdd2dd381418a92e1e8b' },
  { reference: '0x431ad2ff6a9c365805ebad47ee021148d6f7dbe0',
    burn_fee: '3000000000000000000',
    mint_fee: '3000000000000000000',
    wallet_fee: '3000000000000000000',
    minimal_mint_value: '3000000000000000000',
    symbol: 'cDF',
    decimals: 18,
    sponsor_value: '1000000000000000000',
    is_admin: false,
    ctoken: '0x8c046fbcd70a23e0c34f8dfecda0c582a4fe72b5' },
  { reference: '0xdd974d5c2e2928dea5f71b9825b8b646686bd200',
    burn_fee: '1000000000000000000',
    mint_fee: '1000000000000000000',
    wallet_fee: '1000000000000000000',
    minimal_mint_value: '1000000000000000000',
    symbol: 'cKNC',
    decimals: 18,
    sponsor_value: '1000000000000000000',
    is_admin: false,
    ctoken: '0x8f1624956129064805bb8b239d185f12b5d8aacc' } ]
```
