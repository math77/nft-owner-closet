# NFT Owner Closet

Concept not yet tested in a "real" project, but looks super cool. 
    
    The idea is to provide a closet of styles so that the owner of a particular NFT can choose which one appeals most.

    Possible flow:
    - Builder creates a style contract that implements the interface provided here
    - This contract is deployed on the blockchain
    - The address of this new contract is set in the mapping of the main contract using the function: newMetadataContractAddress(address addr)
    - From now on token owners can choose the look of their NFT among those provided by the contract owner using the function: pickFavoriteMetadataContract(uint256 tokenID, uint256 idAddrMetadata)

    Created by: @theramblingboy