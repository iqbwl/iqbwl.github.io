---
layout: cheatsheet
title: Vim Command Cheatsheet
description: Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.
---


Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.


## Modes

Vim has several modes:
- **Normal Mode** - Navigate and manipulate text (default)
- **Insert Mode** - Insert text
- **Visual Mode** - Select text
- **Command Mode** - Execute commands

## Basic Commands

### Opening and Saving Files
```bash
vim file.txt           # Open file
vim +10 file.txt       # Open at line 10
vim +/pattern file.txt # Open at first match

:w                     # Save
:w filename            # Save as
:wq or :x or ZZ        # Save and quit
:q                     # Quit
:q!                    # Quit without saving
:qa                    # Quit all windows
:wqa                   # Save and quit all
```

### Mode Switching
```bash
i                      # Insert before cursor
I                      # Insert at beginning of line
a                      # Append after cursor
A                      # Append at end of line
o                      # Open new line below
O                      # Open new line above
Esc                    # Return to normal mode
v                      # Visual mode (character)
V                      # Visual mode (line)
Ctrl+v                 # Visual block mode
:                      # Command mode
```

## Navigation

### Basic Movement
```bash
h, j, k, l             # Left, down, up, right
w                      # Next word
b                      # Previous word
e                      # End of word
0                      # Start of line
^                      # First non-blank character
$                      # End of line
gg                     # First line
G                      # Last line
10G or :10             # Go to line 10
```

### Screen Movement
```bash
Ctrl+f                 # Page down
Ctrl+b                 # Page up
Ctrl+d                 # Half page down
Ctrl+u                 # Half page up
H                      # Top of screen
M                      # Middle of screen
L                      # Bottom of screen
zz                     # Center cursor on screen
zt                     # Cursor to top of screen
zb                     # Cursor to bottom of screen
```

### Advanced Navigation
```bash
%                      # Jump to matching bracket
*                      # Next occurrence of word under cursor
#                      # Previous occurrence of word under cursor
f{char}                # Jump to next {char} on line
F{char}                # Jump to previous {char} on line
t{char}                # Jump before next {char}
T{char}                # Jump before previous {char}
;                      # Repeat last f/F/t/T
,                      # Repeat last f/F/t/T backwards
```

## Editing

### Inserting Text
```bash
i                      # Insert before cursor
I                      # Insert at line start
a                      # Append after cursor
A                      # Append at line end
o                      # Open line below
O                      # Open line above
```

### Deleting
```bash
x                      # Delete character
X                      # Delete character before cursor
dw                     # Delete word
dd                     # Delete line
D                      # Delete to end of line
d$                     # Delete to end of line
d0                     # Delete to start of line
dG                     # Delete to end of file
dgg                    # Delete to start of file
```

### Copying and Pasting
```bash
yy or Y                # Yank (copy) line
yw                     # Yank word
y$                     # Yank to end of line
p                      # Paste after cursor
P                      # Paste before cursor
```

### Changing Text
```bash
r{char}                # Replace character
R                      # Replace mode
cw                     # Change word
cc or S                # Change line
C                      # Change to end of line
s                      # Substitute character
~                      # Toggle case
u                      # Undo
Ctrl+r                 # Redo
.                      # Repeat last command
```

## Search and Replace

### Searching
```bash
/pattern               # Search forward
?pattern               # Search backward
n                      # Next match
N                      # Previous match
*                      # Search word under cursor forward
#                      # Search word under cursor backward
:noh                   # Clear search highlighting
```

### Search and Replace
```bash
:s/old/new/            # Replace first on line
:s/old/new/g           # Replace all on line
:%s/old/new/g          # Replace all in file
:%s/old/new/gc         # Replace all with confirmation
:10,20s/old/new/g      # Replace in lines 10-20
```

## Visual Mode

### Selection
```bash
v                      # Character-wise visual mode
V                      # Line-wise visual mode
Ctrl+v                 # Block-wise visual mode
o                      # Move to other end of selection
gv                     # Reselect last selection
```

### Operations on Selection
```bash
d                      # Delete selection
y                      # Yank selection
c                      # Change selection
>                      # Indent right
<                      # Indent left
=                      # Auto-indent
u                      # Lowercase
U                      # Uppercase
~                      # Toggle case
```

## Multiple Files

### Buffers
```bash
:e filename            # Edit file
:bn                    # Next buffer
:bp                    # Previous buffer
:bd                    # Delete buffer
:ls                    # List buffers
:b number              # Go to buffer number
```

### Windows
```bash
:split or :sp          # Horizontal split
:vsplit or :vsp        # Vertical split
Ctrl+w s               # Horizontal split
Ctrl+w v               # Vertical split
Ctrl+w w               # Switch windows
Ctrl+w h/j/k/l         # Navigate windows
Ctrl+w c               # Close window
Ctrl+w o               # Close other windows
Ctrl+w =               # Equal size windows
Ctrl+w +/-             # Resize window
```

### Tabs
```bash
:tabnew                # New tab
:tabnew file           # Open file in new tab
gt                     # Next tab
gT                     # Previous tab
:tabclose              # Close tab
:tabonly               # Close other tabs
```

## Advanced Features

### Marks
```bash
ma                     # Set mark 'a'
`a                     # Jump to mark 'a'
'a                     # Jump to line of mark 'a'
:marks                 # List marks
```

### Macros
```bash
qa                     # Record macro 'a'
q                      # Stop recording
@a                     # Play macro 'a'
@@                     # Replay last macro
10@a                   # Play macro 10 times
```

### Registers
```bash
"ayy                   # Yank to register 'a'
"ap                    # Paste from register 'a'
:reg                   # Show registers
"+y                    # Yank to system clipboard
"+p                    # Paste from system clipboard
```

### Folding
```bash
zf                     # Create fold
zo                     # Open fold
zc                     # Close fold
za                     # Toggle fold
zR                     # Open all folds
zM                     # Close all folds
```

## Configuration (.vimrc)

### Basic Settings
```vim
" Enable syntax highlighting
syntax on

" Show line numbers
set number
set relativenumber

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" UI improvements
set showcmd
set showmatch
set ruler
set cursorline

" Enable mouse
set mouse=a

" Disable swap files
set noswapfile
set nobackup
```

### Key Mappings
```vim
" Map leader key
let mapleader = ","

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <leader>h :noh<CR>

" Navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
```

## Useful Commands

### Text Manipulation
```bash
:sort                  # Sort lines
:sort u                # Sort and remove duplicates
:g/pattern/d           # Delete lines matching pattern
:v/pattern/d           # Delete lines NOT matching pattern
:retab                 # Convert tabs to spaces
```

### File Operations
```bash
:w !sudo tee %         # Save with sudo
:r filename            # Read file into current
:r !command            # Read command output
:!command              # Execute shell command
```

### Indentation
```bash
>>                     # Indent line
<<                     # Unindent line
==                     # Auto-indent line
gg=G                   # Auto-indent entire file
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `i` | Insert mode |
| `Esc` | Normal mode |
| `:w` | Save |
| `:q` | Quit |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `/text` | Search |
| `n` | Next match |
| `:%s/old/new/g` | Replace all |
| `gg` | First line |
| `G` | Last line |
| `v` | Visual mode |
| `.` | Repeat command |

## Tips

1. **Start with vimtutor** - Run `vimtutor` in terminal
2. **Learn gradually** - Master basics before advanced features
3. **Use motions** - Combine commands with motions (e.g., `d3w`)
4. **Practice regularly** - Muscle memory is key
5. **Customize .vimrc** - Make Vim work for you
6. **Use plugins** - Extend functionality (vim-plug, Vundle)
7. **Learn one feature at a time** - Don't overwhelm yourself
8. **Use visual mode** - Great for complex selections
9. **Master search** - Powerful for navigation
10. **Read :help** - Built-in documentation is excellent

## Resources

- Vim Documentation: `:help`
- Vimtutor: `vimtutor` command
- Vim Adventures: https://vim-adventures.com/
- Vim Cheat Sheet: https://vim.rtorr.com/
