// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Feel, FeelToken} from "src/round1/Feel/feel.sol";

contract R1FeelTest is Test {
    Feel public feel;
    FeelToken public token;

    address player = makeAddr("player");

    function setUp() public {
        token = new FeelToken();
        feel = new Feel(token);
        token.transfer(address(feel), token.MAX_SUPPLY());
    }

    modifier solveChallenge() {
        uint256 start = block.timestamp;
        vm.startPrank(player);
        _;
        vm.stopPrank();
        require(block.timestamp - start < 9 minutes, "solved it in less than 9 minutes!");
        require(token.balanceOf(address(this)) == token.MAX_SUPPLY(), "NOT_SOLVED");
    }

    function wait(uint256 time) public {
        vm.warp(block.timestamp + time);
    }

    function test_solution() solveChallenge public {
        // your solution here, all tx will be done from player
        // you can advance time with `wait(seconds)`
    }
}
