// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.6.2 <0.9.0;

import "forge/Test.sol";

import {IAddressesProvider} from "contracts/configuration/IAddressesProvider.sol";

import {ISeriesController} from "contracts/series/ISeriesController.sol";

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract DeployedAddressesTest is Test {
    IAddressesProvider AddressesProvider;

    ISeriesController seriescontroller;

    function setUp() public {
        AddressesProvider = IAddressesProvider(
            0x264C7E8FdD91ACfAefAFD3Da677E7D7881795D2a
        );

        seriescontroller = ISeriesController(
            0x1e89959A55097b3C49Dba04738BDA09e2539676B
        );
    }

    function testAddresses() public {
        address seriesController = AddressesProvider.getSeriesController();

        IERC1155 _token = IERC1155(
            ISeriesController(seriescontroller).erc1155Controller()
        );

        IERC1155 token = IERC1155(seriescontroller.erc1155Controller());
        //IERC1155(_seriesController.erc1155Controller());

        console.log(seriesController);
        console.log(address(token));
        console.log(address(_token));
    }
}
