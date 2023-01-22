// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract BruNFT is ERC721, ERC721Enumerable, ERC721URIStorage {

    //@notice Mint fees for user
    uint256 constant public mintFees = 1000000000000000;
    //@notice TokenId counter 
    uint256 currentTokenId = 0;

    /**
     * @notice while deploying contract pass NFT collection name and symbol 
     * @param _name name of collection
     * @param _symbol symbol for collection
     */
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){}

    /**
     * @notice Mint NFT token by user
     * @param _tokenURI Metadata URI 
     */
    function mintByUser(string memory _tokenURI) external payable {
        require(msg.value == mintFees, "insufficient mint fees");
        currentTokenId+=1;
        _safeMint(msg.sender, currentTokenId);
        _setTokenURI(currentTokenId, _tokenURI);
    }

    //overriden function
    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    //overriden function
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    //overriden function
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) virtual internal override(ERC721Enumerable, ERC721){
        super._beforeTokenTransfer(from,to,tokenId,batchSize);
    }

    //overriden function
    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

}