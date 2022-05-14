require("@nomiclabs/hardhat-waffle");
// parece que ao importar o dotenv, o repl se confunde...
// ao rodar local, importar o config do dotenv:
//require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: process.env['STAGING_ALCHEMY_KEY'],
      accounts: [process.env['PRIVATE_KEY']],
    },
    /*
    * apenas habilitar caso deseja conectar à mainnet
    mainnet: {
      chainId: 1,
      url: process.env['PROD_ALCHEMY_KEY'], 
      accounts: [process.env['PRIVATE_KEY']],
    },
    */
  },
};