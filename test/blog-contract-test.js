const { expect } = require('chai')
const { ethers } = require('hardhat')

describe("Blog", async function() {
    it('Should create a post', async function() {
        const blogContract = await ethers.getContractFactory('Blog');
        const blogInstance = await blogContract.deploy("Hello world");
        await blogInstance.deployed();

        const id = await blogInstance.createPost("This is a title", "111111");
        expect(id).to.exist;
    })
})