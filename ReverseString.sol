// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ReverseString {

    function reverseStr(string memory str) public pure  returns (string memory) {
        bytes memory bytesStr = bytes(str);
        bytes memory reverseBytes = new bytes(bytesStr.length);
        for (uint256 i = 0; i < bytesStr.length / 2; i++) {
            reverseBytes[i] = bytesStr[bytesStr.length - i - 1];
            reverseBytes[bytesStr.length - i - 1] = bytesStr[i];
        }
        return string(reverseBytes);
    }
    
}