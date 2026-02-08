// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {OrbitLending} from "../src/OrbitLending.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Mock Token (Buat pura-pura jadi USDC)
contract MockToken is ERC20 {
    constructor() ERC20("Mock USDC", "mUSDC") {}
}

contract OrbitTest is Test {
    OrbitLending public orbit;
    OrbitLending public implementation;
    ERC1967Proxy public proxy;
    MockToken public token;

    address owner = address(0x123);

    function setUp() public {
        // 1. Deploy Token Palsu
        token = new MockToken();

        // 2. Deploy Implementation
        implementation = new OrbitLending();

        // 3. Encode Data Initialize
        bytes memory initData = abi.encodeCall(
            OrbitLending.initialize,
            (token, owner)
        );

        // 4. Deploy Proxy
        proxy = new ERC1967Proxy(address(implementation), initData);

        // 5. Connect Interface
        orbit = OrbitLending(address(proxy));
    }

    function testVersion() public {
        console.log("Version:", orbit.getVersion());
        assertEq(orbit.getVersion(), "V1 - Fresh from Oven");
    }

    function testOwner() public {
        console.log("Owner:", orbit.owner());
        // Pastikan owner yang di-set di initialize bener masuk
        assertEq(orbit.owner(), owner);
    }
}