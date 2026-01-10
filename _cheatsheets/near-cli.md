---
layout: cheatsheet
title: NEAR CLI Cheatsheet
description: Essential commands for NEAR Protocol development and operations
---


Essential commands for NEAR Protocol development and operations.

## Installation

```bash
# Install NEAR CLI
npm install -g near-cli

# Install NEAR CLI (Rust version)
cargo install near-cli-rs

# Check version
near --version
```

## Configuration

### Network Setup
```bash
# Set network to mainnet
export NEAR_ENV=mainnet

# Set network to testnet
export NEAR_ENV=testnet

# Set network to betanet
export NEAR_ENV=betanet

# Set network to localnet
export NEAR_ENV=local
```

### Login & Authentication
```bash
# Login to NEAR account
near login

# Login with specific network
NEAR_ENV=testnet near login

# Logout
near logout

# Check login status
near state <ACCOUNT_ID>
```

## Account Management

### Create & Delete Accounts
```bash
# Create account
near create-account <NEW_ACCOUNT> --masterAccount <MASTER_ACCOUNT>

# Create account with initial balance
near create-account sub.account.testnet --masterAccount account.testnet --initialBalance 10

# Create implicit account
near generate-key <ACCOUNT_ID>

# Delete account
near delete <ACCOUNT_TO_DELETE> <BENEFICIARY_ACCOUNT>
```

### Account Info
```bash
# Get account state
near state <ACCOUNT_ID>

# Get account balance
near state <ACCOUNT_ID> | grep amount

# List access keys
near keys <ACCOUNT_ID>

# View account
near view-account <ACCOUNT_ID>
```

### Key Management
```bash
# Generate key pair
near generate-key <ACCOUNT_ID>

# Add access key
near add-key <ACCOUNT_ID> <PUBLIC_KEY>

# Add function call access key
near add-key <ACCOUNT_ID> <PUBLIC_KEY> --contract-id <CONTRACT> --method-names <METHODS>

# Delete access key
near delete-key <ACCOUNT_ID> <PUBLIC_KEY>

# Export account (private key)
cat ~/.near-credentials/testnet/<ACCOUNT_ID>.json
```

## Token Operations

### Transfers
```bash
# Send NEAR tokens
near send <SENDER> <RECEIVER> <AMOUNT>

# Send with specific network
NEAR_ENV=testnet near send sender.testnet receiver.testnet 5

# Send all tokens
near send sender.testnet receiver.testnet ALL
```

### Staking
```bash
# Stake tokens
near stake <ACCOUNT_ID> <STAKING_KEY> <AMOUNT>

# View staking info
near validators current

# View next validators
near validators next

# Unstake
near unstake <ACCOUNT_ID> <STAKING_KEY>
```

## Smart Contract Development

### Deploy Contract
```bash
# Deploy contract
near deploy --accountId <ACCOUNT_ID> --wasmFile <PATH_TO_WASM>

# Deploy with initialization
near deploy --accountId <ACCOUNT_ID> --wasmFile contract.wasm --initFunction new --initArgs '{}'

# Deploy to sub-account
near deploy --accountId contract.account.testnet --wasmFile out/contract.wasm
```

### Call Contract Methods
```bash
# Call method (change state)
near call <CONTRACT_ID> <METHOD_NAME> '<ARGS>' --accountId <CALLER_ID>

# Call with deposit
near call <CONTRACT_ID> <METHOD_NAME> '<ARGS>' --accountId <CALLER_ID> --deposit 1

# Call with gas
near call <CONTRACT_ID> <METHOD_NAME> '<ARGS>' --accountId <CALLER_ID> --gas 300000000000000

# View method (read-only)
near view <CONTRACT_ID> <METHOD_NAME> '<ARGS>'
```

### Contract Examples
```bash
# Initialize contract
near call contract.testnet new '{"owner_id": "account.testnet"}' --accountId account.testnet

# Call function with args
near call nft.testnet nft_mint '{"token_id": "1", "receiver_id": "alice.testnet"}' --accountId alice.testnet --deposit 0.1

# View function
near view nft.testnet nft_token '{"token_id": "1"}'

# Get contract state
near view-state <CONTRACT_ID>
```

## Building Contracts

### Rust Contracts
```bash
# Create new project
cargo new --lib my-contract
cd my-contract

# Add NEAR SDK
cargo add near-sdk

# Build contract
cargo build --target wasm32-unknown-unknown --release

# Optimize WASM
near-sdk build

# Test contract
cargo test
```

### AssemblyScript Contracts
```bash
# Create new project
npx create-near-app my-app

# Build contract
npm run build

# Test contract
npm test

# Deploy
npm run deploy
```

## Transaction & Block Info

```bash
# Get transaction status
near tx-status <TX_HASH> --accountId <ACCOUNT_ID>

# Get transaction details
near tx-status <TX_HASH>

# View block
near block <BLOCK_HEIGHT>

# View latest block
near block latest

# Get validators
near validators current
near validators next
```

## Development Tools

### NEAR DevTools
```bash
# Create development account
near dev-deploy

# Deploy to dev account
near dev-deploy --wasmFile contract.wasm

# Get dev account name
cat neardev/dev-account

# Clean dev account
rm -rf neardev
```

### Local Node
```bash
# Install nearup
npm install -g nearup

# Start local node
nearup run localnet

# Stop local node
nearup stop

# Check status
nearup logs
```

## Storage Management

```bash
# View storage usage
near view-state <ACCOUNT_ID> --finality final

# Get storage deposit
near view <CONTRACT_ID> storage_balance_of '{"account_id": "<ACCOUNT_ID>"}'

# Deposit for storage
near call <CONTRACT_ID> storage_deposit '{}' --accountId <ACCOUNT_ID> --deposit 0.1

# Withdraw storage deposit
near call <CONTRACT_ID> storage_withdraw '{"amount": "1000000000000000000000"}' --accountId <ACCOUNT_ID> --depositYocto 1
```

## NFT Operations

### Deploy NFT Contract
```bash
# Deploy NFT contract
near deploy --accountId nft.account.testnet --wasmFile nft-contract.wasm

# Initialize NFT contract
near call nft.account.testnet new_default_meta '{"owner_id": "account.testnet"}' --accountId account.testnet
```

### Mint & Transfer NFTs
```bash
# Mint NFT
near call nft.testnet nft_mint '{"token_id": "1", "receiver_id": "alice.testnet", "token_metadata": {"title": "My NFT", "description": "Cool NFT", "media": "https://example.com/nft.png"}}' --accountId alice.testnet --deposit 0.1

# Transfer NFT
near call nft.testnet nft_transfer '{"receiver_id": "bob.testnet", "token_id": "1"}' --accountId alice.testnet --depositYocto 1

# View NFT
near view nft.testnet nft_token '{"token_id": "1"}'

# View NFTs for owner
near view nft.testnet nft_tokens_for_owner '{"account_id": "alice.testnet"}'
```

## FT (Fungible Token) Operations

### Deploy FT Contract
```bash
# Deploy FT contract
near deploy --accountId ft.account.testnet --wasmFile ft-contract.wasm

# Initialize FT contract
near call ft.account.testnet new '{"owner_id": "account.testnet", "total_supply": "1000000000000000000000000"}' --accountId account.testnet
```

### FT Operations
```bash
# Register account
near call ft.testnet storage_deposit '{"account_id": "alice.testnet"}' --accountId alice.testnet --deposit 0.00125

# Transfer tokens
near call ft.testnet ft_transfer '{"receiver_id": "bob.testnet", "amount": "1000"}' --accountId alice.testnet --depositYocto 1

# Get balance
near view ft.testnet ft_balance_of '{"account_id": "alice.testnet"}'

# Get total supply
near view ft.testnet ft_total_supply
```

## DAO Operations

### Sputnik DAO
```bash
# Create DAO
near call sputnik-dao.near create '{"name": "my-dao", "purpose": "My DAO", "bond": "1000000000000000000000000"}' --accountId account.testnet --deposit 5

# Create proposal
near call my-dao.sputnik-dao.near add_proposal '{"proposal": {"description": "Proposal description", "kind": {"Transfer": {"token_id": "", "receiver_id": "receiver.testnet", "amount": "1000000000000000000000000"}}}}' --accountId account.testnet --deposit 0.1

# Vote on proposal
near call my-dao.sputnik-dao.near act_proposal '{"id": 0, "action": "VoteApprove"}' --accountId account.testnet --gas 300000000000000
```

## Monitoring & Analytics

```bash
# Get network status
near validators current

# Get gas price
near view-state <CONTRACT_ID> --finality final

# Monitor transactions
near tx-status <TX_HASH>

# Get protocol config
near protocol-config
```

## Common Workflows

### Deploy & Initialize Contract
```bash
# Build
cargo build --target wasm32-unknown-unknown --release

# Deploy
near deploy --accountId mycontract.testnet --wasmFile target/wasm32-unknown-unknown/release/contract.wasm

# Initialize
near call mycontract.testnet new '{"owner": "account.testnet"}' --accountId account.testnet
```

### Create Sub-Account & Deploy
```bash
# Create sub-account
near create-account contract.account.testnet --masterAccount account.testnet --initialBalance 10

# Deploy to sub-account
near deploy --accountId contract.account.testnet --wasmFile contract.wasm
```

### Test Contract Locally
```bash
# Start local node
nearup run localnet

# Set environment
export NEAR_ENV=local

# Create account
near create-account test.test.near --masterAccount test.near --initialBalance 100

# Deploy
near deploy --accountId test.test.near --wasmFile contract.wasm
```

## Environment Variables

```bash
# .env file
NEAR_ENV=testnet
NEAR_ACCOUNT=account.testnet
CONTRACT_NAME=contract.testnet
```

## Useful Resources

- **NEAR Docs**: https://docs.near.org/
- **NEAR CLI Docs**: https://docs.near.org/tools/near-cli
- **NEAR SDK Rust**: https://www.near-sdk.io/
- **NEAR Examples**: https://github.com/near-examples
- **NEAR University**: https://www.near.university/
