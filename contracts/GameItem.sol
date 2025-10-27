// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract GameItem is ERC1155, Ownable {
uint256 public constant SWORD = 1;
uint256 public constant SHIELD = 2;
uint256 public constant POTION = 3;


constructor(string memory uri_) ERC1155(uri_) {}


function mint(address to, uint256 id, uint256 amount) external onlyOwner {
_mint(to, id, amount, "");
}


function batchMint(address to, uint256[] memory ids, uint256[] memory amounts) external onlyOwner {
_mintBatch(to, ids, amounts, "");
}
}
