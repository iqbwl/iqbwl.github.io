---
layout: cheatsheet
title: Node.js Command Cheatsheet
description: Essential CLI commands for Node.js, NPM, NVM, PM2, Yarn, Deno, and Bun
---


A comprehensive reference for the Node.js ecosystem command-line tools.

## NVM (Node Version Manager)

### Installation
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# OR
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

### Version Management
```bash
nvm install 20               # Install Node.js v20
nvm install --lts            # Install latest LTS version
nvm use 20                   # Switch to Node.js v20
nvm use default              # Switch to default version
nvm uninstall 18             # Uninstall Node.js v18
```

### Info & Aliases
```bash
nvm ls                       # List installed versions
nvm ls-remote                # List all remote versions
nvm alias default 20         # Set default version
nvm current                  # Show current version
```

## Node.js CLI

### Execution
```bash
node app.js                  # Run script
node -e "console.log(1+1)"   # Evaluate script string
node --watch app.js          # Run with experimental watch mode
node --check app.js          # Check syntax without executing
```

### Options
```bash
node --version               # Print version
node --max-old-space-size=4096 # Increase memory limit to 4GB
node --env-file=.env app.js  # Load environment variables (.env)
```

## NPM (Package Manager)

### Basics
```bash
npm init -y                  # Initialize project (defaults)
npm install                  # Install all dependencies
npm install pkg              # Install package
npm install -g pkg           # Install globally
npm install --save-dev pkg   # Install dev dependency
npm uninstall pkg            # Remove package
```

### Maintenance
```bash
npm update                   # Update packages
npm outdated                 # Check for outdated packages
npm audit                    # Check for security vulnerabilities
npm audit fix                # Fix vulnerabilities
npm cache clean --force      # Clear cache
npx pkg                      # Run package without installing
```

## PM2 (Process Manager)

### Installation
```bash
npm install pm2@latest -g
# OR
yarn global add pm2
```

### Process Management
```bash
pm2 start app.js             # Start application
pm2 start app.js --name "api" # Start with name
pm2 stop all                 # Stop all processes
pm2 restart app_name         # Restart specific process
pm2 reload all               # Zero-downtime reload
pm2 delete app_name          # Delete process from list
```

### Monitoring & Logs
```bash
pm2 list                     # List all processes
pm2 monit                    # Graphic dashboard
pm2 show app_name            # Show process details
pm2 logs                     # Stream all logs
pm2 logs app_name            # Stream logs for app
pm2 flush                    # Clear all logs
```

## Yarn (Package Manager)

### Installation
```bash
corepack enable              # Enable Corepack (Node.js >=16.10)
corepack prepare yarn@stable --activate
# OR (Legacy)
npm install --global yarn
```

### Dependencies
```bash
yarn init                    # Initialize project
yarn add package             # Install package
yarn add package --dev       # Install dev dependency
yarn global add package      # Install globally
yarn remove package          # Uninstall package
yarn upgrade package         # Upgrade package
```

### Workspaces
```bash
yarn workspace <name> add <pkg> # Add package to workspace
yarn workspaces run <cmd>       # Run command in all workspaces
```

## Bun (Runtime & Tooling)

### Installation
```bash
curl -fsSL https://bun.sh/install | bash
# Windows: powershell -c "irm bun.sh/install.ps1 | iex"
```

### Runtime
```bash
bun run app.ts               # Run TypeScript/JS file
bun run dev                  # Run 'dev' script from package.json
bun test                     # Run tests
bun repl                     # Start REPL
```

### Package Manager
```bash
bun install                  # Install dependencies (fast)
bun add package              # Add dependency
bun add -d package           # Add dev dependency
bun remove package           # Remove dependency
bun upgrade                  # Upgrade Bun
```

## Deno (Runtime)

### Installation
```bash
curl -fsSL https://deno.land/x/install/install.sh | sh
# Windows: powershell -c "irm https://deno.land/install.ps1 | iex"
```

### Execution
```bash
deno run main.ts             # Run local script
deno run https://.../mod.ts  # Run remote script
deno run -A main.ts          # Run with all permissions
deno run --allow-net app.ts  # Run with network permission
```

### Tooling
```bash
deno task start              # Run task from deno.json
deno test                    # Run tests
deno fmt                     # Format code
deno lint                    # Lint code
deno compile app.ts          # Compile to executable
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `nvm use --lts` | Switch to LTS Node |
| `npm i -g pkg` | Global Install |
| `npx create-react-app` | Run one-off |
| `pm2 start app.js` | Keep app alive |
| `bun run dev` | Fast dev server |
