---
layout: cheatsheet
title: Bash Scripting Cheatsheet
description: Essential Bash scripting syntax and commands
---


A comprehensive reference for Bash shell scripting.

## Basics

### Shebang & Execution
```bash
#!/bin/bash                          # Shebang line
#!/usr/bin/env bash                  # Portable shebang

chmod +x script.sh                   # Make executable
./script.sh                          # Run script
bash script.sh                       # Run with bash
```

### Variables
```bash
name="John"                          # Assign variable (no spaces!)
echo $name                           # Use variable
echo ${name}                         # Safer syntax
readonly PI=3.14                     # Read-only variable
unset name                           # Delete variable

# Special variables
$0                                   # Script name
$1, $2, ...                          # Arguments
$#                                   # Number of arguments
$@                                   # All arguments
$?                                   # Exit status of last command
$$                                   # Process ID
$!                                   # PID of last background command
```

### String Operations
```bash
str="Hello World"
${#str}                              # Length
${str:0:5}                           # Substring (Hello)
${str/World/Bash}                    # Replace first
${str//o/0}                          # Replace all
${str^^}                             # Uppercase
${str,,}                             # Lowercase
${str#pattern}                       # Remove shortest match from start
${str##pattern}                      # Remove longest match from start
${str%pattern}                       # Remove shortest match from end
${str%%pattern}                      # Remove longest match from end
```

### Arrays
```bash
arr=(one two three)                  # Create array
${arr[0]}                            # First element
${arr[@]}                            # All elements
${#arr[@]}                           # Array length
arr+=(four)                          # Append
unset arr[1]                         # Delete element

# Associative arrays
declare -A dict
dict[key]="value"
${dict[key]}
${!dict[@]}                          # All keys
```

## Control Flow

### If Statements
```bash
if [ condition ]; then
    # code
elif [ condition ]; then
    # code
else
    # code
fi

# One-liner
[ condition ] && echo "true" || echo "false"
```

### Test Conditions
```bash
# File tests
[ -e file ]                          # Exists
[ -f file ]                          # Is regular file
[ -d dir ]                           # Is directory
[ -r file ]                          # Is readable
[ -w file ]                          # Is writable
[ -x file ]                          # Is executable
[ -s file ]                          # Not empty
[ file1 -nt file2 ]                  # Newer than
[ file1 -ot file2 ]                  # Older than

# String tests
[ -z "$str" ]                        # Empty string
[ -n "$str" ]                        # Not empty
[ "$str1" = "$str2" ]                # Equal
[ "$str1" != "$str2" ]               # Not equal

# Numeric tests
[ $a -eq $b ]                        # Equal
[ $a -ne $b ]                        # Not equal
[ $a -lt $b ]                        # Less than
[ $a -le $b ]                        # Less or equal
[ $a -gt $b ]                        # Greater than
[ $a -ge $b ]                        # Greater or equal

# Logical operators
[ condition1 ] && [ condition2 ]     # AND
[ condition1 ] || [ condition2 ]     # OR
[ ! condition ]                      # NOT
```

### Loops
```bash
# For loop
for i in 1 2 3 4 5; do
    echo $i
done

for i in {1..10}; do
    echo $i
done

for ((i=0; i<10; i++)); do
    echo $i
done

for file in *.txt; do
    echo $file
done

# While loop
while [ condition ]; do
    # code
done

# Until loop
until [ condition ]; do
    # code
done

# Loop control
break                                # Exit loop
continue                             # Skip to next iteration
```

### Case Statement
```bash
case $var in
    pattern1)
        # code
        ;;
    pattern2|pattern3)
        # code
        ;;
    *)
        # default
        ;;
esac
```

## Functions

### Function Definition
```bash
# Method 1
function_name() {
    # code
}

# Method 2
function function_name {
    # code
}

# With parameters
greet() {
    echo "Hello, $1!"
}
greet "World"

# Return value
add() {
    return $(($1 + $2))
}
add 5 3
echo $?                              # 8
```

## Input/Output

### Reading Input
```bash
read var                             # Read into variable
read -p "Enter name: " name          # With prompt
read -s password                     # Silent (for passwords)
read -t 5 var                        # Timeout after 5 seconds
read -a arr                          # Read into array
```

### Output
```bash
echo "text"                          # Print text
echo -n "text"                       # No newline
echo -e "line1\nline2"               # Enable escape sequences
printf "Name: %s\n" "$name"          # Formatted output
```

### Redirection
```bash
command > file                       # Redirect stdout (overwrite)
command >> file                      # Redirect stdout (append)
command 2> file                      # Redirect stderr
command &> file                      # Redirect both
command < file                       # Redirect stdin
command1 | command2                  # Pipe output
command > /dev/null 2>&1             # Discard all output
```

## File Operations

### File Reading
```bash
# Read file line by line
while IFS= read -r line; do
    echo "$line"
done < file.txt

# Read entire file
content=$(<file.txt)

# Read into array
mapfile -t lines < file.txt
```

### File Writing
```bash
cat > file.txt << EOF
Line 1
Line 2
EOF

# Append
cat >> file.txt << EOF
Line 3
EOF
```

## Command Substitution

### Capturing Output
```bash
result=$(command)                    # Preferred
result=`command`                     # Old style

files=$(ls *.txt)
count=$(wc -l < file.txt)
date=$(date +%Y-%m-%d)
```

## Arithmetic

### Arithmetic Operations
```bash
# Using (( ))
((a = 5 + 3))
((a++))
((a--))
result=$((5 + 3))

# Using let
let "a = 5 + 3"
let a++

# Using expr
result=$(expr 5 + 3)

# Operators: + - * / % ** (power)
```

## String Manipulation

### Common Operations
```bash
# Concatenation
str1="Hello"
str2="World"
result="$str1 $str2"

# Check if contains
[[ "$str" == *"substring"* ]]

# Split string
IFS=',' read -ra arr <<< "$str"

# Trim whitespace
str="  text  "
trimmed=$(echo "$str" | xargs)
```

## Error Handling

### Exit Codes
```bash
command
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failed"
fi

# Exit script
exit 0                               # Success
exit 1                               # Error

# Set -e: exit on error
set -e

# Set -u: exit on undefined variable
set -u

# Set -x: print commands
set -x
```

### Try-Catch Pattern
```bash
if command; then
    echo "Success"
else
    echo "Failed"
    exit 1
fi

# Or
command || { echo "Failed"; exit 1; }
```

## Useful Patterns

### Check if Command Exists
```bash
if command -v git &> /dev/null; then
    echo "Git is installed"
fi
```

### Parse Arguments
```bash
while getopts "a:b:c" opt; do
    case $opt in
        a) arg_a=$OPTARG ;;
        b) arg_b=$OPTARG ;;
        c) flag_c=true ;;
        \?) echo "Invalid option" ;;
    esac
done
```

### Progress Bar
```bash
for i in {1..100}; do
    echo -ne "Progress: $i%\r"
    sleep 0.1
done
echo
```

### Temporary Files
```bash
tmpfile=$(mktemp)
trap "rm -f $tmpfile" EXIT
```

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `$var` | Variable |
| `${var}` | Variable (safer) |
| `$((expr))` | Arithmetic |
| `$(command)` | Command substitution |
| `[ test ]` | Test condition |
| `[[ test ]]` | Extended test |
| `&&` | AND |
| `\|\|` | OR |
| `!` | NOT |
| `>` | Redirect output |
| `\|` | Pipe |

## Best Practices

1. **Use shellcheck** for linting
2. **Quote variables** to prevent word splitting
3. **Use [[ ]]** instead of [ ] for tests
4. **Set -euo pipefail** for safer scripts
5. **Use functions** for reusable code
6. **Add comments** for clarity
7. **Handle errors** properly
8. **Use meaningful variable names**
9. **Test edge cases**
10. **Keep scripts simple** and focused

## Resources

- Bash Manual: https://www.gnu.org/software/bash/manual/
- ShellCheck: https://www.shellcheck.net/
- Bash Guide: https://mywiki.wooledge.org/BashGuide
- Explainshell: https://explainshell.com/
