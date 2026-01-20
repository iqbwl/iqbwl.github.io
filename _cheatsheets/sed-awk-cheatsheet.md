---
layout: cheatsheet
title: Sed & Awk Command Cheatsheet
description: sed and awk are powerful text processing utilities in the Unix/Linux environment.
---


sed and awk are powerful text processing utilities in the Unix/Linux environment.


## Sed Basics

### Substitution
```bash
sed 's/old/new/' file               # Replace first occurrence
sed 's/old/new/g' file              # Replace all occurrences
sed 's/old/new/2' file              # Replace 2nd occurrence
sed 's/old/new/gi' file             # Case-insensitive replace
sed '1,10s/old/new/g' file          # Replace in lines 1-10
sed '/pattern/s/old/new/g' file     # Replace in matching lines
```

### Delete Lines
```bash
sed '5d' file                       # Delete line 5
sed '1,5d' file                     # Delete lines 1-5
sed '/pattern/d' file               # Delete matching lines
sed '/^$/d' file                    # Delete empty lines
sed '/^#/d' file                    # Delete comments
```

### Print Lines
```bash
sed -n '5p' file                    # Print line 5
sed -n '1,5p' file                  # Print lines 1-5
sed -n '/pattern/p' file            # Print matching lines
sed -n '/start/,/end/p' file        # Print between patterns
```

### Insert/Append
```bash
sed '5i\New line' file              # Insert before line 5
sed '5a\New line' file              # Append after line 5
sed '/pattern/i\New line' file      # Insert before match
sed '/pattern/a\New line' file      # Append after match
```

### In-place Editing
```bash
sed -i 's/old/new/g' file           # Edit file in-place
sed -i.bak 's/old/new/g' file       # Create backup
```

### Multiple Commands
```bash
sed -e 's/old/new/g' -e 's/foo/bar/g' file
sed 's/old/new/g; s/foo/bar/g' file
```

## Awk Basics

### Print Columns
```bash
awk '{print $1}' file               # Print first column
awk '{print $1, $3}' file           # Print columns 1 and 3
awk '{print $NF}' file              # Print last column
awk '{print $0}' file               # Print entire line
```

### Field Separator
```bash
awk -F: '{print $1}' file           # Use : as separator
awk -F',' '{print $1}' file         # Use , as separator
awk 'BEGIN{FS=":"} {print $1}' file # Set separator in BEGIN
```

### Pattern Matching
```bash
awk '/pattern/' file                # Print matching lines
awk '!/pattern/' file               # Print non-matching lines
awk '/start/,/end/' file            # Print between patterns
awk '$3 > 100' file                 # Print if column 3 > 100
awk '$1 == "value"' file            # Print if column 1 equals value
```

### Built-in Variables
```bash
awk '{print NR, $0}' file           # NR = line number
awk '{print NF, $0}' file           # NF = number of fields
awk 'END {print NR}' file           # Print total lines
awk '{sum+=$1} END {print sum}' file # Sum column 1
```

### Conditions
```bash
awk '$3 > 100 {print $1}' file      # If column 3 > 100
awk '$1 == "value" {print $2}' file # If column 1 equals
awk 'NR > 1' file                   # Skip first line
awk 'NR % 2 == 0' file              # Print even lines
```

### BEGIN and END
```bash
awk 'BEGIN {print "Start"} {print} END {print "End"}' file
awk 'BEGIN {sum=0} {sum+=$1} END {print sum}' file
```

## Sed Examples

### Replace in Specific Lines
```bash
sed '10s/old/new/' file             # Line 10 only
sed '10,20s/old/new/g' file         # Lines 10-20
sed '10,$s/old/new/g' file          # Line 10 to end
```

### Multiple Substitutions
```bash
sed 's/old/new/g; s/foo/bar/g' file
sed -e 's/old/new/g' -e 's/foo/bar/g' file
```

### Remove Leading/Trailing Spaces
```bash
sed 's/^[ \t]*//' file              # Remove leading
sed 's/[ \t]*$//' file              # Remove trailing
sed 's/^[ \t]*//; s/[ \t]*$//' file # Both
```

### Add Line Numbers
```bash
sed = file | sed 'N; s/\n/\t/'
```

### Double Space File
```bash
sed G file
```

### Remove Blank Lines
```bash
sed '/^$/d' file
sed '/^[[:space:]]*$/d' file        # Including whitespace
```

## Awk Examples

### Sum Column
```bash
awk '{sum+=$1} END {print sum}' file
```

### Average
```bash
awk '{sum+=$1; count++} END {print sum/count}' file
```

### Print Specific Lines
```bash
awk 'NR==5' file                    # Line 5
awk 'NR>=5 && NR<=10' file          # Lines 5-10
```

### Count Lines
```bash
awk 'END {print NR}' file
```

### Print Unique Lines
```bash
awk '!seen[$0]++' file
```

### CSV Processing
```bash
awk -F',' '{print $1, $3}' file.csv
awk -F',' 'NR>1 {print $1}' file.csv  # Skip header
```

### Format Output
```bash
awk '{printf "%-10s %s\n", $1, $2}' file
awk '{printf "%s,%s,%s\n", $1, $2, $3}' file
```

## Combined Examples

### Replace and Save
```bash
sed 's/old/new/g' input.txt > output.txt
```

### Process Log Files
```bash
awk '/ERROR/ {print $1, $2, $NF}' log.txt
sed -n '/ERROR/p' log.txt
```

### Extract Email Addresses
```bash
sed -n 's/.*\([a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}\).*/\1/p' file
```

### Convert CSV to TSV
```bash
sed 's/,/\t/g' file.csv
```

### Remove HTML Tags
```bash
sed 's/<[^>]*>//g' file.html
```

## Quick Reference

### Sed
| Command | Description |
|---------|-------------|
| `s/old/new/` | Substitute |
| `d` | Delete |
| `p` | Print |
| `i\text` | Insert |
| `a\text` | Append |
| `-n` | Suppress output |
| `-i` | In-place edit |

### Awk
| Variable | Description |
|----------|-------------|
| `$0` | Entire line |
| `$1, $2, ...` | Fields |
| `NR` | Line number |
| `NF` | Number of fields |
| `FS` | Field separator |
| `OFS` | Output field separator |

## Best Practices

1. **Test before in-place** editing
2. **Use -n with sed** for selective printing
3. **Quote patterns** to avoid shell expansion
4. **Use BEGIN/END** in awk for initialization
5. **Combine with pipes** for complex processing
6. **Use -F for awk** field separator
7. **Create backups** with sed -i.bak
8. **Learn regex** for powerful patterns
9. **Use awk for columns**, sed for lines
10. **Test on sample data** first

## Resources

- Sed Manual: https://www.gnu.org/software/sed/manual/
- Awk Manual: https://www.gnu.org/software/gawk/manual/
- Sed Tutorial: https://www.grymoire.com/Unix/Sed.html
- Awk Tutorial: https://www.grymoire.com/Unix/Awk.html
