const { expect } = require('chai')
const { ethers } = require('hardhat')

describe("Blog", async function() {
    xit('Should create a post', async function() {
        const blogContract = await ethers.getContractFactory('Blog');
        const blogInstance = await blogContract.deploy("Hello world");
        await blogInstance.deployed();

        await blogInstance.createPost("This is a title", "111111");
    }),

    xit('Should get a post', async function() {
        const blogContract = await ethers.getContractFactory('Blog');
        const blogInstance = await blogContract.deploy("Hello world");
        await blogInstance.deployed();

        await blogInstance.createPost("This is a title", "111111");

        const postList = await blogInstance.getAllPosts();
        expect(postList[0].title).to.equal("This is a title");
    }),

    xit('Should edit a post', async function() {
        const blogContract = await ethers.getContractFactory('Blog');
        const blogInstance = await blogContract.deploy("Hello world");
        await blogInstance.deployed();

        await blogInstance.createPost("This is a title", "111111");

        await blogInstance.updatePostById(1, "New Title", "222222", true);

        const post = await blogInstance.getPostById(1);
        expect(post.hash).to.equal("222222");
    }),

    it('Should change name of blog', async function() {
        const blogContract = await ethers.getContractFactory('Blog');
        const blogInstance = await blogContract.deploy("Hello world");
        await blogInstance.deployed();

        await blogInstance.updateBlogName("Web3 Blog with Solidity");
        var name = await blogInstance.name.call();

        expect(name).to.equal("Web3 Blog with Solidity");
    })

})