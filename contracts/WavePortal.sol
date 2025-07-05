// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) public waveCountbyWaver;

    constructor() {
        console.log(unicode"Um contrato ainda não tão inteligente");
    }

    function wave() public {
        totalWaves += 1;
        waveCountbyWaver[msg.sender] += 1;
        console.log("%s deu tchauzinho!", msg.sender);
        console.log(
            unicode"%s já deu %d tchauzinhos no total!",
            msg.sender,
            waveCountbyWaver[msg.sender]
        );
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Temos um total de %d tchauzinhos!", totalWaves);
        return totalWaves;
    }
}
