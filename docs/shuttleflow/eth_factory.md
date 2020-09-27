### EthFactory 

`EthFactory` (contracts/factory/EthFactory.sol) is the governance contract of custodian 
alliance on Ethereum chain. It maintains the information of custodian members and configurations for 
custodian nodes, including:
* Custodian member's ethereum address
* The registered defi relayer contracts.
* The upper/lower bounds of custodian alliance's eth&erc20 hot wallet
Ownership and authorities: 
* At this point, the owner of EthFactory is Conflux admin, who is enabled to modify 
custodian node configurations and custodian membership.
* CustodianCore is the owner of all cToken so only it has the authority to mint cTokens.

Upgrade:
* EthFactory follows proxy delegate pattern which enables upgrading contract logic without modification of 
contract address and get rid of data migration.

###Core Functions:
```solidity
function burn(
        address token,
        address payable toAddress,
        address payable defi_relayer,
        uint256 amount,
        string memory tx_id,
        bytes[] memory signatures
) public;
```
Only custodian member can call it. 

Withdraw eth/erc20 token to user's address. This functions needs over 2/3 signatures from current custodian members.

If provided `defi_relayer` is registered, the token will be sent to `defi_relayer` by calling its `deposit` for `depositToken`.

Specifically, if token is zero address(denote ETH) and defi_relayer is not used, the withdrawed eth will be firstly 
sent to the `msg.sender`(custodian member who settled this burn request), and then `msg.sender` will send these ETH to 
`toAddress`(user address). This avoids some user withdraw ETH directly to the address of some centralized exchange, 
which is not able to detect the internal ETH transaction in a contract call.

### ReceiveWallet

`ReceiveWallet`(or payment wallet) is the contract of receive wallet of custodian alliance for user. 
The receive wallet can only transfer eth/erc20 token to the address of EthFactory, which is initialized when receive wallet contract construction and can not
 be modified in future. 

Core Functions:
```solidity
function retrieve(
        address token, // erc20 address or zero address for ETH
        uint256 deploy_fee,
        uint256 retrieve_fee
) public;
```
Only custodian member or Create2Factory contract can call it. 

Transfer all eth/erc20 token to EthFactory contract. Where deploy_fee is the fee for 
deployment of receive wallet, retrieve_fee is the fee for custodian member to move these 
token from user's receive wallet to hot wallet(governance contract).
### Create2Factory

`Create2Factory` is the generator of user payment wallet. 
It can calculate the address of payment wallet of a specific user conflux address before the 
payment wallet contract is really deployed.

This contract enable the custodian alliance provide the payment wallet address to user and 
deploy the payment wallet contract after they received at least one payment from user. 

```solidity
function deploy(
        bytes memory code,
        uint256 salt,
        address token,
        uint256 deploy_fee,
        uint256 retrieve_fee
) public;
```
Only custodian member can call it. 

Deploy the receive wallet of user for specific defi(encoded in `salt`), and call the `retrieve` function 
of the receive wallet deployed, with deploy_fee.
