// contracts/Blog.sol
//SPDX-License-Identifier: Unlicense
pragma solidity <=0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// + Initializing a data on memory, then moving to the storage. 
// + In Solidity 0.8.0 only array , struct and mapping type can specific data location. uint not on it

contract Blog is Ownable {
    // This contract allows the owner to create and edit posts,
    // and for anyone to fetch posts
    using Counters for Counters.Counter;
    
    string public name;
    Counters.Counter private _postId; 
    

    constructor(string memory _name) {
        console.log("[Backend] Create a blog with name: ", _name);
        name = _name;
    }

    // 1. Access control
    // + Implement Ownable abstract contract

    // 2. Create a post
    // + using a struct for Post
    // + using a Counter for postId
    // + using mapping to storage list posts
    // + Notable: Initializing a struct on memory, then moving to the storage
    // + Cannot return data from an editable function on blockchain
    event PostCreated(uint id, string title);
    mapping(uint => Post) postList;

    struct Post {
        uint id;
        string title;
        string hash;
        bool published;
    }

    function createPost(string memory _title, string memory _hash) public onlyOwner {

        _postId.increment();
        uint _id = _postId.current();

        // Must create the struct on MEMORY, because you initialized a POINTER.
        // If wanna store it on the blockchain, then assigned it to a mapping
        // ref: https://ethereum.stackexchange.com/questions/4467/initialising-structs-to-storage-variables
        Post memory newPost;
        newPost.id = _id;
        newPost.title = _title;
        newPost.hash = _hash;
        newPost.published = true;

        postList[_id] = newPost;
        emit PostCreated(_id, _title);
    }

    // 3. Get a post by id and fetch all
    // + In Solidity 0.8.0 only array , struct and mapping type can specific data location. uint not on it
    function getPostById(uint _id) public view returns(Post memory) {
        return postList[_id];
    }

    function getAllPosts() public view returns (Post[] memory) {
        uint lastestId = _postId.current();
        Post[] memory results = new Post[](lastestId);

        for (uint idx=0; idx < lastestId; idx ++){
            Post storage currentPost = postList[idx + 1];
            results[idx] = currentPost;
        }

        console.log("[Backend] Calling getAllPost function: total ", lastestId, " posts" );
        return results;
    }

    // 4. Updates an existing post
    event PostUpdated(uint id, bool isSuccess);

    function updatePostById(uint _id, string memory _title, string memory _hash, bool _isPublish) public onlyOwner {
        console.log("[Backend] Call updatePostById() with id=", _id);
        require(_id <= _postId.current(), "The post not exist");

        postList[_id].title = _title;
        postList[_id].hash = _hash;
        postList[_id].published = _isPublish;

        emit PostUpdated(_id, true);
    }
}