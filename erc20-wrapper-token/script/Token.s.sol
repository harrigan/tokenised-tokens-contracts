// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "@forge-std/Script.sol";
import {Token} from "../xtra/Token.x.sol";

contract TokenScript is Script {
    function run() public {
        address alice = makeAddr("Alice");
        address bob = makeAddr("Bob");

        Token token = new Token("Token", "TOK", 100);

        token.transfer(alice, 100);

        vm.prank(alice);
        token.transfer(bob, 50);

        console.log("Alice's Balance:", token.balanceOf(alice));
        console.log("Bob's Balance:", token.balanceOf(bob));
    }
}
