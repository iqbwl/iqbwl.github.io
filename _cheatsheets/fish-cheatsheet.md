---
layout: cheatsheet
title: Fish Cheatsheet
description: Essential Fish shell commands, syntax, and configuration
---


A comprehensive reference for the Friendly Interactive SHell (fish).

## Basics

### Variables
Fish uses `set` instead of `=`.
```fish
set name "Fish"              # Set variable
echo $name                   # Use variable
set -x PATH $PATH /new/path  # Export variable (Global)
set -U name "Fish"           # Universal variable (Persistent)
set -e name                  # Erase variable
```

### Substitution
```fish
echo (date)                  # Command substitution (no backticks or $())
echo $status                 # Exit status of last command
```

## Control Flow

### If Statements
```fish
if test -f foo.txt
    echo "File exists"
else if test -d foo
    echo "Directory exists"
else
    echo "Nothing"
end
```

### Loops
```fish
# For loop
for i in (seq 1 5)
    echo $i
end

# While loop
while test $count -lt 5
    echo $count
    set count (math $count + 1)
end
```

## Functions

### Definition
```fish
function say_hello
    echo "Hello $argv[1]"
end
say_hello "World"

# Save function for autoloading
funcsave say_hello
```

## Abbreviations

Better than aliases because they expand in place.
```fish
abbr -a gco git checkout
abbr -a ga git add
```

## Keybindings

### Modes
Fish has Emacs keybindings by default.
```fish
fish_vi_key_bindings         # Enable Vi mode
fish_default_key_bindings    # Enable Emacs mode
```

## Prompt Customization

### fish_prompt
Modify the `fish_prompt` function.
```fish
function fish_prompt
    set_color purple
    echo -n (whoami)
    set_color normal
    echo -n "@"
    set_color yellow
    echo -n (hostname)
    set_color normal
    echo -n " "
    echo -n (prompt_pwd)
    echo -n "> "
end
```

## Directory Navigation

### History
```fish
prevd                        # Go back
nextd                        # Go forward
dirh                         # Print directory history
cd -                         # Go to previous directory
```

## Configuration

### config.fish
Located at `~/.config/fish/config.fish`.
```fish
if status is-interactive
    # Commands to run in interactive sessions can go here
end
```

## Useful Built-ins
```fish
math "1 + 2"                 # Arithmetic
string match "foo*" "foobar" # String matching
string sub -s 1 -l 2 "foo"   # Substring
```
