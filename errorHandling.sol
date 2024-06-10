// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorHandlingExample {
    
    uint256 public balance;
    address public owner;
    
    constructor() {
        owner = msg.sender;
        balance = 0;
    }
    
    // Function to deposit ether to the contract
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balance += msg.value;
    }
    
    // Function to withdraw ether from the contract
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(amount <= balance, "Insufficient balance");

        // This is a sanity check, balance should never be negative
        assert(balance >= amount);

        balance -= amount;
        payable(owner).transfer(amount);
    }

    // Function to reset the contract (only owner can reset)
    function resetContract() public view  {
        require(msg.sender == owner, "Only the owner can reset the contract");
        revert("Contract reset has been reverted for demonstration purposes");
    }

    // Function to get the current balance of the contract
    function getBalance() public view returns (uint256) {
        return balance;
    }
}
