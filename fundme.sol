// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 10 * 1e18;
    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough!");
    }

    function getPrice() public view returns(uint256) {
    // Rinkby test net
    // ABI
    // Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    (,int256 price,,,) = priceFeed.latestRoundData();
    return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    //function withdraw(){}
}
