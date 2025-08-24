// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract MyERC20 {

    //名字
    string private name;
    string private symbol;
    address private owner;

    //发行数量
    uint256 private totalSupply;
    
    mapping ( address => uint256 ) private   balanceOf;
    mapping ( address => mapping ( address => uint256 ) ) private   allowance;

    event TransferEvent ( address indexed from, address indexed to, uint256 value );
    event ApprovalEvent ( address indexed owner, address indexed spender, uint256 value );

    constructor( string memory _name, string memory _symbol) { 
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    //查询余额
    function BalanceOf(address _owner) public view returns (uint256 balance) {
        return balanceOf[_owner];
    }

    //转账
    function Transfer(address _to, uint256 _value) public returns (bool success) {
        if (_to == address(0) ){
            revert("Transfer to zero address");
        }
        require(balanceOf[msg.sender] >= _value, "Insufficient balance.");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit TransferEvent(msg.sender, _to, _value);
        return true;
    }

    //授权
    function Approve(address _to, uint256 _value) public returns (bool) { 
        allowance[msg.sender][_to] = _value;
        emit ApprovalEvent(msg.sender, _to, _value);
        return true;
    }

    //授权转账
    function TransferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        if (_to == address(0) ){
            revert("Transfer to zero address");
        }
        if (_from == address(0)){
            revert("Transfer from zero address");
        }
        require(balanceOf[_from] >= _value, "Insufficient balance.");
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance.");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit TransferEvent(_from, _to, _value);
        return true;
    }

    function mint(uint256 _supply) public {
        require(msg.sender == owner, "Only owner can add ");
        totalSupply += _supply;
    }
}