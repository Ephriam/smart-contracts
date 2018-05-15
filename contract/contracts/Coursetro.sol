pragma solidity ^0.4.4;

contract Coursetro {

  string fName;
  uint public balance;
  string public lName = "hosea";
  
  function Coursetro() public {
    balance = 888;
  }

  function setName(string _fName) public {
    fName = _fName;
  }

  function getName() public constant returns(string)  {
    return fName;
  }

  function getMessage() public constant returns(string) {
    return "so Many errors";
  }
}
