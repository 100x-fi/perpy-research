// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

library PoolMath {
  // price = decimal.Decimal(self.pool_oralce.get_price(market))
  //       max_skew = decimal.Decimal(self.max_skew)
  //       skew = self.market_skew_of[market]
  //       sum_size = (
  //           -self.counter_trade_states[str(is_long)][market]["size"]
  //           if is_long
  //           else self.counter_trade_states[str(is_long)][market]["size"]
  //       )
  // weighted_avg_exit_price = (
  //           (2 * price * sum_size)
  //           + ((2 * price * skew / max_skew) * sum_size)
  //           + (price / max_skew * sum_size2)
  //       ) / (2 * sum_size)
  function calcWeightedAvgExitPrice(
    uint256 price,
    int256 skew,
    uint256 maxSkew,
    uint256 sumSize,
    uint256 sumSizeSquared
  ) public pure returns (uint256) {
    int256 a = int256(2 * price * sumSize);
    int256 b = (2 * int256(price) * skew / int256(maxSkew)) * int256(sumSize);
    uint256 c = price / maxSkew * sumSizeSquared;
    return (
      (2 * price * sumSize) + ((2 * price * skew / maxSkew) * sumSize)
        + (price / maxSkew * sumSizeSquared)
    ) / (2 * sumSize);
  }
}
