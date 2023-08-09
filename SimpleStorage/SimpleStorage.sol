// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SimpleStorage {
    uint256 myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    
    Person[] public listOfPeople;
    mapping(string => Person) public nameToInfo;

    function setFavoriteNumber(uint256 newFavoriteNumber) public {
        myFavoriteNumber = newFavoriteNumber;
    }

    function getFavoriteNumber() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToInfo[_name] = Person(_favoriteNumber, _name);
    }

    function getPerson(string memory _name) public view returns (Person memory) {
        Person storage person = nameToInfo[_name];
        return person;
    }
}