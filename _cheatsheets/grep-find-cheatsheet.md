---
layout: cheatsheet
title: Grep & Find Command Cheatsheet
description: Essential grep and find commands for searching
---

# Grep & Find Command Cheatsheet

A comprehensive reference for grep and find commands.

## Grep Basics

### Basic Search
```bash
grep "pattern" file                  # Search in file
grep "pattern" file1 file2           # Search in multiple files
grep "pattern" *.txt                 # Search in all .txt files
grep -r "pattern" directory          # Recursive search
grep -R "pattern" directory          # Recursive (follow symlinks)
```

### Common Options
```bash
grep -i "pattern" file               # Case-insensitive
grep -v "pattern" file               # Invert match (exclude)
grep -n "pattern" file               # Show line numbers
grep -c "pattern" file               # Count matches
grep -l "pattern" *.txt              # List files with matches
grep -L "pattern" *.txt              # List files without matches
grep -w "word" file                  # Match whole word
grep -x "line" file                  # Match whole line
grep -A 3 "pattern" file             # Show 3 lines after
grep -B 3 "pattern" file             # Show 3 lines before
grep -C 3 "pattern" file             # Show 3 lines around
```

### Regular Expressions
```bash
grep "^pattern" file                 # Start of line
grep "pattern$" file                 # End of line
grep "patt.rn" file                  # Any single character
grep "patt*rn" file                  # Zero or more
grep "patt.*rn" file                 # Any characters
grep "patt[ae]rn" file               # Character class
grep "patt[^ae]rn" file              # Negated class
grep -E "pattern1|pattern2" file     # OR (extended regex)
grep -P "\d+" file                   # Perl regex (digits)
```

### Practical Examples
```bash
grep -r "TODO" .                     # Find all TODOs
grep -rn "function" --include="*.js" .  # Search in JS files
grep -v "^#" config.txt              # Exclude comments
grep -E "error|warning" log.txt      # Find errors or warnings
ps aux | grep nginx                  # Find process
history | grep ssh                   # Search command history
```

## Find Basics

### Find by Name
```bash
find /path -name "file.txt"          # Find by exact name
find /path -name "*.txt"             # Find by pattern
find /path -iname "*.TXT"            # Case-insensitive
find /path -not -name "*.txt"        # Exclude pattern
find /path -name "*.txt" -o -name "*.md"  # OR condition
```

### Find by Type
```bash
find /path -type f                   # Files only
find /path -type d                   # Directories only
find /path -type l                   # Symbolic links
find /path -type f -empty            # Empty files
find /path -type d -empty            # Empty directories
```

### Find by Size
```bash
find /path -size +100M               # Larger than 100MB
find /path -size -10k                # Smaller than 10KB
find /path -size 50M                 # Exactly 50MB
find /path -size +1G                 # Larger than 1GB
```

### Find by Time
```bash
find /path -mtime -7                 # Modified in last 7 days
find /path -mtime +30                # Modified more than 30 days ago
find /path -atime -1                 # Accessed in last 24 hours
find /path -ctime +7                 # Changed more than 7 days ago
find /path -mmin -60                 # Modified in last 60 minutes
find /path -newer file.txt           # Newer than file.txt
```

### Find by Permissions
```bash
find /path -perm 644                 # Exact permissions
find /path -perm -644                # At least these permissions
find /path -perm /u+w                # User writable
find /path -user john                # Owned by user
find /path -group developers         # Owned by group
```

### Execute Commands
```bash
find /path -name "*.txt" -delete     # Delete files
find /path -name "*.log" -exec rm {} \;  # Delete with exec
find /path -name "*.txt" -exec cat {} \;  # Cat all files
find /path -type f -exec chmod 644 {} \;  # Change permissions
find /path -name "*.bak" -ok rm {} \;  # Confirm before delete
```

### Advanced Find
```bash
find /path -name "*.txt" -print0 | xargs -0 grep "pattern"  # Grep in found files
find /path -type f -printf "%p - %s bytes\n"  # Custom format
find /path -maxdepth 2 -name "*.txt"  # Limit depth
find /path -mindepth 2 -name "*.txt"  # Minimum depth
find /path -path "*/test/*" -prune -o -name "*.txt" -print  # Exclude directory
```

## Combining Grep and Find

### Search in Found Files
```bash
find /path -name "*.log" -exec grep "error" {} \;
find /path -name "*.txt" | xargs grep "pattern"
find /path -name "*.js" -exec grep -l "TODO" {} \;
```

## Quick Reference

### Grep
| Command | Description |
|---------|-------------|
| `grep "pattern" file` | Search in file |
| `grep -r "pattern" dir` | Recursive search |
| `grep -i "pattern" file` | Case-insensitive |
| `grep -v "pattern" file` | Invert match |
| `grep -n "pattern" file` | Line numbers |
| `grep -c "pattern" file` | Count matches |

### Find
| Command | Description |
|---------|-------------|
| `find /path -name "*.txt"` | Find by name |
| `find /path -type f` | Find files |
| `find /path -size +100M` | Find by size |
| `find /path -mtime -7` | Modified last 7 days |
| `find /path -exec cmd {} \;` | Execute command |
| `find /path -delete` | Delete found files |

## Practical Examples

### Find Large Files
```bash
find / -type f -size +100M -exec ls -lh {} \; 2>/dev/null
```

### Find and Remove Old Logs
```bash
find /var/log -name "*.log" -mtime +30 -delete
```

### Find Files Modified Today
```bash
find /path -type f -mtime 0
```

### Search for Text in All Files
```bash
grep -r "search term" /path
```

### Find Duplicate Files
```bash
find /path -type f -exec md5sum {} \; | sort | uniq -w32 -dD
```

### Find Broken Symlinks
```bash
find /path -type l ! -exec test -e {} \; -print
```

## Tips

1. **Use -print0 with xargs -0** for filenames with spaces
2. **Combine find and grep** for powerful searches
3. **Use -maxdepth** to limit search scope
4. **Test with -print** before using -delete
5. **Use grep -r** for simple recursive searches
6. **Learn regex** for advanced patterns
7. **Use --include/--exclude** with grep
8. **Redirect stderr** with 2>/dev/null
9. **Use -exec vs xargs** appropriately
10. **Bookmark common patterns**

## Resources

- Grep Manual: https://www.gnu.org/software/grep/manual/
- Find Manual: https://www.gnu.org/software/findutils/manual/
- Regex Tutorial: https://www.regular-expressions.info/
- Grep Examples: https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/
