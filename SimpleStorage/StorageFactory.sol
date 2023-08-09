// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage public simpleStorage;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    SimpleStorage[] public listOfSimpleStorageContracts;

    function createStorage() public {
        simpleStorage = new SimpleStorage();
        listOfSimpleStorageContracts.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newFavorateNumber) public {
        listOfSimpleStorageContracts[_simpleStorageIndex].setFavoriteNumber(_newFavorateNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].getFavoriteNumber();
    }

    function sfAddPerson(uint256 _simpleStorageIndex, string memory _name, uint256 _favoriteNumber) public {
        listOfSimpleStorageContracts[_simpleStorageIndex].addPerson(_name, _favoriteNumber);
    }

    function sfGetPerson(uint256 _simpleStorageIndex, string memory _name) public view returns (SimpleStorage.Person memory) {     
        return listOfSimpleStorageContracts[_simpleStorageIndex].getPerson(_name);
        
    }

}