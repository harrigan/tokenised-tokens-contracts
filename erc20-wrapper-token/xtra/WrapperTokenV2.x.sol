// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {AccessControl} from "@openzeppelin/access/AccessControl.sol";
import {IERC20Wrapper} from "../src/IERC20Wrapper.sol";
import {Token} from "./Token.x.sol";

bytes32 constant EXCHANGE_WRAPPER_ROLE = keccak256("EXCHANGE_WRAPPER_ROLE");

contract WrapperTokenV2 is Token, AccessControl, IERC20Wrapper {

    constructor(string memory name, string memory symbol, uint256 initialSupply)
        Token(name, symbol, initialSupply) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(EXCHANGE_WRAPPER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(EXCHANGE_WRAPPER_ROLE) {
        _burn(from, amount);
    }
}
