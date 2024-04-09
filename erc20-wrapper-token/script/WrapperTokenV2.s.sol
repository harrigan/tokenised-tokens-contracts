// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC20ExchangeWrapper} from "../src/ERC20ExchangeWrapper.sol";
import {EXCHANGE_WRAPPER_ROLE, WrapperTokenV2} from "../xtra/WrapperTokenV2.x.sol";
import {Script, console} from "@forge-std/Script.sol";
import {WrapperTokenV1} from "../xtra/WrapperTokenV1.x.sol";

contract WrapperTokenV2Script is Script {
    function run() public {
        address alice = makeAddr("Alice");

        WrapperTokenV2 tokenA = new WrapperTokenV2("Token A", "TOKA", 100);
        WrapperTokenV1 tokenB = new WrapperTokenV1(tokenA, "Token B", "TOKB");

        ERC20ExchangeWrapper exchanger = new ERC20ExchangeWrapper(tokenB, tokenA);
        tokenA.grantRole(EXCHANGE_WRAPPER_ROLE, address(exchanger));

        tokenA.transfer(alice, 100);

        vm.startPrank(alice);
        tokenA.approve(address(tokenB), 75);
        tokenB.depositFor(alice, 75);
        vm.stopPrank();

        vm.startPrank(alice);
        tokenB.approve(address(exchanger), 25);
        exchanger.depositFor(alice, 25);
        vm.stopPrank();

        console.log("Alice's Balance of Token A:", tokenA.balanceOf(alice));
        console.log("Alice's Balance of Token B:", tokenB.balanceOf(alice));
        console.log("Token B's Balance of Token A:", tokenA.balanceOf(address(tokenB)));
        console.log("Exchanger's Balance of Token B:", tokenB.balanceOf(address(exchanger)));
        console.log("Total Supply of Token A:", tokenA.totalSupply());
        console.log("Total Supply of Token B:", tokenB.totalSupply());
    }
}
