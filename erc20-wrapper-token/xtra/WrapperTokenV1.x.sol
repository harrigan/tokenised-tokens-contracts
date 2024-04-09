// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC20Wrapper} from "@openzeppelin/token/ERC20/extensions/ERC20Wrapper.sol";
import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/interfaces/IERC20.sol";

contract WrapperTokenV1 is ERC20Wrapper {
    constructor(IERC20 underlyingToken, string memory name, string memory symbol)
        ERC20(name, symbol)
        ERC20Wrapper(underlyingToken) {}
}
