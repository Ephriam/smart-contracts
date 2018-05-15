pragma solidity ^0.4.4;

contract CrowdFund {

  address public beneficiary;
  uint256 public goal;
  uint256 public deadline;
  
  /*struct Funder {
    address addr;
    uint256 contribution;
  }*/
  //Funder[] funders;

  event NewContribution(address indexed _from, uint256 _value);

  mapping (address => uint256) funders;
  address[] funderAddress;

  function CrowdFund(address _beneficiary, uint256 _goal, uint256 _duration) {
    beneficiary = _beneficiary;
    goal = _goal;
    deadline = now + _duration;
  }

  function contribute() payable {
    if(funders[msg.sender]==0) funderAddress.push (msg.sender);
      //funders.push(Funder(msg.sender, msg.value));
      funders[msg.sender] += msg.value;
      NewContribution(msg.sender, msg.value);    
  }

  function payout() {
    if(this.balance >= goal && now > deadline) beneficiary.send(this.balance);
  }

  /*function refundx(){  
    if(msg.sender != beneficiary) throw;
    uint256 index = 0;
    while(index < funders.length){
      funders[index].addr.send(funders[index].contribution);
      index++;
    }

  }*/

  function refund() {
    if(this.balance < goal && now > deadline) {
      msg.sender.send(funders[msg.sender]);
      funders[msg.sender] = 0;
    }
  }

  function getFunderContribution(address _addr) constant returns(uint) {
    return funders[_addr];
  }

  function getFunderAddress(uint _index) constant returns(address) {
    return funderAddress[_index];
  }

  function getNow() constant returns(uint256) {
    return now;
  }

}
