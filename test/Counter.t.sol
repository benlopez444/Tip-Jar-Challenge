// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13; //solidity version

import {Test} from "forge-std/Test.sol"; //import forge test library
import {Counter} from "../src/Counter.sol"; //imports counter contract from the counter.sol file

contract CounterTest is Test { //makes the contract countertest and configures it as a test
    Counter public counter; //makes a counter variable which can be called from outside the countertest

    function setUp() public { //this function runs when countertest is called
        counter = new Counter(); //new instance of counter variable
        counter.setNumber(0); //sets the counter variable to 0
    }

    function test_Increment() public { //creates function which tests increment function
        counter.increment(); //uses increment function from counter.sol, so counter should be 1 now
        assertEq(counter.number(), 1); // checks if counter variable is 1, if its not the test failed
    }

    function testFuzz_SetNumber(uint256 x) public { //makes function which takes in a uint256 variable
        counter.setNumber(x); // uses setNumber function from counter.sol with input x
        assertEq(counter.number(), x); //checks if counter.number is equal to x, if not the test failed
    }
}
