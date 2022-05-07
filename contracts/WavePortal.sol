// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping (address => uint256) addressWaves;

    constructor() {
        console.log("Fala ai!! Eu sou um contrato e eu sou inteligente! ;)");
    }

    function wave() public {
        totalWaves += 1;
        addressWaves[msg.sender] += 1;

        console.log("%s mandou um salve!", msg.sender);
        console.log("%s ja mandou %d salve(s) no total!", msg.sender, addressWaves[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Temos um total de %d salves!", totalWaves);
        return totalWaves;
    }
}