// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IERC20Wrapper} from "./IERC20Wrapper.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/token/ERC20/utils/SafeERC20.sol";

contract ERC20ExchangeWrapper {
    IERC20 private immutable _underlying;
    IERC20Wrapper private immutable _overlying;

    constructor(IERC20 underlyingToken, IERC20Wrapper overlyingToken) {
        _underlying = underlyingToken;
        _overlying = overlyingToken;
    }

    function underlying() public view returns (IERC20) {
        return _underlying;
    }

    function overlying() public view returns (IERC20Wrapper) {
        return _overlying;
    }

    function depositFor(address account, uint256 value) public virtual returns (bool) {
        SafeERC20.safeTransferFrom(_underlying, msg.sender, address(this), value);
        _overlying.mint(account, value);
        return true;
    }

    function withdrawTo(address account, uint256 value) public virtual returns (bool) {
        _overlying.burn(msg.sender, value);
        SafeERC20.safeTransfer(_underlying, account, value);
        return true;
    }

    function _recover(address account) internal virtual returns (uint256) {
        uint256 value = _underlying.balanceOf(address(this)) - _overlying.totalSupply();
        _overlying.mint(account, value);
        return value;
    }
}
