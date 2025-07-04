// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  
  struct WaveData {
    address waver;
    uint256 timestamp;
    string message;
  }

  mapping (address => uint256[]) waverToWaves;
  WaveData[] waves;
  uint256 totalWaves;
  // Utilizaremos isso abaixo para gerar um número randômico
  uint256 private seed;

  event NewWave(address indexed from, uint256 timestamp, string message);
  
  constructor() payable {
    console.log("Contrato publicado!");
    
    // Define a semente inicial
    seed = (block.timestamp + block.difficulty) % 100;
  }

  function wave(string memory _message) public {
    
    if (waverToWaves[msg.sender].length > 0) {
      uint256 lastWaveIndex = waverToWaves[msg.sender][waverToWaves[msg.sender].length - 1];
      /*
      * Precisamos garantir que o valor corrente de timestamp é ao menos 30 segundos maior que o último timestamp armazenado
      */
      require(
        waves[lastWaveIndex].timestamp + 30 seconds < block.timestamp,
        "Espere 30s para enviar outra transacao"
      );
    }
    // waves.length: o índice do próximo salve
    waverToWaves[msg.sender].push(waves.length);
    
    console.log("%s mandou um salve com a mensagem: %s", msg.sender, _message);
    totalWaves += 1;
    
    waves.push(WaveData(msg.sender, block.timestamp, _message));

    console.log("%s ja mandou %d salve(s) no total!", msg.sender, waverToWaves[msg.sender].length);
    
    emit NewWave(msg.sender, block.timestamp, _message);

    // Gera uma nova semente para o próximo que mandar um tchauzinho
    seed = (block.difficulty + block.timestamp + seed) % 100;
    console.log("# randomico gerado: %d", seed);

    // Dá 30%  de chance do usuário ganhar o prêmio.
    if (seed <= 30) {
      console.log("%s ganhou!", msg.sender);

      uint256 prizeAmount = 0.0001 ether;
      require(
        prizeAmount <= address(this).balance,
        "Tentando sacar mais dinheiro que o contrato possui."
      );
      (bool success, ) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Falhou em sacar dinheiro do contrato.");
    }
  }

  function getAllWaves() public view returns (WaveData[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("Temos um total de %d salves!", totalWaves);
    return totalWaves;
  }
}