require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

// por algum motivo, não estou conseguindo utilizar as variáveis de ambiente do repl assim... e não posso usar o dotenv no repl...
module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: process.env['STAGING_ALCHEMY_KEY'],
      accounts: [process.env['PRIVATE_KEY']],
    },
    mainnet: {
      chainId: 1,
      url: process.env.PROD_ALCHEMY_KEY,
      accounts: [process.env['PRIVATE_KEY']],
    },
  },
};