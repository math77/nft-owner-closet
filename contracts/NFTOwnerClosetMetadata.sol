//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/access/Ownable.sol";
import { Base64 } from "./libraries/Base64.sol";

interface INFTOwnerClosetMetadata {
	function tokenURI(uint256 tokenID) external view returns (string memory);
}

contract NFTOwnerClosetMetadata is Ownable, INFTOwnerClosetMetadata {

    constructor() Ownable() {

    }
	

	function tokenURI(uint256 tokenID) external view override returns (string memory) {
        string memory output = '<svg preserveAspectRatio="xMinYMin meet" width="250" height="330" viewBox="0 0 250 330" fill="none" xmlns="http://www.w3.org/2000/svg"><text x="55" y="150" fill="black">Welcome, my dear!</text></svg>';
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "NFT Owner Closet #', toString(tokenId), '", "description": "Cool and modern.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;

    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}