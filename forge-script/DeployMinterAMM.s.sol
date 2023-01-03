// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.6.2 <0.9.0;

import "forge/Script.sol";

import "openzeppelin/token/ERC20/IERC20.sol";

import {SimpleToken} from "contracts/token/SimpleToken.sol";
import {ISimpleToken} from "contracts/token/ISimpleToken.sol";

import {ISeriesController} from "contracts/series/ISeriesController.sol";

import {IAddressesProvider} from "contracts/configuration/IAddressesProvider.sol";

import {MinterAmm} from "contracts/amm/MinterAMM.sol";

contract DeployMinterAMMScript is Script {
    function run() public {
        uint256 key = vm.envUint("KEY");

        vm.startBroadcast(key);

        // create LP token
        SimpleToken token = new SimpleToken();
        token.initialize("IV League Vault", "LEAGUE", 18);

        IERC20 weth = IERC20(0x78Fd7068d0dDD7d70c334d8624f2E42Cb86C7B45);
        IERC20 usdc = IERC20(0xe6b8a5CF854791412c1f6EFC7CAf629f5Df1c747);

        // create minter amm
        MinterAmm minter = new MinterAmm();

        token.grantRole(keccak256("MINTER_ROLE"), address(minter));

        minter.initialize(
            ISeriesController(0x1e89959A55097b3C49Dba04738BDA09e2539676B),
            IAddressesProvider(0x264C7E8FdD91ACfAefAFD3Da677E7D7881795D2a),
            weth,
            usdc,
            weth,
            ISimpleToken(address(token)),
            uint16(0)
        );

        // function initialize(
        // ISeriesController _seriesController,
        // IAddressesProvider _addressesProvider,
        // IERC20 _underlyingToken,
        // IERC20 _priceToken,
        // IERC20 _collateralToken,
        // ISimpleToken _lpToken,
        // uint16 _tradeFeeBasisPoints
        // ) public override {

        vm.stopBroadcast();
    }
}
