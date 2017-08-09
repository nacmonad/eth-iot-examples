pragma solidity ^0.4.14;

contract Blink {
    uint public myData;

    event blinkEvent(uint data);

    function getData() constant returns (uint retData) {
        return myData;
    }

    function setData(uint theData) {
        myData=theData;
        blinkEvent(myData);
    }

}
