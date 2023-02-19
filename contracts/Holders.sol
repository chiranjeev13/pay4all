// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HoldersPool {
    mapping(address => uint256) public workerBalances;

    function addToPool(
        address workerAddress,
        uint256 amount,
        uint256 flag
    ) public payable returns (bool) {
        require(flag == 1, "Already registered");
        return true;
    }
}
