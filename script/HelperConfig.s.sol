// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// 1. Deploy mocks when on local anvil chain
// 2. Keep track of contract address across different chains
// Base Sepolia ETH/USD
// Base Mainnet ETH/USD

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH?USD price feed address
    }

    constructor() {
        if (block.chainid == 84532) {
            activeNetworkConfig = getBaseSepoliaEthConfig();
        } else if (block.chainid == 8453) {
            activeNetworkConfig = getBaseMainnetEthConfig();
        } else {
            activeNetworkConfig = CreateBaseAnvilEthConfig();
        }
    }

    function getBaseSepoliaEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        // priceFeed Address
        NetworkConfig memory baseSepoliaConfig = NetworkConfig({
            priceFeed: 0x4aDC67696bA383F43DD60A9e78F2C97Fbbfc7cb1
        });

        return baseSepoliaConfig;
    }

    function getBaseMainnetEthConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        // priceFeed Address
        NetworkConfig memory baseMainnetConfig = NetworkConfig({
            priceFeed: 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70
        });

        return baseMainnetConfig;
    }

    function CreateBaseAnvilEthConfig() public returns (NetworkConfig memory) {
        // priceFeed Address

        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        // 1. Deploy mocks
        // 2. Reurn mock address

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });

        return anvilConfig;
    }
}
