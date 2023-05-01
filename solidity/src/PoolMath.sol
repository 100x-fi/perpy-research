// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SafeCast} from "@oz/utils/math/SafeCast.sol";
import {FullMath} from "@perpy-research/libraries/FullMath.sol";

library PoolMath {
  using SafeCast for int256;
  using SafeCast for uint256;
  using FullMath for uint256;

  function calcWeightedAvgExitPrice(
    uint256 price,
    int256 skew,
    uint256 maxSkew,
    int256 sumSize,
    uint256 sumSizeSquared
  ) public pure returns (uint256) {
    int256 a = 2 * int256(price) * sumSize / 1e30;
    int256 b = (2 * int256(price) * skew / int256(maxSkew)) * sumSize / 1e30;
    uint256 c = price.mulDiv(sumSizeSquared, maxSkew);
    int256 d = 2 * sumSize;
    return ((a + b + c.toInt256()) * 1e30 / d).toUint256();
  }
}
