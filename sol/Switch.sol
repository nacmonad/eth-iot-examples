pragma solidity ^0.4.14;

contract Switch {
    address owner;
    bool theSwitch;

    //constructor
    function Switch() {
        owner = msg.sender;
        theSwitch = false;
    }


    //events
    event switchEvent(bool newState);

    //modifier
    modifier onlyOwner() {
        assert(msg.sender == owner);
        _;
    }

    //getters
    function getSwitch() constant returns (bool switchState) {
        return theSwitch;
    }
    //setters

    function toggleSwitch() onlyOwner {
        theSwitch = !theSwitch;
        switchEvent(theSwitch);
    }
}
