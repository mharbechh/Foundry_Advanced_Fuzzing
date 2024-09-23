// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {HandlerStatefulFuzzCatches} from "../../../src/invariant-break/HandlerStatefulFuzzCatches.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {Test, console} from "forge-std/Test.sol";
import {MockUSDC} from "../../mocks/MockUSDC.sol";
import {YeildERC20} from "../../mocks/YeildERC20.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract Invariant is StdInvariant, Test {
    HandlerStatefulFuzzCatches Hsfc;
    MockUSDC mockUSDC;
    YeildERC20 yeildERC20;
    IERC20[] public supportedToken;
    address user = makeAddr("sahbi");
    uint256 public startedAmount;

    function setUp() public {
        vm.startPrank(user);
        yeildERC20 = new YeildERC20();
        mockUSDC = new MockUSDC();
        startedAmount = yeildERC20.INITIAL_SUPPLY();
        mockUSDC.mint(user, startedAmount);
        vm.stopPrank();
        supportedToken.push(mockUSDC);
        supportedToken.push(yeildERC20);
        Hsfc = new HandlerStatefulFuzzCatches(supportedToken);
        targetContract(address(Hsfc));
    }

    function Invariant_test_withdraw_all() public {
        vm.startPrank(user);
        Hsfc.withdrawToken(mockUSDC);
        Hsfc.withdrawToken(yeildERC20);
        vm.stopPrank();
        assertEq(mockUSDC.balanceOf(address(Hsfc)), 0);
        assertEq(yeildERC20.balanceOf(address(Hsfc)), 0);
        assertEq(mockUSDC.balanceOf(user), startedAmount);
        assertEq(yeildERC20.balanceOf(user), startedAmount);
    }
}
