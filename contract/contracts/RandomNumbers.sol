pragma solidity ^0.4.4;

import './owned.sol';

contract RandomNumbers is owned {

  enum GameState {noWager, wagerMade, waggerAccepted}
  GameState public currentState;

  uint public wager;
  address public player1;
  address public player2;
  uint256 public coinFlip; 
  uint seedBlockNumber;

  modifier onlyState(GameState expectedState){
    if(expectedState == currentState) {_;}
    else{throw;}
  }

  function RandomNUmbers () {
    currentState = GameState.noWager;
  }

  function transitionGameState(bytes32 targetState) onlyOwner() returns(bool){
    if(targetState == 'noWager'){
      currentState = GameState.noWager;
      return true;
    }
    else if(targetState == 'wagerMade'){
      currentState = GameState.wagerMade;
      return true;
    }
    else if(targetState == 'waggerAccepted'){
      currentState = GameState.waggerAccepted;
      return true;
    }
    return false;
  }

  function makeWager() onlyState(GameState.noWager)  payable returns(bool){
     wager = msg.value;
     player1 = msg.sender;
     currentState = GameState.wagerMade;
      return true;
  }

   function acceptWager() onlyState(GameState.wagerMade) payable returns(bool){
     if (msg.value == wager) {
      player2 = msg.sender;
      seedBlockNumber = block.number;
      currentState = GameState.waggerAccepted;
      return true;
     }else{
       throw;
     }
  }

   function resolveBet() onlyState(GameState.waggerAccepted) returns(bool) {
      uint256 blockValue = uint256(block.blockhash(seedBlockNumber));
      uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
      coinFlip = uint256(uint256(blockValue) / FACTOR);
      if(coinFlip == 0){
      player1.send(this.balance);
      wager = 0;
      currentState = GameState.noWager;
      return true;
      }else{
        player2.send(this.balance);
        wager = 0;
        currentState = GameState.noWager;
        return true;
      }
  }

}
