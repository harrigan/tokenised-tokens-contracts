// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "@forge-std/Script.sol";
import {Token} from "../xtra//Token.x.sol";
import {WrapperTokenV1} from "../xtra/WrapperTokenV1.x.sol";

contract WrapperTokenV1Script is Script {
    function run() public {
        address alice = makeAddr("Alice");

        Token token = new Token("Token", "TOK", 100);
        string memory name = string.concat("Wrapper ", token.name());
        string memory symbol = string.concat("w", token.symbol());
        WrapperTokenV1 wrapper = new WrapperTokenV1(token, name, symbol);

        token.transfer(alice, 100);

        vm.startPrank(alice);
        token.approve(address(wrapper), 75);
        wrapper.depositFor(alice, 75);
        wrapper.withdrawTo(alice, 50);
        vm.stopPrank();

        console.log("Alice's Unwrapped Balance:", token.balanceOf(alice));
        console.log("Alice's Wrapped Balance:", wrapper.balanceOf(alice));
    }
}
