// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import Library
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {ERC4626Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC4626Upgradeable.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OrbitLending is 
    Initializable, 
    UUPSUpgradeable, 
    OwnableUpgradeable, 
    ERC4626Upgradeable 
{
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers(); 
    }

    function initialize(IERC20 asset_, address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
        __ERC4626_init(asset_);
        __ERC20_init("Orbit Lending Shares", "OLS");
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function getVersion() public pure virtual returns (string memory) {
        return "V1 - Fresh from Oven";
    }
}