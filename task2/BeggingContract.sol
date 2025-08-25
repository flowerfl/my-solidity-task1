// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// contract address : 0xcc15099cb6212e3faad364e6efd4a57798977a8b
contract BeggingContract {

    address private owner;

    string private name;
    string private symbol;

    uint256 private donateStartTime;
    uint256 private donateEntTime;

    mapping (address => uint256) public donaterMap;

    struct DonateInfo {
        address Donater;
        uint256 value;
    }

    DonateInfo[3] public topDonate;


    constructor(string memory _name, string memory _symbol, uint256 _donateStartTime, uint256 _donateEntTime) {
        name = _name;
        symbol = _symbol;
        donateStartTime = _donateStartTime;
        donateEntTime = _donateEntTime;
        owner = msg.sender;
    }

    receive() external payable {}

    fallback() external payable {}

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier inTimeRange(){
        require(block.timestamp >= donateStartTime && block.timestamp <= donateEntTime, "Donate not in time range, please contact owner!");
        _;
    }

    event Donation (address indexed from, uint256 value);
    
    function donate() external payable inTimeRange {
        require(msg.value > 0, "Donation amount must be greater than 0");
        donaterMap[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
        _setTopThree(msg.sender, donaterMap[msg.sender]);
    }

    function withdraw() public payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "There is no fund available for withdrawal");
        (bool s, ) = payable(owner).call{value: balance}("");
        require(s, "Withdraw failed");
    }

    function getDonation(address _donater) public view returns (uint256){
        return donaterMap[_donater];
    }

    function _setTopThree(address _address, uint256 _value) internal {
        //先判断当前top3中是否包含了当前捐赠者
        bool exist = false;
        DonateInfo[] memory newRanking = new DonateInfo[](topDonate.length + 1);
        for(uint i = 0; i < topDonate.length; i++){
            newRanking[i] = topDonate[i];
            if (newRanking[i].Donater == _address){
                newRanking[i].value = _value;
                exist = true;
            }
        }
        if (!exist){
            newRanking[topDonate.length] = DonateInfo(_address, _value);
        }

        DonateInfo[] memory top3 = new DonateInfo[](3);
        for (uint k = 0; k < 3; k++) {
            top3[k] = DonateInfo(address(0), 0);
        }

        for (uint i = 0; i < newRanking.length; i++) {
            DonateInfo memory current = newRanking[i];
            // 尝试将 current 插入到 top3 中（保持降序）
            for (uint j = 0; j < 3; j++) {
                if (current.value > top3[j].value) {
                    // 把后面的依次后移
                    for (uint k = 2; k > j; k--) {
                        top3[k] = top3[k - 1];
                    }
                    top3[j] = current;
                    break;
                }
            }
        }
        for (uint i = 0; i < top3.length; i++) {
            if (top3[i].Donater != address(0)) { // 避免添加 0 地址的无效项
                topDonate[i] = top3[i];
            }
        }
    }

    function getTop3() public view returns (DonateInfo[3] memory){
        return topDonate;
    }
}