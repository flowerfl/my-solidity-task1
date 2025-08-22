// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting {
    mapping (string => uint256) public voteCountMap;
    string[] private candidates;

    function vote(string memory candidate) public {
        uint256 voteCount = voteCountMap[candidate];
        voteCountMap[candidate] = voteCount + 1;
    }

    function getVotes(string calldata candidate) public view returns (uint256) {
        return voteCountMap[candidate];
    }

    function addCandidate(string calldata candidate) public {
        candidates.push(candidate);
    }

    function resetVotes() public {
        for (uint256 i = 0; i < candidates.length; i++) {
            voteCountMap[candidates[i]] = 0;
        }
    }
}