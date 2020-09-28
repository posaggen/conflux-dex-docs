### CustodianCore

`CustodianCore` is the governance contract of custodian 
alliance on Conflux chain. It maintains the information of custodian members and configurations for 
custodian nodes, including:
* Custodian member's address/public key of different chain
* The address of all cTokens and their configurations such as mint/burn fee
* The information of token sponsors
* The upper/lower bounds of custodian alliance's bitcoin hot wallet

Ownership and authorities: 
* At this point, the owner of CustodianCore is Conflux admin, who is enabled to modify 
custodian node configurations and custodian membership.
* CustodianCore is the owner of all cToken so only it has the authority to mint cTokens.

Upgrade:
* Custodian core follows proxy delegate pattern which enables upgrading contract logic without modification of 
contract address and get rid of data migration.

####Core Storage Variables
```solidity
ITokenBase[] public token_list;
```
Registered cTokens.
```solidity
mapping(address => string) public token_reference;
```
Mapping of cToken address to external chain assets(reference), reference can be 'eth'/'btc'/lowercase erc20 address.

For example, 

cETH address => 'eth',

cBTC address => 'btc', 

cUSDT address => '0xdac17f958d2ee523a2206206994597c13d831ec7'.
```solidity
mapping(address => uint8) public token_decimals;
```
Mapping of cToken address to external chain decimals.

For example, 

cETH address => 18,

cBTC address => 8, 

cUSDT address => 6.
```solidity
mapping(string => bool) public admin_token;
```
Denote each cToken is admin token or not.

Admin token can only be sponsored by whitelist admin of custodian core contract, and will maintain both 
hot and cold wallet. For non-admin token, anyone can be its sponsor and only hot wallet will be maintained.

```solidity
mapping(string => address) reference_token; // inverse token_reference
```
Anti mapping of `token_reference`.
```solidity
mapping(string => uint256) public burn_fee;
```
The fee taken from user during cToken burn. Note the decimals is decimals of the reference token.

For example, the sponsor want to take 0.1 cUSDT when user burn cUSDT, here burn_fee['usdt'] should be 0.1 * 1e6.
```solidity
mapping(string => uint256) public mint_fee;
```
The fee taken from user during cToken mint. Note the decimals is decimals of the reference token.
```solidity
mapping(string => uint256) public wallet_fee;
```
When a user want to migrate token from ethereum to conflux, his/her receive wallet will be 
deployed firstly if it is not deployed before. `wallet_fee` denote the fee taken from user during 
deployment of receive wallet. Note the decimals is decimals of the reference token.
```solidity
mapping(string => uint256) public minimal_mint_value;
```
The remaining value of reference token in user's receive wallet must be larger than minimal mint value, otherwise the custodian alliance will not mint for it.

**Note**: for btc, use `btc_minimal_mint_value`.
```solidity
uint256 public btc_minimal_mint_value
```
cBTC minimal mint value.
```solidity
uint256 public btc_minimal_burn_value;
```
cBTC minimal burn value.
```solidity
mapping(string => uint256) public minimal_burn_value;
```
The minimal burn value of corresponding cToken, the burn will fail if burn value is not enough. 
 
**Note**: for btc, use `btc_minimal_mint_value`.
```solidity
mapping(string => uint256) public minimal_burn_value;
```
The minimal burn value of corresponding cToken, the burn will fail if burn value is not enough. 
```solidity
mapping(string => uint256) public token_cooldown; // second
```
This can only set by custodian core whitelist admin. The token spnosor should not 
change the token parameters frequently, so the sponsor must wait a cooldown after 
the token parameters is changed.
####Core Functions: 
```solidity 
function sponsorToken(
        string memory ref, // lowercase erc20 ethereum address
        uint256 amount, // amount of cETH mortgaged
        uint256 _burn_fee, // burn fee of erc20 token, in erc20 decimals
        uint256 _mint_fee, // mint fee of erc20 token, in erc20 decimals
        uint256 _wallet_fee, // receive wallet fee of erc20 token, in erc20 decimals
        uint256 _minimal_mint_value, // minimal mint value of erc20 token, in erc20 decimals
        uint256 _minimal_burn_value // minimal burn value of erc20 token, in erc20 decimals
) public;
```
This function can be called by anyone.

This function helps `msg.sender` become the sponsor of an erc20 token, specified by `ref`.

The governance contract will transfer `amount` cETH from `msg.sender` by operator authority, and compare the 
amount to the current sponsor of `ref`(if exists), the sponsor will be replaced by `msg.sender` if `amount` is large enough.
The token parameters of `ref` will also be replaced by the parameters sender provided, if the token is not in cooldown. 

For more information of sponsor replacement logic, see [token sponsor](token_sponsor.md).
```solidity 
function setTokenParams(
        string memory ref, // lowercase erc20 ethereum address
        uint256 _burn_fee,
        uint256 _mint_fee,
        uint256 _wallet_fee,
        uint256 _minimal_mint_value,
        uint256 _minimal_burn_value
) public;
```
This function can be called by anyone.

This function helps the sponsor of token `ref` to change the token parameters if the token is not in cooldown.
```solidity 
function mint(
        address defi, // conflux defi goverance contract address
        address token, // cToken address
        address to, // user conflux address
        uint256 amount, // user mint address
        uint256 fee, // user mint fee
        string memory tx_id, // corresponding ethereum/bitcoin mint transaction hash
        bytes[] memory signatures // signatures of custodian members
) public;
```
This function can only be called by custodian member's hot wallet address.

Mint cToken for a user and then send the minted cToken to receive smart contract of specific 
defi(if user assgined) with default operator authority. This functions needs over 2/3 signatures
  from current custodian members. The parameter `defi` is determined by user's receive wallet, when 
  defi is zero address or assgined defi does not support assgined token, the cToken will be left in user's conflux address.
  
For example, when defi is Boomflow contract and token is cETH address, the custodian alliance will firstly mint 
corresponding amount of cETH to user's conflux address, and then operator send these cETH to CRCL-ETH address. Then 
cETH will be locked in CRCL-ETH address and DEX-ETH will be minted to user.

