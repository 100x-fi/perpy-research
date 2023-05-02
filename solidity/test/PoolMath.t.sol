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

    function testCorrectness_getGlobalMarketPnl() external {
        // price 29248 skew -906994 max_skew 300000000 sum_se 151.891760743658657 sum_s2e 31591657.2017869730 sum_size 4458982
        // a -4442530.21823052840 b 13431.1608425125996 c 1539.98798306310898 d -4458982
        // globalPnl 31422.93059504731
        int256 globalPnl = PoolMath.getGlobalMarketPnl({
            price: 29248 * 1e30,
            skew: -906994 * 1e30,
            maxSkew: 300000000 * 1e30,
            sumSE: 151.891760743658657 * 1e30,
            sumS2E: 31591657.2017869730 * 1e30,
            sumSize: 4458982 * 1e30,
            isLong: true
        });
        assertApproxEqAbs(
            globalPnl,
            31422.93059504731 * 1e30,
            0.00000000001 * 1e30
        );

        // price 29248 skew -906994 max_skew 300000000 sum_se 183.719284505205948 sum_s2e 35716570.9674205534 sum_size 5365976
        // a 5373421.63320826357 b -16245.5372693003193 c 1741.06377942519391 d 5365976
        // globalPnl 7058.84028161156
        globalPnl = PoolMath.getGlobalMarketPnl({
            price: 29248 * 1e30,
            skew: -906994 * 1e30,
            maxSkew: 300000000 * 1e30,
            sumSE: 183.719284505205948 * 1e30,
            sumS2E: 35716570.9674205534 * 1e30,
            sumSize: 5365976 * 1e30,
            isLong: false
        });
        assertApproxEqAbs(
            globalPnl,
            7058.84028161156 * 1e30,
            0.00000000001 * 1e30
        );

        // price 28680 skew 1541401 max_skew 300000000 sum_se 223.554877838787473 sum_s2e 67879718.2347654245 sum_size 6442972
        // a -6411553.89641642473 b -32942.5852916339116 c 3244.65053162178729 d -6442972
        // globalPnl 1720.16882356315
        globalPnl = PoolMath.getGlobalMarketPnl({
            price: 28680 * 1e30,
            skew: 1541401 * 1e30,
            maxSkew: 300000000 * 1e30,
            sumSE: 223.554877838787473 * 1e30,
            sumS2E: 67879718.2347654245 * 1e30,
            sumSize: 6442972 * 1e30,
            isLong: true
        });
        assertApproxEqAbs(
            globalPnl,
            1720.16882356315 * 1e30,
            0.00000000001 * 1e30
        );

        // price 28680 skew 1541401 max_skew 300000000 sum_se 170.069419381467567 sum_s2e 35401378.8357504778 sum_size 4901571
        // a 4877590.94786048982 b 25061.0785487436896 c 1692.18590834887284 d 4901571
        // globalPnl -2773.21231758238
        globalPnl = PoolMath.getGlobalMarketPnl({
            price: 28680 * 1e30,
            skew: 1541401 * 1e30,
            maxSkew: 300000000 * 1e30,
            sumSE: 170.069419381467567 * 1e30,
            sumS2E: 35401378.8357504778 * 1e30,
            sumSize: 4901571 * 1e30,
            isLong: false
        });
        assertApproxEqAbs(
            globalPnl,
            -2773.21231758238 * 1e30,
            0.00000000001 * 1e30
        );

        // price 27841 skew 8137378 max_skew 300000000 sum_se 1725.42447429044220 sum_s2e 3907041113.94938616 sum_size 50596097
        // a -48037542.7887202013 b -1302998.81287663471 c 181293.219422441434 d -50596097
        // globalPnl 1436848.6178256054
        globalPnl = PoolMath.getGlobalMarketPnl({
            price: 27841 * 1e30,
            skew: 8137378 * 1e30,
            maxSkew: 300000000 * 1e30,
            sumSE: 1725.42447429044220 * 1e30,
            sumS2E: 3907041113.94938616 * 1e30,
            sumSize: 50596097 * 1e30,
            isLong: true
        });
        assertApproxEqAbs(
            globalPnl,
            1436848.6178256054 * 1e30,
            0.0000000001 * 1e30
        );

        // price 27841 skew 8137378 max_skew 300000000 sum_se 1472.60250843293453 sum_s2e 2267940326.93735307 sum_size 42458719
        // a 40998726.4372813302 b 1112073.78179583825 c 105236.211070438078 d 42458719
        // globalPnl 242682.5698523935
        globalPnl = PoolMath.getGlobalMarketPnl({
            price: 27841 * 1e30,
            skew: 8137378 * 1e30,
            maxSkew: 300000000 * 1e30,
            sumSE: 1472.60250843293453 * 1e30,
            sumS2E: 2267940326.93735307 * 1e30,
            sumSize: 42458719 * 1e30,
            isLong: false
        });
        assertApproxEqAbs(
            globalPnl,
            242682.5698523935 * 1e30,
            0.0000000001 * 1e30
        );
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
                t0.price,
                t0.skew,
                t0.maxSkew,
                t0.sumSize,
                t0.sumSizeSquared
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
                t1.price,
                t1.skew,
                t1.maxSkew,
                t1.sumSize,
                t1.sumSizeSquared
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
                t2.price,
                t2.skew,
                t2.maxSkew,
                t2.sumSize,
                t2.sumSizeSquared
            )
        );
        TestParams memory t3 = TestParams({
            price: 28_000 * 1e30,
            skew: 340282366920938463463374607431768211454,
            maxSkew: 340282366920938463463374607431768211454,
            sumSize: -340282366920938463463374607431768211454,
            sumSizeSquared: 340282366920938463463374607431768211454 *
                340282366920938463463374607431768211454
        });
        console2.log(
            PoolMath.calcWeightedAvgExitPrice(
                t3.price,
                t3.skew,
                t3.maxSkew,
                t3.sumSize,
                t3.sumSizeSquared
            )
        );
    }
}
