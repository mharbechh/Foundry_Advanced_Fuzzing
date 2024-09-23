// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {StatefulFuzzCatches} from "../../src/invariant-break/StatefulFuzzCatches.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract StatefulFuzzCatchesTest is StdInvariant, Test {
    StatefulFuzzCatches sfc;

    function setUp() public {
        sfc = new StatefulFuzzCatches();
        targetContract(address(sfc));
    }

    function invariant_Never_Return_Zero() public view {
        assert(sfc.storedValue() != 0);
    }
}
