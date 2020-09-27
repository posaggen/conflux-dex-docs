### TokenBase

`TokenBase` is the cross chain token contract (cToken).
It follows ERC777 standard except burn function.

Owership and autorities:
* Owner of cToken is initially who deployed it (Conflux admin), then its owner will transfer 
the ownership to CustodianCore contract. Only owner of the contract is able to mint cToken.
* Only pausers are able to pause/unpause the cToken contract. Initially, the pauser 
of cToken is Conflux admin, the pauser can add other pausers.

Core Functions:

TokenBase implements the functions of ERC777 standard, with a different mint and burn function:
```solidity
function mint(
        address account, // user conflux address
        uint256 amount, // user mint amount
        address fee_address, // sponsor of the token
        uint256 fee, // mint fee, or mint fee + receive wallet fee
        address defi, // conflux defi 
        string memory tx_id // cross chain transaction hash
) public;
```
Owner authority required.
 
Mint tokens for user and mint tokens for token sponsor as fee.
```solidity
function burn(
        address user_addr, // user conflux address
        uint256 amount, // burn amount
        uint256 expected_fee, // expected burn fee, in 18 decimals
        string memory addr, // external chain receive address
        address defi_relayer // external chain defi relayer address
) public;
```
Burn cToken from sender's address.

`user_addr` is used to logging, in case Conflux Defi burn cToken for normal user.

`amount` should be larger than `burn_fee` and `minimal_burn_value` in CustodianCore contract(Note here the decimals 
of `amount` is 18 and decimals of `burn_fee` and `minimal_burn_value` in CustoidanCore contract is reference token's decimal, 
the smart contract will do the decimal conversion for comparison). Besides, if the fee is higher than
`expected_fee`, the burn transaction will revert.

`addr` is a ethereum or bitcoin address, which the reference token will be sent to.

If it is a burnt of eth/erc20 tokens, user can specify a `defi_relayer`, which will send 
the eth/erc20 to defi_relayer and logging the user's information. See more in [defi relayer](defi_relayer.md).

If user does not want to use `defi_relayer`, fill it with zero address.

For example,`burn(cusdt_address, 1e18, 1e16, user_eth_addr, zero_addr)` will burn 1 cUSDT and user 
is willing to pay no more than 0.01 cUSDT as burn fee to sponsor. The burned usdt will directly 
sent to user_eth_addr.