require("dotenv").config();
require("@nomiclabs/hardhat-waffle");


const { PRIVATE_KEY, BASE_SEPOLIA_RPC, BASE_MAINNET_RPC } = process.env;


module.exports = {
solidity: "0.8.20",
networks: {
hardhat: {},
baseSepolia: {
url: BASE_SEPOLIA_RPC || "https://sepolia.base.org/rpc",
accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
},
baseMainnet: {
url: BASE_MAINNET_RPC || "https://mainnet.base.org/rpc",
accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
}
}
};
