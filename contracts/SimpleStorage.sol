// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract SimpleStorage {
    // Basic types: bool, int,uint,address, bytes
    uint256 public myFavouriteNumber;    // 0

    struct Person {
        string name;
        uint256 favouriteNumber;
    }


    Person[] public listOfPeople;

    mapping (string => uint256) public nameToFavouriteNumber;

    function store(uint256 _favouriteNumber) public virtual  {
        myFavouriteNumber = _favouriteNumber;
    }

    // only reading the state
    function retrieve() public view returns (uint256) {
        return myFavouriteNumber;
    }

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        listOfPeople.push(Person(_name, _favouriteNumber));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    
    }
}

contract SimpleStorage2 {}
contract SimpleStorage3 {}
contract SimpleStorage4 {}

