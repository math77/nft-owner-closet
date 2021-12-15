//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import '@openzeppelin/contracts/access/Ownable.sol';
import "@openzeppelin/contracts/utils/Counters.sol";

import "./NFTOwnerClosetMetadata.sol";


import "hardhat/console.sol";

/*

    Concept not yet tested in a "real" project, but looks super cool. 

    
    The idea is to provide a closet of styles so that the owner of a particular NFT can choose which one appeals most.

    Possible flow:
    - Builder creates a style contract that implements the interface provided here
    - This contract is deployed on the blockchain
    - The address of this new contract is set in the mapping of the main contract using the function: newMetadataContractAddress(address addr)
    - From now on token owners can choose the look of their NFT among those provided by the contract owner using the function: pickFavoriteMetadataContract(uint256 tokenID, uint256 idAddrMetadata)

    Created by: @theramblingboy
*/


contract NFTOwnerCloset is ERC721, Ownable {

	using Counters for Counters.Counter;
    Counters.Counter private _tokenIDs;
    Counters.Counter private _metadataAddrIDs;

    mapping(uint256 => address) private _tokenIdToMetadataContractAddr;
    mapping(uint256 => address) private _metadataAddrAvailables;

    address private constant DEFAULT_METADATA_CONTRACT_ADDRESS;


    constructor() ERC721("NFTOwnerCloset", "CLOSET") Ownable() {
        _tokenIDs.increment();
        _metadataAddrIds.increment();
    }


    function setDefaultMetadataAddress(address addr) public onlyOwner {
        DEFAULT_METADATA_CONTRACT_ADDRESS = addr;
    }

    function newMetadataContractAddress(address addr) external onlyOwner {
        _metadataAddressAvailables[_metadataAddrIDs.current()] = addr;
        _metadataAddrIDs.increment();
    }

    function pickFavoriteMetadataContract(uint256 tokenID, uint256 idAddrMetadata) external {
        require(tokenID < _tokenIDs.current(), "The tokenID is not valid.");
        require(ownerOf(tokenID) == msg.sender, "You are not the owner of this token.");
        require(_metadataAddrAvailables[idAddrMetadata] != address(0), "The metadata contract address does not exist.");

        _tokenIdToMetadataContractAddr[tokenId] = _metadataAddrAvailables[idAddrMetadata];
    }

    function tokenURI(uint256 tokenID) public view override returns (string memory) {
        require(DEFAULT_METADATA_CONTRACT_ADDRESS != address(0), "No metadata yet");
        require(tokenID < _tokenIDs.current(), "Invalid tokenID");

        address currentMetadataContract = DEFAULT_METADATA_CONTRACT_ADDRESS;

        if (_tokenIdToMetadataContractAddr[tokenID] != address(0)) {
            currentMetadataContract = _tokenIdToMetadataContractAddr[tokenID];
        }

        return INFTOwnerClosetMetadata(currentMetadataContract).tokenURI(tokenID);
    }

}