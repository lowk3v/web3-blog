const hre = require("hardhat");
const fs = require('fs');

async function main() {
  const BlogFactory = await hre.ethers.getContractFactory('Blog');
  const BlogIns = await BlogFactory.deploy("The Web3 Blog with hardhat framework");
  await BlogIns.deployed();

  console.log("The contract deployed at address: ", BlogIns.address);
  fs.writeFileSync('./config.js', `
export const contractAddress = ${BlogIns.address};
export const ownerAddress = ${BlogIns.signer.address};
  `)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
