// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";


contract LootBox is Ownable {
IERC1155 public gameItem;
uint256 public boxPrice; // in wei


event Opened(address indexed user, uint256 id, uint256 amount);


constructor(address _gameItem, uint256 _boxPrice) {
gameItem = IERC1155(_gameItem);
boxPrice = _boxPrice;
}


// Pseudo-random (not secure on-chain) — suitable for test / MVP
function _rand(address user, uint256 nonce) internal view returns (uint256) {
return uint256(keccak256(abi.encodePacked(block.timestamp, user, nonce, blockhash(block.number - 1))));
}


function openBox(uint256 nonce) external payable {
require(msg.value >= boxPrice, "Insufficient payment");
uint256 r = _rand(msg.sender, nonce) % 100;


uint256 id;
uint256 amt = 1;
if (r < 50) {
id = 3; // POTION
} else if (r < 85) {
id = 2; // SHIELD
} else {
id = 1; // SWORD
}


// Contract must hold items beforehand
// transfer from contract to user
// Since ERC1155 does not have transferFrom for contract, use safeTransferFrom
// The contract should be approved or hold the token balance
gameItem.safeTransferFrom(address(this), msg.sender, id, amt, "");


emit Opened(msg.sender, id, amt);
}


// Owner functions
function withdraw(address payable to) external onlyOwner {
to.transfer(address(this).balance);
}


function setPrice(uint256 p) external onlyOwner {
boxPrice = p;
}
}
