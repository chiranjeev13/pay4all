require("@nomicfoundation/hardhat-toolbox");
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    ropsten: {
      url: "https://ropsten.infura.io/v3/18357c43a5ec4ef8884cb156adcea32b",
      //accounts: [""]
    },
    ftmtest: {
      url: "https://rpc.testnet.fantom.network",
      //accounts: [""],
      chainId: 4002,
    },
    mumbai: {
      url: "https://still-ultra-arrow.matic-testnet.discover.quiknode.pro/43e52ebf26c0887c0fed66609314605a28da5777/",
      accounts: [""],
      blockConfirmations: 6,
    },
  },
  etherscan: {
    apiKey: "",
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
};
