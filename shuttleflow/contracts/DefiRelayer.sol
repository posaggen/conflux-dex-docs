pragma solidity 0.5.11;

interface IERC20 {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external;
}

contract DefiRelayer {
    event Deposit(address indexed from, uint256 amount);
    event TokenDeposit(
        address indexed token,
        address indexed from,
        uint256 amount
    );

    constructor() public {}

    function deposit(address from, uint256 amount) public payable {
        require(msg.value == amount, "incorrect value");
        emit Deposit(from, amount);
    }

    function depositToken(
        address from,
        uint256 amount,
        address token
    ) public {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        emit TokenDeposit(token, from, amount);
    }
}
