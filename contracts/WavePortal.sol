// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  
  struct WaveData {
    address waver;
    uint256 timestamp; // Data/hora de quando o usuário salve.
    string message; // Mensagem que o usuário enviou
  }

  mapping (address => uint256[]) waverToWaves;
  WaveData[] waves;
  uint256 totalWaves;

  /*
  * Um pouco de mágica, use o Google para entender o que são eventos em Solidity!
  */
  event NewWave(address indexed from, uint256 timestamp, string message);
  
  constructor() {
    console.log("Fala ai!! Eu sou um contrato e eu sou inteligente! ;)");
  }

  function wave(string memory _message) public {
    console.log("%s mandou um salve com a mensagem: %s", msg.sender, _message);
    totalWaves += 1;
    
    /*
    * Popular os waves de um waver
    */
    waves.push(WaveData(msg.sender, block.timestamp, _message));

    /*
    * Estou usando o mapping para saber se o endereço é novo (lista de indices de waves vazia). Assim, não tenho que iterar sobre todos os endereços para descobrir.
    * Populando a lista de indices de waves do mapping com o último indice da lista de waves (que acabou de ser inserido).
    */
    if (waverToWaves[msg.sender].length == 0) {
      waverToWaves[msg.sender].push(waves.length - 1);
    }

    console.log("%s ja mandou %d salve(s) no total!", msg.sender, waverToWaves[msg.sender].length);
    /*
    * Eu adicionei algo novo aqui. Use o Google para tentar entender o que é e depois me conte o que aprendeu em #general-chill-chat
    */
    emit NewWave(msg.sender, block.timestamp, _message);
  }

  /*
  * Adicionei uma função getAllWaves que retornará os salves.
  * Isso permitirá recuperar os salves a partir do nosso site!
  */
  function getAllWaves() public view returns (WaveData[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("Temos um total de %d salves!", totalWaves);
    return totalWaves;
  }
}