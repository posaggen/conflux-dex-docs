### DepositRelayer

`DepositRelayer` is used for user to initiate a crosschain transaction.

#### Contract ABI

[DepositRelayer ABI](contracts/DepositRelayerABI.json)

#### Core Functions

```solidity
function deposit(address confluxAddr, address defiAddr) public payable;
```

For users want to crosschain native token such as ETH/BNB, they should call this function and transfer the value they want to crosschain. 

`confluxAddr` is user's Conflux recipient address in hex format.

`defiAddr` should be zero address.

```solidity
function depositToken(
    address tokenAddr,
    address confluxAddr,
    address defiAddr,
    uint256 value
) public;
```

For users want to crosschain ERC20 token, they should first approve enough allowance for DepositRelayer contract, and then call this function. 

`tokenAddr` is the ERC20 token address.

`confluxAddr` is user's Conflux recipient address in hex format.

`defiAddr` should be zero address.

`value` is amount of ERC20 token user want to crosschain.