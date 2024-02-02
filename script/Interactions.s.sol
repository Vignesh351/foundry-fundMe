// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevopsTools} from "foundry-devops/src/DevOpsTools.sol";
import {fundMe} from "../src/fundme.sol";

contract FundFundMe is Script {
    uint256 constant Send_Value = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: Send_Value}();
        stopBroadcast();
        console.log("Funded FundMe with %s", Send_Value);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            fundMe,
            block.chainid
        );

        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithdrawFundMe is Script {}
