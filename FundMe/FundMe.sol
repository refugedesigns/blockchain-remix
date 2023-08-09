// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";
/*
allow users to send eth to contract
revert if minimum amount not sent
allow only owner to withdraw from contract
*/

contract FundMe{

    using PriceConverter for uint256;

    uint256 constant MINIMUM_USD = 5 * 10**18;
    address[] funders;
    mapping(address funder => uint256 amount) addressToAmountFunded;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough ETH sent!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value.getConversionRate();
    }

    function withdraw() public onlyOwner{
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] += 0;
        }

        funders = new address[](0);
        // using transfer will revert automatically if transaction is not successful
        // payable(msg.sender).transfer(address(this).balance)

        //using send will return true or false according to the transaction state
        // bool sendSuccess = payable(msg.sender).send(address(this).balance)
        // require(sendSuccess, "Send Failed")

        // using call, you need to put the value in curly object and returns two arguments
         (bool sendSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(sendSuccess, "Send Failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

}