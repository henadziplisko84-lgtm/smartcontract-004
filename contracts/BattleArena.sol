// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract BattleArena is Ownable {
IERC20 public rewardToken; // e.g., XPPoints or ERC20 reward


event BattleResult(address indexed winner, address indexed loser, uint256 reward);


constructor(address _rewardToken) {
rewardToken = IERC20(_rewardToken);
}


// Simplified battle: caller challenges `opponent`. Winner chosen by higher `power` param.
function battle(address opponent, uint256 myPower, uint256 oppPower, uint256 reward) external {
require(msg.sender != opponent, "no self battle");
address winner;
address loser;
if (myPower >= oppPower) {
winner = msg.sender;
loser = opponent;
} else {
winner = opponent;
loser = msg.sender;
}


// reward distribution: contract should have allowance or hold tokens
if (reward > 0) {
// if rewardToken is XP and is mintable by this contract, you would call mint; here we transfer
rewardToken.transfer(winner, reward);
}


emit BattleResult(winner, loser, reward);
}
}
