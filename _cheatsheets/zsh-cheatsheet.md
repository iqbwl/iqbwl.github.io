---
layout: cheatsheet
title: Zsh Cheatsheet
description: Essential Zsh commands, configuration, and tips
---


A comprehensive reference for Z Shell (zsh) configuration and usage.

## Configuration (.zshrc)

### Basics
```zsh
# Reload configuration
source ~/.zshrc

# Check zsh version
zsh --version

# Set default shell to zsh
chsh -s $(which zsh)
```

### Options (setopt)
```zsh
setopt autocd              # Change directory without cd
setopt extendedglob        # Enable extended globbing
setopt histignorealldups   # Ignore duplicate history entries
setopt sharehistory        # Share history across terminals
setopt incappendhistory    # Append to history immediately
unsetopt beep              # Disable beep
```

## Globbing

### Extended Globbing
Requires `setopt extendedglob`.

```zsh
ls *.txt                   # Basic match
ls **/*.txt                # Recursive match
ls *.(txt|md)              # Match txt or md
ls ^*.log                  # Match everything except logs
ls file<1-10>.txt          # Match number range
ls *(.)                    # Match only files
ls *(/)                    # Match only directories
ls *(@)                    # Match only symlinks
ls *(Lk+100)               # Files > 100KB
ls *(Lm-10)               # Files modified < 10 mins ago
```

## Keybindings (ZLE)

### Emacs Mode (Default)
```zsh
Ctrl + A      # Go to beginning of line
Ctrl + E      # Go to end of line
Ctrl + U      # Clear line before cursor
Ctrl + K      # Clear line after cursor
Ctrl + W      # Delete word before cursor
Ctrl + R      # Search history
```

### Vi Mode
```zsh
# Enable Vi mode
bindkey -v
```

## Prompt Customization

### Expansion
```zsh
%n            # Username
%m            # Hostname
%d            # Current directory (full)
%~            # Current directory (tildified)
%t            # Time (12-hour)
%T            # Time (24-hour)
%#            # '#' for root, '%' for user
```

### Example Prompt
```zsh
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %# '
```

## Parameter Expansion

```zsh
name="Z Shell"
echo ${name:u}        # Uppercase (Z SHELL)
echo ${name:l}        # Lowercase (z shell)
echo ${name:0:1}      # Substring (Z)
echo ${#name}         # Length (7)
```

## Oh My Zsh (Popular Framework)

### Management
```zsh
omz update            # Update Oh My Zsh
omz version           # Check version
```

### Plugins (enable in .zshrc)
```zsh
plugins=(
  git
  z
  docker
  kubectl
  syntax-highlighting
  autosuggestions
)
```

## Built-ins

### Directory Navigation
```zsh
d             # List directory stack
cd -          # Go to previous directory
cd -2         # Go to 2nd previous directory (with autocd)
```
