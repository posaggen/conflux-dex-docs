# The Shuttleflow Smart Contracts Design and Implementation

## Design Goals

The Shuttleflow smart contracts have following design goals:

1. Support atomic mapping between Conflux cToken and cross chain assets including BTC, ETH and USDT.
2. Maintain the membership and authority of custodian alliance.
3. Pausable and upgradable, data migration.

## Components (on Conflux)

### CustodianCore

`CustodianCore` (contracts/core/CustodianCore.sol) is the main contract of custodian 
alliance on Conflux chain. It maintains the information of custodian members and configurations for 
custodian nodes, including:
* Custodian member's address/public key of different chain
* The address of all cTokens and their binding CRC-L address
* The upper/lower bounds of custodian alliance's bitcoin hot wallet
* The withdraw operation fee for bitcoin
* Processed user mint requests (indexed by payment transaction id on other block chain)

Ownership and authorities: 
* At this point, the owner of CustodianCore is Conflux admin, who is enabled to modify 
custodian node configurations and custodian membership.
* CustodianCore is the owner of all cToken so only it has the authority to mint cTokens.

Core Functions: 
```solidity 
function mint(string calldata token, 
    address to, 
    uint amount, 
    string calldata tx_id, 
    bytes calldata signatures
) external onlyCustodian whenNotPaused;
```
Mint cToken for a user and then send the minted cToken to its binding CRC-L 
contract with default operator authority, trigger the callback of CRC-L contract and CRC-L
 will mint corresponding amount CRC-L token for user. This functions needs over 2/3 signatures
  from current custodian members.
```solidity
function btcHotToCold(
        uint256 nonce,
        uint256 btc_cold_balance,
        bytes memory signatures
) public onlyCustodian whenNotPaused
``` 
This function will be called periodically by custodian nodes. It 
checks if the balance of custodian alliance's bitcoin hot wallet is larger than the 
upper bound and computes the amount of bitcoin they need to transfer to cold wallet.
 This functions needs over 2/3 signatures from current custodian members.

### TokenBase

`TokenBase` (contracts/token/TokenBase.sol) is the cross chain token contract (cToken).
 It is a ERC777 standard token.

Owership and autorities:
* Owner of cToken is initially who deployed it (Conflux admin), then its owner will transfer 
the ownership to CustodianCore contract. Only owner of the contract is able to mint cToken.
* Only pausers are able to pause/unpause the cToken contract. Initially, the pauser 
of cToken is Conflux admin, the pauser can add other pausers.

Core Functions:

TokenBase inherited from a pausable ERC777 contract, besides ERC777 standard functions, it also 
implemented following functions for cross chain:
```solidity
function mint(
    address account,
    uint256 amount,
    string memory tx_id
) public onlyOwner whenNotPaused returns (bool);
```
Owner authority required. Mint tokens for user. Emits `Minted(address indexed toAddress, uint256 indexed amount, string tx_id)` event,
 the custodian nodes listen to this event and know a mint request from user is done.
```solidity
function burn(
    address useraddr,
    uint256 amount,
    string memory addr
) public whenNotPaused returns (bool);
```
Burn cToken from sender's address, Emits `Burnt(uint256 indexed amount, string toAddress, address indexed fromAddress)`
event, the custodian nodes listen to this event and will withdraw cross chain assets to `toAddress`, which is a bitcoin/eth address.

## Components (on Ethereum)

### EthFactory 

Similar to `CustodianCore`, `EthFactory` (contracts/factory/EthFactory.sol) is the main contract of custodian 
alliance on Ethereum chain. It maintains the information of custodian members and configurations for 
custodian nodes, including:
* Custodian member's ethereum address
* The address of all supported erc20 tokens in Shuttleflow (USDT for now)
* The upper/lower bounds of custodian alliance's eth&erc20 hot wallet
* The withdraw operation fee for eth/erc20
* Processed user mint requests (indexed by withdraw transaction id on Conflux)
Ownership and authorities: 
* At this point, the owner of EthFactory is Conflux admin, who is enabled to modify 
custodian node configurations and custodian membership.
* CustodianCore is the owner of all cToken so only it has the authority to mint cTokens.

Core Functions:

```solidity
function burn(
    address payable toAddress,
    uint amount,
    string memory tx_id,     
    bytes memory signatures
) public onlyCustodian onlyAlive;
```
Owner authority required. Withdraw eth/erc20 token to user's address. This functions needs over 2/3 signatures from current custodian members.
```solidity
function transferHotToCold(
    uint256 nonce,
    bytes memory signatures
) public onlyCustodian onlyAlive;
```
Will be called by custodian node periodically. Automatically transfer 
eth/erc20 token from hot wallet to cold wallet (both maintained by variables in EthFactory) 
if hot wallet balance is larger than upper bound. This functions needs over 2/3 signatures from current custodian members.
```solidity
function transferColdToHot(
    string memory token,
    uint256 amount,
    uint256 nonce,
    bytes memory signatures
) public onlyCustodian onlyAlive;
```
Transfer specified amount of eth/erc20 token from cold wallet to hot wallet. 
This functions needs over 2/3 signatures from current custodian members using their cold wallet private key.

### ReceiveWallet

`ReceiveWallet`(or payment wallet) (contracts/factory/ReceiveWallet.sol) is the contract of user payment wallet (in other
 words, the receive wallet for custodian alliance). The receive wallet can only transfer eth/erc20 token 
 to the address of EthFactory, which is initialized when receive wallet contract construction and can not
 be modified in future. 

Core Functions:
```solidity
function retrieve() public;
```
Transfer all eth to EthFactory contract.
```solidity
function retrieveToken(address token) public;
```
Transfer all erc20 token to EthFactory contract.

### Create2Factory

`Create2Factory` (contracts/factory/Create2Factory.sol) is the generator of user payment wallet. 
It can calculate the address of payment wallet of a specific user conflux address before the 
payment wallet contract is really deployed.

This contract enable the custodian alliance provide the payment wallet address to user and 
deploy the payment wallet contract after they received at least one payment from user. 
