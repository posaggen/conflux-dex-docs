### TokenBase

`TokenBase` is the cross chain token contract (cToken).
It follows [ERC777 standard](https://eips.ethereum.org/EIPS/eip-777) except the `burn` function.

#### Owership and autorities
* Owner of cToken is initially who deployed it (Shuttleflow admin), then the ownership will be transfered to Shuttleflow governance contract. Only owner of the contract is able to mint cToken.
* Only pausers are able to pause/unpause the cToken contract. Initially, the pauser 
of cToken is Shuttleflow admin.

#### Contract ABI

[TokenBase ABI](contracts/TokenBaseABI.json)

#### Contract Interface

```solidity
pragma solidity 0.5.11;

interface ITokenBase {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external pure returns (uint8);

    function granularity() external pure returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOf(address tokenHolder) external view returns (uint256);

    function send(
        address recipient,
        uint256 amount,
        bytes calldata data
    ) external;

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function isOperatorFor(address operator, address tokenHolder)
        external
        view
        returns (bool);

    function authorizeOperator(address operator) external;

    function revokeOperator(address operator) external;

    function defaultOperators() external view returns (address[] memory);

    function operatorSend(
        address sender,
        address recipient,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external;

    function allowance(address holder, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address holder,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function mint(
        address account,
        uint256 amount,
        address fee_address,
        uint256 fee,
        address defi,
        string calldata tx_id
    ) external returns (bool);

    function burn(
        address user_addr,
        uint256 amount,
        uint256 expected_fee,
        string calldata addr,
        address defi_relayer
    ) external returns (bool);
}
```

#### Core Functions

TokenBase implements the functions of ERC777 standard, with a different burn function:
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

`amount` should be larger than `burn_fee` and `minimal_burn_value` in [CustodianCore](custodian_core.md) contract(Note here the decimals 
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