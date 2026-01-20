---
layout: cheatsheet
title: Solana CLI Cheatsheet
description: Solana CLI includes tools to interact with the Solana cluster, manage keys, and deploy programs.
---


Solana CLI includes tools to interact with the Solana cluster, manage keys, and deploy programs.


## Installation

```bash
# Install Solana CLI
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"

# Update Solana CLI
solana-install update

# Check version
solana --version
```

## Configuration

### Cluster Management
```bash
# Set cluster to mainnet
solana config set --url https://api.mainnet-beta.solana.com

# Set cluster to devnet
solana config set --url https://api.devnet.solana.com

# Set cluster to testnet
solana config set --url https://api.testnet.solana.com

# Set cluster to localhost
solana config set --url http://localhost:8899

# Get current config
solana config get

# Get cluster info
solana cluster-version
```

### Keypair Management
```bash
# Generate new keypair
solana-keygen new

# Generate with custom output
solana-keygen new --outfile ~/my-keypair.json

# Generate with seed phrase
solana-keygen new --no-bip39-passphrase

# Recover from seed phrase
solana-keygen recover

# Get pubkey from keypair
solana-keygen pubkey ~/my-keypair.json

# Verify keypair
solana-keygen verify <PUBKEY> ~/my-keypair.json

# Set default keypair
solana config set --keypair ~/my-keypair.json
```

## Wallet Operations

### Account Management
```bash
# Get account balance
solana balance

# Get balance of specific address
solana balance <ADDRESS>

# Get account info
solana account <ADDRESS>

# Create account
solana create-account <KEYPAIR> <AMOUNT>
```

### Transfers
```bash
# Transfer SOL
solana transfer <RECIPIENT> <AMOUNT>

# Transfer with specific keypair
solana transfer --from ~/keypair.json <RECIPIENT> <AMOUNT>

# Transfer all SOL
solana transfer --from ~/keypair.json <RECIPIENT> ALL

# Transfer with memo
solana transfer <RECIPIENT> <AMOUNT> --with-memo "Payment for services"
```

### Airdrops (Devnet/Testnet only)
```bash
# Request airdrop
solana airdrop 1

# Request airdrop to specific address
solana airdrop 2 <ADDRESS>
```

## Validators & Staking

### Validator Operations
```bash
# Get validators
solana validators

# Get validator info
solana validator-info get

# Publish validator info
solana validator-info publish "My Validator" -w https://example.com

# Get vote accounts
solana vote-account <VOTE_ACCOUNT>

# Get leader schedule
solana leader-schedule
```

### Staking
```bash
# Create stake account
solana create-stake-account ~/stake-keypair.json <AMOUNT>

# Delegate stake
solana delegate-stake ~/stake-keypair.json <VOTE_ACCOUNT>

# Deactivate stake
solana deactivate-stake ~/stake-keypair.json

# Withdraw stake
solana withdraw-stake ~/stake-keypair.json <RECIPIENT> <AMOUNT>

# Get stake account
solana stake-account ~/stake-keypair.json

# Split stake account
solana split-stake ~/stake-keypair.json ~/new-stake.json <AMOUNT>
```

## Program Development

### Anchor Framework
```bash
# Install Anchor
cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
avm install latest
avm use latest

# Initialize new project
anchor init my-project

# Build program
anchor build

# Test program
anchor test

# Deploy program
anchor deploy

# Get program ID
anchor keys list

# Upgrade program
anchor upgrade <PROGRAM_ID> target/deploy/program.so
```

### Native Program Development
```bash
# Build program
cargo build-bpf

# Deploy program
solana program deploy /path/to/program.so

# Get program account
solana program show <PROGRAM_ID>

# Extend program
solana program extend <PROGRAM_ID> <BYTES>

# Close program
solana program close <PROGRAM_ID>

# Set program authority
solana program set-upgrade-authority <PROGRAM_ID> --new-upgrade-authority <ADDRESS>
```

## SPL Token Operations

### Token Management
```bash
# Create new token
spl-token create-token

# Create token with decimals
spl-token create-token --decimals 6

# Get token supply
spl-token supply <TOKEN_ADDRESS>

# Create token account
spl-token create-account <TOKEN_ADDRESS>

# Get token accounts
spl-token accounts

# Get balance
spl-token balance <TOKEN_ADDRESS>
```

### Minting & Burning
```bash
# Mint tokens
spl-token mint <TOKEN_ADDRESS> <AMOUNT>

# Mint to specific account
spl-token mint <TOKEN_ADDRESS> <AMOUNT> <RECIPIENT>

# Burn tokens
spl-token burn <TOKEN_ACCOUNT> <AMOUNT>

# Disable minting
spl-token authorize <TOKEN_ADDRESS> mint --disable
```

### Transfers
```bash
# Transfer tokens
spl-token transfer <TOKEN_ADDRESS> <AMOUNT> <RECIPIENT>

# Transfer with funding
spl-token transfer --fund-recipient <TOKEN_ADDRESS> <AMOUNT> <RECIPIENT>

# Transfer all tokens
spl-token transfer <TOKEN_ADDRESS> ALL <RECIPIENT>
```

### Token Authority
```bash
# Set mint authority
spl-token authorize <TOKEN_ADDRESS> mint <NEW_AUTHORITY>

# Set freeze authority
spl-token authorize <TOKEN_ADDRESS> freeze <NEW_AUTHORITY>

# Revoke authority
spl-token authorize <TOKEN_ADDRESS> mint --disable
```

## NFT Operations

### Metaplex
```bash
# Install Metaplex CLI
npm install -g @metaplex-foundation/js

# Upload assets
metaplex upload ./assets

# Create candy machine
metaplex create_candy_machine

# Mint NFT
metaplex mint_one_token

# Update candy machine
metaplex update_candy_machine

# Verify collection
metaplex verify_collection
```

## Transaction & Block Info

```bash
# Get transaction
solana confirm <SIGNATURE>

# Get transaction details
solana transaction-history <ADDRESS>

# Get block
solana block <SLOT>

# Get block time
solana block-time <SLOT>

# Get recent blockhash
solana recent-blockhash

# Get epoch info
solana epoch-info

# Get slot
solana slot
```

## Performance & Monitoring

```bash
# Get TPS
solana tps

# Ping cluster
solana ping

# Get cluster nodes
solana cluster-nodes

# Get gossip
solana gossip

# Get performance samples
solana block-production

# Get inflation
solana inflation
```

## Local Development

### Test Validator
```bash
# Start local validator
solana-test-validator

# Start with custom ledger
solana-test-validator --ledger /path/to/ledger

# Start with specific programs
solana-test-validator --bpf-program <PROGRAM_ID> /path/to/program.so

# Reset ledger
solana-test-validator --reset

# Clone account from mainnet
solana-test-validator --clone <ADDRESS>

# Set compute unit limit
solana-test-validator --compute-unit-limit 1400000
```

### Logs
```bash
# Stream logs
solana logs

# Stream logs for specific program
solana logs <PROGRAM_ID>

# Stream all logs
solana logs --all
```

## Utilities

```bash
# Decode transaction
solana decode-transaction <BASE64_TX>

# Get rent
solana rent <BYTES>

# Get minimum balance for rent exemption
solana minimum-balance <BYTES>

# Resolve DNS
solana resolve-signer <DOMAIN>

# Get fees
solana fees

# Get feature status
solana feature status
```

## Common Workflows

### Deploy Program
```bash
# Build
anchor build

# Get program ID
anchor keys list

# Deploy
anchor deploy

# Verify
solana program show <PROGRAM_ID>
```

### Create & Mint Token
```bash
# Create token
spl-token create-token

# Create account
spl-token create-account <TOKEN>

# Mint
spl-token mint <TOKEN> 1000000

# Check balance
spl-token balance <TOKEN>
```

### Stake SOL
```bash
# Create stake account
solana create-stake-account ~/stake.json 10

# Delegate
solana delegate-stake ~/stake.json <VOTE_ACCOUNT>

# Check status
solana stake-account ~/stake.json
```

## Environment Variables

```bash
# Set in .bashrc or .zshrc
export SOLANA_KEYPAIR=~/my-keypair.json
export ANCHOR_WALLET=~/my-keypair.json
export ANCHOR_PROVIDER_URL=https://api.devnet.solana.com
```

## Useful Resources

- **Solana Docs**: https://docs.solana.com/
- **Anchor Docs**: https://www.anchor-lang.com/
- **Solana Cookbook**: https://solanacookbook.com/
- **Metaplex Docs**: https://docs.metaplex.com/
- **SPL Token**: https://spl.solana.com/token
