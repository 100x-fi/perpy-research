// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TestBase} from "@forge-std/Base.sol";
import {StdAssertions} from "@forge-std/StdAssertions.sol";
import {PoolMath} from "@perpy-research/PoolMath.sol";
import {console2} from "@forge-std/console2.sol";

contract PoolMath_Test is TestBase, StdAssertions {
  struct TestParams {
    uint256 price;
    int256 skew;
    uint256 maxSkew;
    int256 sumSize;
    uint256 sumSizeSquared;
  }

  function testCorrectness_CalcWeightedAvgExitPrice() external {
    // price 28000 sum_size -17000 skew 22000 max_skew 300000000 sum_size2 129000000
    TestParams memory t0 = TestParams({
      price: 28000 * 1e30,
      skew: 22000 * 1e30,
      maxSkew: 300000000 * 1e30,
      sumSize: -17000 * 1e30,
      sumSizeSquared: 129000000 * 1e60
    });
    console2.log(
      PoolMath.calcWeightedAvgExitPrice(
        t0.price, t0.skew, t0.maxSkew, t0.sumSize, t0.sumSizeSquared
      )
    );
    // price 28000 sum_size 5000 skew 22000 max_skew 300000000 sum_size2 13000000
    TestParams memory t1 = TestParams({
      price: 28000 * 1e30,
      skew: 22000 * 1e30,
      maxSkew: 300000000 * 1e30,
      sumSize: 5000 * 1e30,
      sumSizeSquared: 13000000 * 1e60
    });
    console2.log(
      PoolMath.calcWeightedAvgExitPrice(
        t1.price, t1.skew, t1.maxSkew, t1.sumSize, t1.sumSizeSquared
      )
    );
    // price 28_000 sum_size 100_000_000 skew -100_000_000 max_skew 300_000_000 sum_size2 90_000_000_000_000_000
    TestParams memory t2 = TestParams({
      price: 28_000 * 1e30,
      skew: 300_000_000 * 1e30,
      maxSkew: 300_000_000 * 1e30,
      sumSize: -300_000_000 * 1e30,
      sumSizeSquared: (300_000_000 * 1e30) * (300_000_000 * 1e30)
    });
    console2.log(
      PoolMath.calcWeightedAvgExitPrice(
        t2.price, t2.skew, t2.maxSkew, t2.sumSize, t2.sumSizeSquared
      )
    );
    TestParams memory t3 = TestParams({
      price: 28_000 * 1e30,
      skew: 340282366920938463463374607431768211454,
      maxSkew: 340282366920938463463374607431768211454,
      sumSize: -340282366920938463463374607431768211454,
      sumSizeSquared: 340282366920938463463374607431768211454
        * 340282366920938463463374607431768211454
    });
    console2.log(
      PoolMath.calcWeightedAvgExitPrice(
        t3.price, t3.skew, t3.maxSkew, t3.sumSize, t3.sumSizeSquared
      )
    );
  }
}
