// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract MergeSortedArray {

    function mergeSortedArray(uint[] memory nums1, uint[] memory nums2) public pure returns (uint[] memory) {
        uint[] memory mergedArray = new uint[](nums1.length + nums2.length);
        uint i = 0;
        uint j = 0;
        uint k = 0;

        while (i < nums1.length && j < nums2.length) {
            if (nums1[i] < nums2[j]) {
                if (k == 0 || nums1[i] != mergedArray[k-1]){
                    mergedArray[k] = nums1[i];
                    i++;
                }
            } else if (nums1[i] > nums2[j]){
                if (k == 0 || nums2[j] != mergedArray[k-1]){
                    mergedArray[k] = nums2[j];  
                    j++;
                }
            } else {
                mergedArray[k] = nums1[i];
                i++;
                j++;
            }
            k++;
        }

        if (i < nums1.length) {
            if (k == 0 || nums1[i] != mergedArray[k-1]){
                    mergedArray[k] = nums1[i];
                    i++;
            }
             k++;
        } else if (j < nums2.length) {
            if (k == 0 || nums2[j] != mergedArray[k-1]){
                    mergedArray[k] = nums2[j];
                    j++;
            }
            k++;
        }
        //后面元素可能会被0补齐，去掉0
        uint[] memory mergedArray2 = new uint[](k);

        for (uint l = 0; l < k; l++) {
            mergedArray2[l] = mergedArray[l];
        }

        return mergedArray2;
    }
    
}