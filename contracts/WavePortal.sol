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

  event NewWave(address indexed from, uint256 timestamp, string message);
  
  constructor() payable {
    console.log("Contrato publicado!");
  }

  function wave(string memory _message) public {
    console.log("%s mandou um salve com a mensagem: %s", msg.sender, _message);
    totalWaves += 1;
    
    waves.push(WaveData(msg.sender, block.timestamp, _message));

    if (waverToWaves[msg.sender].length == 0) {
      waverToWaves[msg.sender].push(waves.length - 1);
    }

    console.log("%s ja mandou %d salve(s) no total!", msg.sender, waverToWaves[msg.sender].length);
    
    emit NewWave(msg.sender, block.timestamp, _message);

    uint256 prizeAmount = 0.00001 ether;
    require(
        prizeAmount <= address(this).balance,
        "Tentando sacar mais dinheiro que o contrato possui."
    );
    (bool success, ) = (msg.sender).call{value: prizeAmount}("");
    require(success, "Falhou em sacar dinheiro do contrato.");
  }

  function getAllWaves() public view returns (WaveData[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("Temos um total de %d salves!", totalWaves);
    return totalWaves;
  }
}