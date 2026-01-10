---
layout: cheatsheet
title: Tmux Command Cheatsheet
description: Essential tmux commands and shortcuts for terminal multiplexing
---


A comprehensive reference for tmux terminal multiplexer commands and shortcuts.

## Getting Started

### Installation
```bash
# Ubuntu/Debian
sudo apt install tmux

# macOS
brew install tmux

# CentOS/RHEL
sudo yum install tmux
```

### Basic Usage
```bash
tmux                    # Start new session
tmux new -s mysession   # Start new session with name
tmux ls                 # List sessions
tmux attach             # Attach to last session
tmux attach -t mysession # Attach to named session
tmux kill-session -t mysession # Kill named session
```

## Key Bindings

**Default Prefix**: `Ctrl+b` (shown as `prefix` below)

### Session Management

```bash
prefix + d              # Detach from session
prefix + $              # Rename session
prefix + (              # Move to previous session
prefix + )              # Move to next session
prefix + s              # List sessions
```

### Window Management

```bash
prefix + c              # Create new window
prefix + ,              # Rename current window
prefix + &              # Kill current window
prefix + n              # Next window
prefix + p              # Previous window
prefix + 0-9            # Switch to window by number
prefix + w              # List windows
prefix + f              # Find window by name
```

### Pane Management

#### Creating Panes
```bash
prefix + %              # Split vertically (left/right)
prefix + "              # Split horizontally (top/bottom)
prefix + x              # Kill current pane
```

#### Navigating Panes
```bash
prefix + arrow key      # Move to pane in direction
prefix + o              # Cycle through panes
prefix + q              # Show pane numbers
prefix + q + number     # Jump to pane by number
prefix + {              # Swap with previous pane
prefix + }              # Swap with next pane
```

#### Resizing Panes
```bash
prefix + Ctrl+arrow     # Resize pane in direction
prefix + Alt+arrow      # Resize pane in direction (5 cells)
prefix + z              # Toggle pane zoom (fullscreen)
```

#### Pane Layouts
```bash
prefix + Space          # Cycle through layouts
prefix + Alt+1          # Even horizontal layout
prefix + Alt+2          # Even vertical layout
prefix + Alt+3          # Main horizontal layout
prefix + Alt+4          # Main vertical layout
prefix + Alt+5          # Tiled layout
```

### Copy Mode

```bash
prefix + [              # Enter copy mode
prefix + ]              # Paste buffer
prefix + =              # List all paste buffers

# In copy mode (vi-mode):
Space                   # Start selection
Enter                   # Copy selection
q                       # Quit copy mode
/                       # Search forward
?                       # Search backward
n                       # Next search result
N                       # Previous search result
```

### Other Useful Commands

```bash
prefix + :              # Enter command mode
prefix + ?              # List all key bindings
prefix + t              # Show time
prefix + i              # Display pane information
```

## Command Mode

Enter command mode with `prefix + :`, then use these commands:

### Session Commands
```bash
:new-session            # Create new session
:new -s name            # Create named session
:kill-session           # Kill current session
:kill-session -t name   # Kill named session
:rename-session name    # Rename session
```

### Window Commands
```bash
:new-window             # Create new window
:new-window -n name     # Create named window
:kill-window            # Kill current window
:rename-window name     # Rename window
:move-window -t number  # Move window to position
```

### Pane Commands
```bash
:split-window           # Split horizontally
:split-window -h        # Split vertically
:kill-pane              # Kill current pane
:resize-pane -D 10      # Resize down 10 cells
:resize-pane -U 10      # Resize up 10 cells
:resize-pane -L 10      # Resize left 10 cells
:resize-pane -R 10      # Resize right 10 cells
```

## Configuration (~/.tmux.conf)

### Basic Configuration
```bash
# Change prefix to Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Enable mouse support
set -g mouse on

# Start window numbering at 1
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Increase scrollback buffer
set -g history-limit 10000

# Enable vi mode
setw -g mode-keys vi

# Reduce escape time
set -sg escape-time 0
```

### Custom Key Bindings
```bash
# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Switch panes using Alt+arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
```

### Status Bar Customization
```bash
# Status bar position
set -g status-position bottom

# Status bar colors
set -g status-bg colour234
set -g status-fg colour137

# Window status format
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

# Status bar content
set -g status-left ''
set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
```

## Advanced Features

### Scripting Sessions
```bash
# Create a development session
tmux new-session -d -s dev
tmux rename-window -t dev:1 'editor'
tmux send-keys -t dev:1 'vim' C-m
tmux new-window -t dev:2 -n 'server'
tmux send-keys -t dev:2 'npm run dev' C-m
tmux new-window -t dev:3 -n 'shell'
tmux attach -t dev
```

### Session Sharing
```bash
# Create a shared session
tmux -S /tmp/shared new -s shared

# Allow others to attach
chmod 777 /tmp/shared

# Others can attach with
tmux -S /tmp/shared attach -t shared
```

### Synchronize Panes
```bash
# In command mode
:setw synchronize-panes on   # Enable
:setw synchronize-panes off  # Disable

# Or bind to a key
bind S setw synchronize-panes
```

## Useful Workflows

### Development Setup
```bash
# Create session with 3 panes
tmux new -s dev
prefix + "              # Split horizontal
prefix + %              # Split vertical on bottom pane

# Result: Editor top, terminal bottom-left, server bottom-right
```

### Monitoring Setup
```bash
# Create monitoring session
tmux new -s monitor
prefix + "              # Split horizontal
prefix + "              # Split again
prefix + "              # Split again

# Run different monitoring commands in each pane
# htop, tail -f logs, watch commands, etc.
```

### Remote Work
```bash
# Start persistent session on server
ssh user@server
tmux new -s work

# Do your work...

# Detach (prefix + d) and logout
# Later, reconnect and reattach
ssh user@server
tmux attach -t work
```

## Plugins (TPM - Tmux Plugin Manager)

### Installation
```bash
# Clone TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add to ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TPM (add at bottom of .tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

### Popular Plugins
```bash
# Resurrect - save/restore sessions
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Continuum - automatic save/restore
set -g @plugin 'tmux-plugins/tmux-continuum'

# Yank - better copy/paste
set -g @plugin 'tmux-plugins/tmux-yank'

# Pain control - better pane management
set -g @plugin 'tmux-plugins/tmux-pain-control'
```

### Plugin Commands
```bash
prefix + I              # Install plugins
prefix + U              # Update plugins
prefix + alt + u        # Uninstall plugins
```

## Troubleshooting

### Common Issues

**Colors not working**
```bash
# Add to ~/.tmux.conf
set -g default-terminal "screen-256color"
```

**Mouse not working**
```bash
# Enable mouse in ~/.tmux.conf
set -g mouse on
```

**Copy/paste issues**
```bash
# macOS - install reattach-to-user-namespace
brew install reattach-to-user-namespace

# Add to ~/.tmux.conf
set -g default-command "reattach-to-user-namespace -l $SHELL"
```

## Quick Reference Card

| Action | Command |
|--------|---------|
| New session | `tmux new -s name` |
| List sessions | `tmux ls` |
| Attach session | `tmux attach -t name` |
| Detach | `prefix + d` |
| New window | `prefix + c` |
| Next window | `prefix + n` |
| Split vertical | `prefix + %` |
| Split horizontal | `prefix + "` |
| Navigate panes | `prefix + arrow` |
| Resize pane | `prefix + Ctrl+arrow` |
| Zoom pane | `prefix + z` |
| Copy mode | `prefix + [` |
| Paste | `prefix + ]` |
| Command mode | `prefix + :` |
| List keys | `prefix + ?` |

## Tips

1. **Use meaningful session names** - easier to identify and attach
2. **Learn copy mode** - essential for working with terminal output
3. **Customize your prefix** - `Ctrl+a` is often more comfortable
4. **Enable mouse support** - makes tmux more accessible
5. **Use layouts** - quickly organize panes
6. **Script your sessions** - automate common setups
7. **Use plugins** - extend functionality easily
8. **Keep config simple** - start minimal, add as needed
9. **Practice shortcuts** - muscle memory is key
10. **Detach, don't close** - preserve your work

## Resources

- Official Documentation: https://github.com/tmux/tmux/wiki
- Tmux Cheat Sheet: https://tmuxcheatsheet.com/
- Awesome Tmux: https://github.com/rothgar/awesome-tmux
- TPM: https://github.com/tmux-plugins/tpm
