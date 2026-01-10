---
layout: cheatsheet
title: Ethereum CLI Cheatsheet
description: 'Essential commands for Ethereum development using Geth, web3.js, and Hardhat'
---


Essential commands for Ethereum development using Geth, web3.js, and Hardhat.

## Geth (Go Ethereum)

### Installation
```bash
# Ubuntu/Debian
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum

# macOS
brew tap ethereum/ethereum
brew install ethereum
```

### Node Management
```bash
# Start mainnet node
geth

# Start testnet (Sepolia)
geth --sepolia

# Start with HTTP RPC
geth --http --http.addr "0.0.0.0" --http.port 8545

# Start with WebSocket
geth --ws --ws.addr "0.0.0.0" --ws.port 8546

# Start light client
geth --syncmode "light"

# Start with custom data directory
geth --datadir /path/to/data
```

### Account Management
```bash
# Create new account
geth account new

# List accounts
geth account list

# Import private key
geth account import /path/to/key

# Update account password
geth account update <address>
```

### Console Operations
```bash
# Attach to running node
geth attach

# Attach to IPC
geth attach ipc:/path/to/geth.ipc

# Attach to HTTP RPC
geth attach http://localhost:8545

# Execute JavaScript file
geth js script.js
```

### JavaScript Console Commands
```javascript
// Check balance
eth.getBalance("0xAddress")

// Get account list
eth.accounts

// Send transaction
eth.sendTransaction({
  from: eth.accounts[0],
  to: "0xRecipient",
  value: web3.toWei(1, "ether")
})

// Get block number
eth.blockNumber

// Get block info
eth.getBlock(12345)

// Get transaction
eth.getTransaction("0xTxHash")

// Unlock account
personal.unlockAccount(eth.accounts[0], "password", 300)

// Create account
personal.newAccount("password")

// Get network ID
net.version

// Get peer count
net.peerCount

// Mining
miner.start()
miner.stop()
```

## Hardhat

### Installation & Setup
```bash
# Install Hardhat
npm install --save-dev hardhat

# Initialize project
npx hardhat init

# Install plugins
npm install --save-dev @nomicfoundation/hardhat-toolbox
```

### Project Commands
```bash
# Compile contracts
npx hardhat compile

# Clean artifacts
npx hardhat clean

# Run tests
npx hardhat test

# Run specific test
npx hardhat test test/MyContract.test.js

# Run tests with gas reporter
REPORT_GAS=true npx hardhat test

# Check contract size
npx hardhat size-contracts
```

### Network & Node
```bash
# Start local node
npx hardhat node

# Run script on network
npx hardhat run scripts/deploy.js --network localhost
npx hardhat run scripts/deploy.js --network sepolia
npx hardhat run scripts/deploy.js --network mainnet

# Get accounts
npx hardhat accounts --network localhost
```

### Console
```bash
# Start console
npx hardhat console

# Start console on network
npx hardhat console --network localhost
npx hardhat console --network sepolia
```

### Verification
```bash
# Verify contract on Etherscan
npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor arg 1"

# Verify with multiple arguments
npx hardhat verify --network sepolia 0xAddress "arg1" 123 "arg3"
```

### Deployment
```bash
# Deploy script
npx hardhat run scripts/deploy.js

# Deploy to specific network
npx hardhat run scripts/deploy.js --network sepolia

# Deploy with specific account
npx hardhat run scripts/deploy.js --network mainnet
```

## Cast (Foundry)

### Installation
```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Query Blockchain
```bash
# Get balance
cast balance 0xAddress

# Get balance in ether
cast balance 0xAddress --ether

# Get block number
cast block-number

# Get block
cast block latest
cast block 12345

# Get transaction
cast tx 0xTxHash

# Get transaction receipt
cast receipt 0xTxHash

# Get code at address
cast code 0xAddress

# Get storage slot
cast storage 0xAddress 0
```

### Contract Interaction
```bash
# Call contract (read)
cast call 0xContract "balanceOf(address)(uint256)" 0xAddress

# Send transaction (write)
cast send 0xContract "transfer(address,uint256)" 0xRecipient 1000000

# Estimate gas
cast estimate 0xContract "transfer(address,uint256)" 0xRecipient 1000

# Get ABI
cast abi 0xContract
```

### Utilities
```bash
# Convert to hex
cast --to-hex 123456

# Convert from hex
cast --to-dec 0x1e240

# Convert to wei
cast --to-wei 1 ether

# Convert from wei
cast --from-wei 1000000000000000000

# Keccak256 hash
cast keccak "Hello World"

# ABI encode
cast abi-encode "transfer(address,uint256)" 0xAddress 1000

# ABI decode
cast abi-decode "transfer(address,uint256)" 0xData
```

## Web3.js CLI

### Installation
```bash
npm install -g web3-cli
```

### Basic Commands
```bash
# Connect to node
web3 --rpc http://localhost:8545

# Get block number
web3 eth blockNumber

# Get balance
web3 eth getBalance 0xAddress

# Get transaction count
web3 eth getTransactionCount 0xAddress

# Get gas price
web3 eth gasPrice

# Send transaction
web3 eth sendTransaction '{"from":"0x...","to":"0x...","value":"1000000000000000000"}'
```

## Common Tasks

### Deploy Contract
```javascript
// Hardhat deployment script
const { ethers } = require("hardhat");

async function main() {
  const Contract = await ethers.getContractFactory("MyContract");
  const contract = await Contract.deploy();
  await contract.deployed();
  console.log("Contract deployed to:", contract.address);
}

main();
```

### Interact with Contract
```javascript
// Hardhat console
const Contract = await ethers.getContractAt("MyContract", "0xAddress");
await Contract.myFunction();
const result = await Contract.myView();
```

### Check Network
```bash
# Geth
geth attach --exec "net.version"

# Hardhat
npx hardhat run --network localhost scripts/check.js

# Cast
cast chain-id
```

## Environment Variables

```bash
# .env file for Hardhat
INFURA_API_KEY=your_key
ALCHEMY_API_KEY=your_key
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_key
```

## Useful Resources

- **Geth Docs**: https://geth.ethereum.org/docs
- **Hardhat Docs**: https://hardhat.org/docs
- **Foundry Book**: https://book.getfoundry.sh/
- **Web3.js Docs**: https://web3js.readthedocs.io/
- **Ethereum.org**: https://ethereum.org/developers
