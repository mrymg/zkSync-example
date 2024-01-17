//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FeeTransfer {
    address public contractOwner;

    constructor() {
        contractOwner = msg.sender;
    }

    modifier canChange() {
        if(msg.sender != contractOwner){
            throw;
        }
        _; //
    }

    function transferFee(address tokenAddress, address to, uint256 amount) public canChange {
        IERC20 token = IERC20(tokenAddress);
        require(amount > 0);
        require(token.balanceOf(msg.sender) >= amount, "Insufficient token balance");
        require(token.transfer(to, amount), "Transfer failed");
    }

}