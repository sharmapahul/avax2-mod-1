# StakingToken

## Overview

StakingToken is a Solidity smart contract built on the Ethereum blockchain, implementing an ERC20 token with additional staking and reward distribution functionalities. It allows users to stake tokens, earn rewards, and manage their stakes. This contract uses OpenZeppelin libraries for security and standardization.

## Features

- **ERC20 Standard:** Implements standard ERC20 functions and interface.
- **Token Minting and Burning:** Allows the owner to mint new tokens and users to burn their tokens.
- **Staking Mechanism:** Users can stake tokens and receive rewards.
- **Reward Distribution:** The owner can distribute rewards to stakers proportionally to their stakes.
- **Claiming Rewards:** Users can claim their accumulated rewards.
- **Access Control:** Utilizes OpenZeppelin's `Ownable` contract to restrict certain functions to the owner.

## Dependencies

- OpenZeppelin Contracts:
  - `ERC20`
  - `ERC20Burnable`
  - `Ownable`

## Prerequisites

- Solidity ^0.8.0
- Node.js with npm
- Truffle or Hardhat for contract deployment
- MetaMask or other Ethereum wallet for interaction

## Contract Details

### State Variables

- `contractBalance`: Tracks the contract's token balance.
- `stakes`: Maps addresses to their staked token amounts.
- `rewards`: Maps addresses to their accumulated rewards.
- `stakers`: An array of addresses that have staked tokens.
- `isStaker`: Tracks whether an address is currently staking.

### Errors

- `NotOwner()`: Thrown when a non-owner tries to call a restricted function.
- `InsufficientBalance(requested, available)`: Thrown when a user tries to unstake more tokens than they have staked.
- `TransferFailed()`: Thrown when a token transfer fails.
- `NoStake()`: Thrown when there is no stake or reward to process.
- `ZeroAmount()`: Thrown when a zero amount is provided for staking or unstaking.

### Functions

- `constructor(address payable initialOwner)`: Initializes the contract, setting the initial owner and token details.
- `mintTokens(uint256 amount)`: Allows the owner to mint new tokens.
- `burnTokens(uint256 amount)`: Allows users to burn their tokens.
- `stakeTokens(uint256 amount)`: Allows users to stake tokens. Adds new stakers to the list.
- `unstakeTokens(uint256 amount)`: Allows users to unstake tokens. Updates staker status if no tokens are left.
- `distributeRewards(uint256 rewardAmount)`: Distributes rewards to stakers based on their staked amounts.
- `claimRewards()`: Allows users to claim their accumulated rewards.
- `getTotalStaked()`: Returns the total amount of tokens staked in the contract.
- `getStakersCount()`: Returns the number of unique stakers.
- `getStakerAt(uint256 index)`: Returns the address of a staker at a specific index.

## Usage

### Deployment

1. Clone the repository and navigate to the project directory.
2. Install dependencies using `npm install`.
3. Compile the contract using `truffle compile` or `npx hardhat compile`.
4. Deploy the contract using `truffle migrate` or `npx hardhat run scripts/deploy.js`.

### Interaction

1. Use a web3 provider (like MetaMask) to interact with the deployed contract.
2. Call `mintTokens` to mint new tokens (owner only).
3. Use `stakeTokens` to stake tokens.
4. Use `unstakeTokens` to unstake tokens.
5. Call `distributeRewards` to distribute rewards (owner only).
6. Use `claimRewards` to claim your accumulated rewards.

### Example

```solidity
// Deploying the contract
const StakingToken = artifacts.require("StakingToken");

module.exports = function(deployer) {
  deployer.deploy(StakingToken, "0xYourEthereumAddress");
};

// Staking tokens
await stakingToken.stakeTokens(web3.utils.toWei('10', 'ether'), { from: userAddress });

// Unstaking tokens
await stakingToken.unstakeTokens(web3.utils.toWei('5', 'ether'), { from: userAddress });

// Distributing rewards
await stakingToken.distributeRewards(web3.utils.toWei('100', 'ether'), { from: ownerAddress });

// Claiming rewards
await stakingToken.claimRewards({ from: userAddress });
```

## Security Considerations

- Ensure only the contract owner can mint new tokens and distribute rewards.
- Validate user inputs to prevent unexpected behaviors.
- Regularly audit the contract code to identify and fix potential vulnerabilities.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
