// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract BinarySearch {
    
    function binarySearch(uint256[] memory nums, uint256 target) public pure returns (uint256){
        uint256 index = 0;
        uint256 low = 0;
        uint256 high = nums.length - 1;
        while (low <= high) {
            index = (low + high) / 2;
            if (nums[index] == target) {
                return index;
            } else if (nums[index] < target) {
                low = index + 1;
            } else {
                high = index - 1;
            }
        }
        return index;
    }
}