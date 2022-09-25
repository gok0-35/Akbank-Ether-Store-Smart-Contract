// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;

contract FeeCollector { 
    
    address public _owner;   //To be able to assign the adress owner who started the smart contract, we gave it a state variable called _owner. 
    uint256 public balance; //To store the ether that was recieved we define a state variable called balance.
    
    constructor() {
        _owner = msg.sender; //Here, we assign the adress owner who started the smart contract to the _owner inside the constructor. 
        //Since we did this, when the smart contract is called upon, it is directly assigned to the adress _owner.                      
    }
    
    receive() payable external { //Due to receive() + payable we can send ether to the smart contract.  
        balance += msg.value;    //The amount of ether sent to the smart contract gets updated. 
    }
    
    function withdraw(uint amount, address payable destAddr) public { //Here is the payable, we use this function to send ether to the user’s adress in the smart contract. 
        require(msg.sender == _owner, "Only owner can withdraw"); //With require, we ensure that the ether sent only goes to the person who started the smart contract (_owner). 
        require(amount <= balance, "Insufficient funds"); //With require, the amount of ether the _owner wants to put into their account has been conditioned to not be more than what was agreed upon in the smart contract. 
        
        destAddr.transfer(amount); //If the conditions above are provided then the desired ether amount goes from the smart contract directly into the _owner’s account. 
        balance -= amount; //The amount of ether in the smart contract is updated according to the transfer that was done. 
    }
}