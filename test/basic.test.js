const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Game flow", function() {
it("deploys and mints items", async function() {
const [owner, user] = await ethers.getSigners();


const GameItem = await ethers.getContractFactory("GameItem");
const game = await GameItem.deploy("https://uri/{id}.json");
await game.deployed();


await game.mint(owner.address, 1, 10);
expect((await game.balanceOf(owner.address,1)).toNumber()).to.equal(10);
});
});
