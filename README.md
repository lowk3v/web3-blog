# Web3 Blog project

Guideline: https://dev.to/edge-and-node/the-complete-guide-to-full-stack-web3-development-4g74

### Frameworks

- Blockchain - `Polygon` (with optional RPC provider)
- Ethereum development environment - `Hardhat`
- Front end framework - `Next.js & React`
- Ethereum web client library - `Ethers.js`
- File storage - `IPFS`
- Indexing and querying - `The Graph Protocol`

---

### Setup project

- Download npm: [https://nodejs.org/en/download/](https://nodejs.org/en/download/)
- Install npx: `npm i npx`
- Initial a project with next.js and React: `npx create-next-app web3-blog`
- Install dependencies: `npm install ethers hardhat @nomiclabs/hardhat-waffle` `ethereum-waffle chai @nomiclabs/hardhat-ethers` `web3modal @walletconnect/web3-provider` `easymde react-markdown react-simplemde-editor` `ipfs-http-client @emotion/css @openzeppelin/contracts`
- Initial a hat hard project: `npx hardhat`
- Initial a git project:
    ```jsx
    git init
    // create a repository on Github and coping a URL of the project
    git remote add origin https://github.com/Kevin-KSIS/web3-blog
    git pull origin main
    git checkout -b dev
    ```


---

### Features
1. **Access control**: Using `@openzeppelin/contracts/access/Ownable.sol`  

2. **Create a post**
- using a struct for Post  
- using a Counter for postId  
- using mapping to storage list posts  
- Notable: Initializing a struct on memory, then moving to the storage.  
- don't return a struct  

3. **Get a post, get all posts**
- In Solidity 0.8.0 only array , struct and mapping type can specific data location. uint not on it  

4. **Testing**  
- Adding test/blog-contract.js  
- CLI: `npx hardhat test`

5. **Deploy**
- Adding script/deploy.js  
- For run local node and get 20 accounts: `npx hardhat node`
- CLI: `npx hardhat run scripts/deploy.js --network localhost`  


---

### Notable

💡 **Why cannot assign a memory data to store data or store data to memory data**  
Must create a data on MEMORY, because you initialized a POINTER.  
If you wanna store it on the blockchain, then assigned it to a mapping  
ref: [https://ethereum.stackexchange.com/questions/4467/initialising-structs-to-storage-variables](https://ethereum.stackexchange.com/questions/4467/initialising-structs-to-storage-variables)  


💡 **Define the unit variable then don’t need specific data location**  
In Solidity 0.8.0 only array, struct, and mapping type can specific data location. uint not on it  

💡 **Why cannot get a value which returns a solidity function?**  
A function without a `pure` modifier, a `view` modifier or a `constant` modifier is assumed to be changing the contents of the blockchain.  
The actual value that you return from the function can be used **only inside the block-chain**  
If you want this value to be accessible on the off-chain side, then you need to generate an `event`  
Then, on the off-chain side, you will need to decode the returned value (i.e., the transaction hash) in order to retrieve that value.  
ref: [https://ethereum.stackexchange.com/a/47105](https://ethereum.stackexchange.com/a/47105)  