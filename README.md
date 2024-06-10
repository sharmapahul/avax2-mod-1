
# ErrorHandlingExample Smart Contract

This smart contract demonstrates the use of `require()`, `assert()`, and `revert()` statements in Solidity for error handling. It includes functions for depositing and withdrawing Ether, and a function to reset the contract which demonstrates the use of `revert()`.

## Table of Contents

- [Overview](#overview)
- [Functions](#functions)
- [Usage](#usage)
- [Error Handling](#error-handling)
- [Development](#development)
- [License](#license)

## Overview

The `ErrorHandlingExample` contract allows an owner to deposit and withdraw Ether, and includes proper error handling mechanisms using Solidity's `require()`, `assert()`, and `revert()` statements.

## Functions

### Constructor

```solidity
constructor()
```

Initializes the contract, setting the deployer as the owner and the initial balance to 0.

### deposit

```solidity
function deposit() public payable
```

Allows anyone to deposit Ether into the contract. The deposit amount must be greater than zero.

### withdraw

```solidity
function withdraw(uint256 amount) public
```

Allows the owner to withdraw a specified amount of Ether from the contract. Ensures that the owner is the one initiating the withdrawal and that the contract has sufficient balance.

### resetContract

```solidity
function resetContract() public
```

Allows the owner to reset the contract. For demonstration purposes, this function always reverts the transaction.

### getBalance

```solidity
function getBalance() public view returns (uint256)
```

Returns the current balance of the contract.

## Usage

1. **Deploy the Contract**

   Deploy the `ErrorHandlingExample` contract using Remix, Truffle, or any other Ethereum development framework.

2. **Deposit Ether**

   Call the `deposit()` function to send Ether to the contract. The deposit amount must be greater than zero.

3. **Check Balance**

   Use the `getBalance()` function to check the current balance of the contract.

4. **Withdraw Ether**

   Call the `withdraw()` function to withdraw Ether from the contract. Only the owner can perform this action and the contract must have sufficient balance.

5. **Reset Contract**

   Call the `resetContract()` function. This will always revert the transaction for demonstration purposes.

## Error Handling

- **`require()`**: Used to validate conditions before executing a function.
  - Ensures deposit amount is greater than zero.
  - Ensures only the owner can withdraw funds.
  - Ensures the contract has sufficient balance for withdrawal.

- **`assert()`**: Used to check for conditions that should never be false.
  - Ensures the contract balance is never negative after a withdrawal.

- **`revert()`**: Used to handle exceptional situations.
  - Demonstrates contract reset functionality by always reverting the transaction.

## Development

To modify or extend this contract, follow these steps:

1. Clone the repository.
2. Make your changes in the `ErrorHandlingExample.sol` file.
3. Compile and deploy the contract using your preferred Ethereum development framework.

## License

This project is licensed under the MIT License.

---

This README file provides an overview, usage instructions, and details on the functions and error handling mechanisms used in the `ErrorHandlingExample` smart contract.
