// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingToken is ERC20, ERC20Burnable, Ownable {
    
    uint256 public contractBalance;
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    address[] public stakers;
    mapping(address => bool) public isStaker;

    error NotOwner();
    error InsufficientBalance(uint256 requested, uint256 available);
    error TransferFailed();
    error NoStake();
    error ZeroAmount();

    constructor(address payable initialOwner)
        ERC20("StakingToken", "STK")
        Ownable(initialOwner)
    {
        contractBalance = 0;
    }


    function mintTokens(uint256 amount) public onlyOwner {
        _mint(owner(), amount);
    }

    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function stakeTokens(uint256 amount) public {
        if (amount == 0) {
            revert ZeroAmount();
        }
        _transfer(msg.sender, address(this), amount);
        stakes[msg.sender] += amount;
        if (!isStaker[msg.sender]) {
            stakers.push(msg.sender);
            isStaker[msg.sender] = true;
        }
    }

    function unstakeTokens(uint256 amount) public {
        if (amount == 0) {
            revert ZeroAmount();
        }
        if (stakes[msg.sender] < amount) {
            revert InsufficientBalance({ requested: amount, available: stakes[msg.sender] });
        }
        stakes[msg.sender] -= amount;
        if (stakes[msg.sender] == 0) {
            isStaker[msg.sender] = false;
        }
        _transfer(address(this), msg.sender, amount);

        assert(stakes[msg.sender] >= 0);
    }
    function distributeRewards(uint256 rewardAmount) public onlyOwner {
        uint256 totalStaked = getTotalStaked();
        if (totalStaked == 0) {
            revert NoStake();
        }

        for (uint i = 0; i < stakers.length; i++) {
            address staker = stakers[i];
            uint256 stakerShare = (stakes[staker] * rewardAmount) / totalStaked;
            rewards[staker] += stakerShare;
        }

        uint256 totalRewardsDistributed = 0;
        for (uint i = 0; i < stakers.length; i++) {
            totalRewardsDistributed += rewards[stakers[i]];
        }
        assert(totalRewardsDistributed <= rewardAmount);
    }

    function claimRewards() public {
        uint256 reward = rewards[msg.sender];
        if (reward == 0) {
            revert NoStake();
        }
        rewards[msg.sender] = 0;
        _mint(msg.sender, reward);
    }
    function getTotalStaked() public view returns (uint256) {
        uint256 total = 0;
        for (uint i = 0; i < stakers.length; i++) {
            total += stakes[stakers[i]];
        }
        return total;
    }
    function getStakersCount() public view returns (uint256) {
        return stakers.length;
    }

    function getStakerAt(uint256 index) public view returns (address) {
        require(index < stakers.length, "Index out of bounds");
        return stakers[index];
    }
}
