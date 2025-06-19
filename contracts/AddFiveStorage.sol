// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { SimpleStorage } from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {

   function store(uint256 _newNumber) public override  {
    super.store(_newNumber + 5);
   }
}
