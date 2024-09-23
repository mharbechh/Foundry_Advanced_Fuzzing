// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StatelessFuzzCatches} from "../../src/invariant-break/StatelessFuzzCatches.sol";

contract StatelessFuzzCatchesTest is Test {
    StatelessFuzzCatches sfc;

    function setUp() public {
        sfc = new StatelessFuzzCatches();
    }

    function testFuzz_Never_Return_Zero_stateless(uint128 _num) public view {
        assert(sfc.doMath(_num) != 0);
    }
}
