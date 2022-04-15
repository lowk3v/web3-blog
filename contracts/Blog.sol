// contracts/Blog.sol
//SPDX-License-Identifier: Unlicense
pragma solidity <=0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Blog is Ownable {
    // This contract allows the owner to create and edit posts,
    // and for anyone to fetch posts
    using Counters for Counters.Counter;
    
    string public name;
    Counters.Counter private _postId; 
    

    constructor(string memory _name) {
        console.log("Create a blog with name: ", _name);
        name = _name;
    }

    // 1. Access control
    // + Implement Ownable abstract contract

    // 2. Create a post
    // + using a struct for Post
    // + using a Counter for postId
    // + using mapping to storage list posts
    // + Notable: Initializing a struct on memory, then moving to the storage
    event PostCreated(uint id, string title);
    mapping(uint => Post) postList;

    struct Post {
        uint id;
        string title;
        string hash;
        bool published;
    }

    function createPost(string memory _title, string memory _hash) public onlyOwner 
        returns (uint _id) {

        _postId.increment();
        _id = _postId.current();

        // Must create the struct on MEMORY, because you initialized a POINTER.
        // If wanna store it on the blockchain, then assigned it to a mapping
        // ref: https://ethereum.stackexchange.com/questions/4467/initialising-structs-to-storage-variables
        Post memory newPost = Post(_id, _title, _hash, true);
        postList[_id] = newPost;

        emit PostCreated(_id, _title);
    }

}