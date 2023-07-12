// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;
    uint256 public balance;
    uint256 public maxWithdrawalAmount;

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    constructor(uint256 initBalance, uint256 maxWithdrawal) payable {
        owner = payable(msg.sender);
        balance = initBalance;
        maxWithdrawalAmount = maxWithdrawal;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        uint256 previousBalance = balance;

        // Perform transaction
        balance += msg.value;

        // Assert transaction completed successfully
        assert(balance == previousBalance + msg.value);

        // Emit the event
        emit Deposit(msg.sender, msg.value);
    }

    // Custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);
    error ExceedsMaxWithdrawal(uint256 maxWithdrawal);

    function withdraw(uint256 withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");

        uint256 previousBalance = balance;

        if (balance < withdrawAmount) {
            revert InsufficientBalance(balance, withdrawAmount);
        }

        if (withdrawAmount > maxWithdrawalAmount) {
            revert ExceedsMaxWithdrawal(maxWithdrawalAmount);
        }

        // Withdraw the given amount
        balance -= withdrawAmount;

        // Assert the balance is correct
        assert(balance == previousBalance - withdrawAmount);

        // Transfer the funds to the owner
        owner.transfer(withdrawAmount);

        // Emit the event
        emit Withdraw(msg.sender, withdrawAmount);
    }

    function setMaxWithdrawal(uint256 newMaxWithdrawal) public {
        require(msg.sender == owner, "You are not the owner of this account");

        maxWithdrawalAmount = newMaxWithdrawal;
    }
}
