// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract RomanTransform {

    mapping (bytes1 => uint32) private  roman2unit;

    constructor() {
        roman2unit["I"] = 1;
        roman2unit["V"] = 5;
        roman2unit["X"] = 10;
        roman2unit["L"] = 50;
        roman2unit["C"] = 100;
        roman2unit["D"] = 500;
        roman2unit["M"] = 1000;

        romanItemArr.push(RomanItem(1000, "M"));
        romanItemArr.push(RomanItem(900, "CM"));
        romanItemArr.push(RomanItem(500, "D"));
        romanItemArr.push(RomanItem(400, "CD"));
        romanItemArr.push(RomanItem(100, "C"));
        romanItemArr.push(RomanItem(90, "XC"));
        romanItemArr.push(RomanItem(50, "L"));
        romanItemArr.push(RomanItem(40, "XL"));
        romanItemArr.push(RomanItem(10, "X"));
        romanItemArr.push(RomanItem(9, "IX"));
        romanItemArr.push(RomanItem(5, "V"));
        romanItemArr.push(RomanItem(4, "IV"));
        romanItemArr.push(RomanItem(1, "I"));
    }
    
    function Roman2Uint(string memory roman) public view  returns (uint32){
        bytes memory romanBytes = bytes(roman);
        uint32 u = 0;
        uint32 prUint = 0;
        for (uint32 i = 0; i < romanBytes.length; i++){
            bytes1 byt = romanBytes[i];
            uint32 curUint = roman2unit[byt];
            require(curUint != 0, "Illegal roman numbers");
            if (curUint > prUint){
                u += curUint - 2 * prUint;
            }else{
                u += curUint;
            }
            prUint = curUint;
        }
        if (u < 0 || u >= 4000){
            revert("Out of roman numbers range");
        }else{
            return u;
        }
    }

    struct RomanItem {
        uint32 intValue;
        string romanValue;
    }
    RomanItem[] private romanItemArr;

    function Uint2Roman(uint32 u) public view returns (string memory){
        require(u >= 0 && u < 4000, "Out of roman numbers range");
        string memory roman = "";
        for (uint32 i = 0; i < romanItemArr.length; i++){
            RomanItem memory item = romanItemArr[i];
            while (u >= item.intValue){
                roman = string(abi.encodePacked(roman, item.romanValue));
                u -= item.intValue;
            }
        }
        return roman;
    }
}