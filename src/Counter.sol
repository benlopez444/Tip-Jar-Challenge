// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13; //version of solidity being used

contract Counter {
    uint256 public number; //declares a variable which is set to default, 0, since its public anyone can call number() to see its value

    function setNumber(uint256 newNumber) public { //declares function which anyone can call, takes in a uint256 which is stored in newnumber, then sets number equal to it
        number = newNumber;
    }

    function increment() public { //increment function can be called by anyone, adds 1 to number value
        number++;
    }
}
