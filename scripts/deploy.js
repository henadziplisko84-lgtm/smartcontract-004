const hre = require("hardhat");


async function main() {
const [deployer] = await hre.ethers.getSigners();
console.log("Deploying contracts with:", deployer.address);


const GameItem = await hre.ethers.getContractFactory("GameItem");
const gameItem = await GameItem.deploy("https://game.example/api/item/{id}.json");
await gameItem.deployed();
console.log("GameItem deployed to:", gameItem.address);


const LootBox = await hre.ethers.getContractFactory("LootBox");
const loot = await LootBox.deploy(gameItem.address, hre.ethers.utils.parseEther("0.01"));
await loot.deployed();
console.log("LootBox deployed to:", loot.address);


const XP = await hre.ethers.getContractFactory("XPPoints");
const xp = await XP.deploy();
await xp.deployed();
console.log("XPPoints deployed to:", xp.address);


const Leaderboard = await hre.ethers.getContractFactory("Leaderboard");
const lb = await Leaderboard.deploy();
await lb.deployed();
console.log("Leaderboard deployed to:", lb.address);


const Arena = await hre.ethers.getContractFactory("BattleArena");
const arena = await Arena.deploy(xp.address);
await arena.deployed();
console.log("BattleArena deployed to:", arena.address);
}


main().catch((error) => {
console.error(error);
process.exitCode = 1;
});
