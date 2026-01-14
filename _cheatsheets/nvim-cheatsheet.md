---
layout: cheatsheet
title: Neovim Cheatsheet
description: Essential Neovim commands, Lua configuration, and plugin management.
---


A comprehensive reference for Neovim (nvim), focusing on Lua configuration and modern features.

## Configuration

Neovim uses `init.lua` as the primary configuration file.

### Basics (`init.lua`)
```lua
-- Set leader key to space
vim.g.mapleader = " "

-- Options (vim.opt)
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.shiftwidth = 4         -- Shift with 4 spaces
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.ignorecase = true      -- Ignore case in search
vim.opt.smartcase = true       -- Smart case search
vim.opt.termguicolors = true   -- True color support

-- Keymaps (vim.keymap.set)
-- mode, keys, command, options
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>")
```

### Lua Basics for Nvim
```lua
-- Variables
local name = "Neovim"
print("Hello " .. name)

-- Tables (dictionaries/lists)
local plugins = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
}

-- Functions
local function setup_lsp()
    print("LSP Setup")
end

-- Require other modules (lua/my_module.lua)
require("my_module")
```

## Package Managers

### Lazy.nvim (Modern)
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
})
```

### Packer.nvim (Legacy)
```lua
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-treesitter/nvim-treesitter'
end)
```

## Built-in LSP (Language Server Protocol)

### Setup (using nvim-lspconfig)
```lua
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
```

### Keybindings
```lua
-- K: Hover documentation
-- gd: Go to definition
-- gD: Go to declaration
-- gi: Go to implementation
-- gr: References
-- <leader>rn: Rename
-- <leader>ca: Code action
```

## Treesitter (Syntax Highlighting)

### Installation
```bash
:TSInstall javascript   # Install parser
:TSUpdate               # Update parsers
:TSInstallInfo          # List installed parsers
```

### Configuration
```lua
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  highlight = {
    enable = true,
  },
}
```

## Diagnostics

```bash
:lua vim.diagnostic.open_float()  # Show diagnostic in floating window
[d                                # Previous diagnostic
]d                                # Next diagnostic
:lua vim.diagnostic.setloclist()  # Add diagnostics to location list
```

## Useful Commands

```bash
:checkhealth            # Health check for plugins and nvim
:Inspect                # Inspect highlight groups at cursor
:Tutor                  # Interactive tutorial
```
