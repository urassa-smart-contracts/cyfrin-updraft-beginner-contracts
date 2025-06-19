// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { PriceConverter } from "../PriceConverter.sol";


error NotOwner();

// 673,242 gas - constants and immutable variables
// 718, 262 gas - without constants and immutable
contract FundMe {
    using PriceConverter for uint256;

// 303 gas - constant
// 2402 gas - non-constant
    uint256 public constant MINIMUM_USD = 5e18;
    address[] public funders;
    mapping (address funder => uint256 amountFunded) addrToAmtFunded;

    // 417 gas - immutable
    // 2552 gas - non-immutable
    address public  immutable i_owner;

    constructor() {
        i_owner = msg.sender; // msg.sender is the deployer of this smart contract
    }

    function fund() public payable   {
        require(msg.value.getConversionRate() >= 1e18, "You don't have enough ETH to fund.");

        // what is a revert?
        // A revert undo any actions that have been done previously and send the remaining gas back

        // record funder
        funders.push(msg.sender);
        addrToAmtFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {

        // we need to iterate to all funders and reset mapping the amount to zero
        for(uint256 funderIndx = 0; funderIndx < funders.length; funderIndx++) {
            address funder = funders[funderIndx];
            addrToAmtFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);    // an array with length of zero

        // how do we actually withdrawing the money
        /*
        Three ways:
        - transfer
        - send
        - call (recommended)
        */

        // empty quotes -> we are calling without passing any extra data to the function call
        (bool sent, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(sent, "Send failed");
    }

    // a func modifier
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not the owner!");
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _; 
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
    }
}

