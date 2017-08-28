pragma solidity ^0.4.15;

import './SafeMath.sol';

contract MyStandardToken {
    using SafeMath for uint256;
    uint256 public _totalSupply;
    
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    
    
    //Events
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
    
    //Getters
    function getTotalSupply() constant returns (uint totalSupply) {
        return _totalSupply;
    }
    function balanceOf(address _owner) constant returns (uint balance) {
        return balances[_owner];
    }
    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }
     
     
    //Setters 
    function transfer(address _to, uint _value) returns (bool success) {
        require(_value >0 && balances[msg.sender] >= _value);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        Transfer(msg.sender, _to, _value);
        return true;
        
    }
    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        require(_value > 0 && balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
        balances[_from] = balances[_from].sub(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        Transfer(_from, _to, _amount);
        return true;
    }
    function approve(address _spender, uint _value) returns (bool success){
        require((_value == 0) || (allowed[msg.sender][_spender] == 0));
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function increaseApproval (address _spender, uint _addedValue) 
        returns (bool success) {
        allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    function decreaseApproval (address _spender, uint _subtractedValue) 
        returns (bool success) {
        uint oldValue = allowed[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
          allowed[msg.sender][_spender] = 0;
        } else {
          allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }
   
    
}
