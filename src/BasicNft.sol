// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    error BasicNft__TokenUriNotFound();

    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;
    uint256 private s_tokenCounter;

    constructor() ERC721("Dogie", "DOG") {//constrcutor of ERC721.sol,it indicates category of dogs more like bored apes
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);//this is present in ERC721.sol
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {//we hv this function in ERC721.sol,it is returning the link of the image,if we copy paste it in the browser we get the image
        if (ownerOf(tokenId) == address(0)) {
            revert BasicNft__TokenUriNotFound();
        }
        return s_tokenIdToUri[tokenId];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
//We are using openzeppelin library here
//IPFS hashes our data and is similar to a blockchain decentralised storage
//It choses which data it needs decrypts the hash and then reads the data
//8:04 second video learn on how to install ipfs
//We use IPFS to mainly store image location because if we store image on the blockchain its gonna take up a lot of gas
//make mint ARGS="--network sepolia" command to call mint function using make file
//make deploy ARGS="--network sepolia" command to deploy using make file
//The NFT is not loading in the wallet because nobody has pinned the location of the image because of which it is lost