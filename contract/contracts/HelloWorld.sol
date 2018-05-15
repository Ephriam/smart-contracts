pragma solidity ^0.4.4;

contract HelloWorld {

  uint public balance;
  string public fName;

  function HelloWorld() public{
    // constructor
    balance = 777;
    fName = 'ephraim';
  }

}
