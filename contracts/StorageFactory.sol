// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;    // any version gt than this works as well

import { SimpleStorage }from "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageList;

    function createSimpleStorageContract() public {
        simpleStorageList.push(new SimpleStorage());
    }

    function sfStore(uint256 _simpleStorageIndx, uint256 _favouriteNumber) public {
        /*
        To interact with a storage contract we need to do the following:
        - Address
        - ABI (Application Binary Interface)
        */
        simpleStorageList[_simpleStorageIndx].store(_favouriteNumber);
    }

    function sfGet(uint256 _simpleStorageIndx) public view returns (uint256) {
        return simpleStorageList[_simpleStorageIndx].retrieve();
    }

}

