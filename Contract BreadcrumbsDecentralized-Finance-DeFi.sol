// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract DeFiProtocol {
    struct Deposit {
        uint256 amount;
        uint256 depositTime;
    }

    struct Borrow {
        uint256 amount;
        uint256 borrowTime;
    }

    mapping(address => Deposit) public deposits;
    mapping(address => Borrow) public borrows;

    ERC20 public token;
    uint256 public totalDeposits;
    uint256 public totalBorrows;

    constructor(address _token) {
        token = ERC20(_token);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        deposits[msg.sender].amount += amount;
        deposits[msg.sender].depositTime = block.timestamp;
        totalDeposits += amount;
    }

    function withdraw(uint256 amount) external {
        require(deposits[msg.sender].amount >= amount, "Insufficient balance");
        
        deposits[msg.sender].amount -= amount;
        totalDeposits -= amount;

        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

    function borrow(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(totalDeposits >= totalBorrows + amount, "Insufficient liquidity");

        borrows[msg.sender].amount += amount;
        borrows[msg.sender].borrowTime = block.timestamp;
        totalBorrows += amount;

        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

    function repay(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(borrows[msg.sender].amount >= amount, "Overpayment not allowed");

        borrows[msg.sender].amount -= amount;
        totalBorrows -= amount;

        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    function getDepositDetails(address account) external view returns (uint256 amount, uint256 depositTime) {
        return (deposits[account].amount, deposits[account].depositTime);
    }

    function getBorrowDetails(address account) external view returns (uint256 amount, uint256 borrowTime) {
        return (borrows[account].amount, borrows[account].borrowTime);
    }
}
