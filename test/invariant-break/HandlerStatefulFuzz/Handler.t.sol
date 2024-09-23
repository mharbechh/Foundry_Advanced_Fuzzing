// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {HandlerStatefulFuzzCatches} from "../../../src/invariant-break/HandlerStatefulFuzzCatches.sol";
import {Test, console} from "forge-std/Test.sol";
import {MockUSDC} from "../../mocks/MockUSDC.sol";
import {YeildERC20} from "../../mocks/YeildERC20.sol";

contract Handler is Test {
    HandlerStatefulFuzzCatches public Hsfc;
    MockUSDC mockUSDC;
    YeildERC20 yeildERC20;
    address user;

    constructor(HandlerStatefulFuzzCatches _Hsfc, MockUSDC _mockUSDC, YeildERC20 _yeildERC20, address _user) {
        Hsfc = _Hsfc;
        mockUSDC = _mockUSDC;
        yeildERC20 = _yeildERC20;
        user = _user;
    }

    function depositMockUSDC(uint256 _amount) public {
        _amount = bound(_amount, 0, mockUSDC.balanceOf(user));
        vm.startPrank(user);
        mockUSDC.approve(address(Hsfc), _amount);
        Hsfc.depositToken(mockUSDC, _amount);
        vm.stopPrank();
    }

    function depositYeildERC20(uint256 _amount) public {
        _amount = bound(_amount, 0, yeildERC20.balanceOf(user));
        vm.startPrank(user);
        yeildERC20.approve(address(Hsfc), _amount);
        Hsfc.depositToken(yeildERC20, _amount);
        vm.stopPrank();
    }

    function withdrawMockUSDC() public {
        vm.startPrank(user);
        Hsfc.withdrawToken(mockUSDC);
        vm.stopPrank();
    }

    function withdrawYeildERC20() public {
        vm.startPrank(user);
        Hsfc.withdrawToken(yeildERC20);
        vm.stopPrank();
    }
}
