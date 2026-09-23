// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; //this declares the version of solidity being used

import "@openzeppelin/contracts/access/Ownable.sol"; //imports the library we need to configure the ownership features of tipjar

contract TipJar is Ownable { //creates tipjar contract and configures it to ownable using the library
    mapping(address => uint256) private _totalTipped; //this matches adresss of the tippers wallet to the amt they tipped, its private so others cant see it
    uint256 public totalReceived; //this variable is the total amt of $ received, it accumulates each tip

    event Tipped(address indexed from, uint256 amount, uint256 newTotal); //runs when a tip is made, stores the address its from, the amt, and accumulates the total

    constructor() Ownable(msg.sender) {} //sets the owner of tipjar to the address of whoever deploys it

    function deposit() external payable { //it can only be called from someone outside contract which saves gas, and payable means it can receive ETH to pay for the gas
        require(msg.value > 0, "Deposit must be greater than zero"); //makes sure that deposit is > 0 before accepting

        _totalTipped[msg.sender] += msg.value; //accumulates the total tips given by sender's address
        totalReceived += msg.value; //accumulates amt in tipjar

        emit Tipped(msg.sender, msg.value, _totalTipped[msg.sender]); //logs tip event, shows senders address, how much they tipped, and how much they have tipped in total
    }

    function totalTipped(address user) external view returns (uint256) { //function uses address of user and views the amt they tipped
        return _totalTipped[user]; //returns how much the user's address has tipped in total
    }

    function withdraw() external onlyOwner { //only owner can use withdraw function
        uint256 balance = address(this).balance; // store amt of a specific address' totaltipped, in this instance
        require(balance > 0, "No balance to withdraw"); //if balance is 0, it doesnt allow withdrawal

        (bool success, ) = payable(owner()).call{value: balance}(""); //sends the value of the balance to the tipjar's owner, checks if it is payable with boolean success
        require(success, "Transfer failed"); //checks if success is true, if not it says the transfer failed
    }
}

