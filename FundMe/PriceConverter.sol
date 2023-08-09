// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    
    function getPriceFeed()public view returns (uint256) {
       AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e18);
    }

    function getConversionRate(uint256 ethAmount)public view returns (uint256) {
        uint256 ethPrice = getPriceFeed();
        uint256 ethAmountInUSD = (ethPrice * ethAmount)/1e18;
        return ethAmountInUSD;
    }
}