---
layout: cheatsheet
title: PowerShell Command Cheatsheet
description: PowerShell is a cross-platform task automation solution and configuration management framework, consisting of a command-line shell and scripting language.
---


PowerShell is a cross-platform task automation solution and configuration management framework, consisting of a command-line shell and scripting language.


## Basics

### Getting Help
```powershell
Get-Help Command-Name                    # Get help for a command
Get-Help Command-Name -Examples          # Show examples
Get-Help Command-Name -Detailed          # Detailed help
Get-Help Command-Name -Full              # Full help
Get-Help Command-Name -Online            # Open online help
Update-Help                              # Update help files
Get-Command                              # List all commands
Get-Command *process*                    # Search commands
```

### Variables
```powershell
$var = "value"                           # Assign variable
$var                                     # Display variable
${var-name}                              # Variable with special chars
$env:PATH                                # Environment variable
$PSVersionTable                          # PowerShell version
Remove-Variable var                      # Remove variable
Get-Variable                             # List all variables
Set-Variable -Name var -Value "val"      # Set variable
```

### Data Types
```powershell
[string]$str = "text"                    # String
[int]$num = 42                           # Integer
[double]$dec = 3.14                      # Decimal
[bool]$flag = $true                      # Boolean
[array]$arr = @(1,2,3)                   # Array
[hashtable]$hash = @{key="value"}        # Hash table
$var.GetType()                           # Get type
```

## File System

### Navigation
```powershell
Get-Location                             # Current directory (pwd)
Set-Location path                        # Change directory (cd)
Push-Location path                       # Save and change directory
Pop-Location                             # Return to saved directory
Get-ChildItem                            # List items (ls, dir)
Get-ChildItem -Recurse                   # List recursively
Get-ChildItem -Force                     # Include hidden files
```

### File Operations
```powershell
New-Item file.txt -ItemType File         # Create file
New-Item folder -ItemType Directory      # Create directory
Copy-Item source dest                    # Copy file/folder
Move-Item source dest                    # Move file/folder
Remove-Item file                         # Delete file
Remove-Item folder -Recurse              # Delete folder recursively
Rename-Item old new                      # Rename file/folder
Test-Path file                           # Check if exists
```

### File Content
```powershell
Get-Content file.txt                     # Read file
Get-Content file.txt -TotalCount 10      # First 10 lines
Get-Content file.txt -Tail 10            # Last 10 lines
Set-Content file.txt "text"              # Write file (overwrite)
Add-Content file.txt "text"              # Append to file
Clear-Content file.txt                   # Clear file content
Select-String "pattern" file.txt         # Search in file (grep)
```

## Process Management

### Process Commands
```powershell
Get-Process                              # List processes
Get-Process -Name chrome                 # Get specific process
Start-Process notepad                    # Start process
Start-Process cmd -Verb RunAs            # Run as administrator
Stop-Process -Name notepad               # Stop by name
Stop-Process -Id 1234                    # Stop by PID
Stop-Process -Name chrome -Force         # Force stop
Wait-Process -Name notepad               # Wait for process to end
```

### Service Management
```powershell
Get-Service                              # List services
Get-Service -Name wuauserv               # Get specific service
Start-Service servicename                # Start service
Stop-Service servicename                 # Stop service
Restart-Service servicename              # Restart service
Set-Service servicename -StartupType Automatic  # Set startup type
```

## Network Commands

### Network Information
```powershell
Test-Connection hostname                 # Ping host
Test-NetConnection hostname -Port 80     # Test port connectivity
Get-NetIPAddress                         # Get IP addresses
Get-NetAdapter                           # Get network adapters
Get-NetRoute                             # Get routing table
Resolve-DnsName hostname                 # DNS lookup
```

### Web Requests
```powershell
Invoke-WebRequest url                    # HTTP request
Invoke-RestMethod url                    # REST API request
Invoke-WebRequest url -OutFile file      # Download file
(Invoke-WebRequest url).Content          # Get response content
Invoke-WebRequest url -Method POST -Body $data  # POST request
```

### SSH
```powershell
ssh user@host                            # Connect via SSH
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh user@domain.com "cat >>.ssh/authorized_keys" # Copy SSH key
```

## Working with Objects

### Pipeline
```powershell
Get-Process | Where-Object {$_.CPU -gt 100}      # Filter
Get-Process | Select-Object Name, CPU            # Select properties
Get-Process | Sort-Object CPU -Descending        # Sort
Get-Process | Group-Object ProcessName           # Group
Get-Process | Measure-Object                     # Count
Get-Process | Export-Csv processes.csv           # Export to CSV
Import-Csv file.csv                              # Import from CSV
```

### Object Properties
```powershell
$obj | Get-Member                        # List properties/methods
$obj.PropertyName                        # Access property
$obj | Select-Object -First 5            # First 5 items
$obj | Select-Object -Last 5             # Last 5 items
$obj | Select-Object -Unique             # Unique items
$obj | Format-Table                      # Table format
$obj | Format-List                       # List format
```

## Arrays and Collections

### Arrays
```powershell
$arr = @(1, 2, 3)                        # Create array
$arr = 1..10                             # Range
$arr[0]                                  # First element
$arr[-1]                                 # Last element
$arr[0..2]                               # Slice
$arr.Length                              # Array length
$arr += 4                                # Add element
$arr -contains 2                         # Check if contains
```

### Hash Tables
```powershell
$hash = @{Name="John"; Age=30}           # Create hash table
$hash["Name"]                            # Access value
$hash.Name                               # Access value (dot notation)
$hash.Add("City", "NYC")                 # Add key-value
$hash.Remove("Age")                      # Remove key
$hash.Keys                               # Get all keys
$hash.Values                             # Get all values
$hash.ContainsKey("Name")                # Check if key exists
```

## Control Flow

### If Statements
```powershell
if ($condition) {
    # code
} elseif ($condition2) {
    # code
} else {
    # code
}

# One-liner
if ($x -gt 5) { "Greater" } else { "Less" }
```

### Comparison Operators
```powershell
-eq                                      # Equal
-ne                                      # Not equal
-gt                                      # Greater than
-ge                                      # Greater or equal
-lt                                      # Less than
-le                                      # Less or equal
-like                                    # Wildcard match
-notlike                                 # Not wildcard match
-match                                   # Regex match
-notmatch                                # Not regex match
-contains                                # Contains
-in                                      # In array
```

### Loops
```powershell
# ForEach loop
foreach ($item in $collection) {
    # code
}

# For loop
for ($i = 0; $i -lt 10; $i++) {
    # code
}

# While loop
while ($condition) {
    # code
}

# Do-While loop
do {
    # code
} while ($condition)

# ForEach-Object (pipeline)
1..10 | ForEach-Object { $_ * 2 }
```

### Switch Statement
```powershell
switch ($var) {
    1 { "One" }
    2 { "Two" }
    default { "Other" }
}

# With wildcard
switch -Wildcard ($str) {
    "test*" { "Starts with test" }
    "*end" { "Ends with end" }
}
```

## Functions

### Function Definition
```powershell
function Get-Greeting {
    param($Name)
    "Hello, $Name!"
}
Get-Greeting -Name "World"

# Advanced function
function Get-Data {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter()]
        [switch]$Recurse
    )
    # code
}
```

### Script Blocks
```powershell
$block = { param($x) $x * 2 }            # Define script block
& $block 5                               # Execute (returns 10)
Invoke-Command -ScriptBlock $block -ArgumentList 5
```

## Error Handling

### Try-Catch
```powershell
try {
    # code that might fail
    Get-Item "nonexistent.txt" -ErrorAction Stop
} catch {
    Write-Error "Error: $_"
} finally {
    # cleanup code
}

# Catch specific errors
try {
    # code
} catch [System.IO.FileNotFoundException] {
    Write-Error "File not found"
} catch {
    Write-Error "Other error"
}
```

### Error Actions
```powershell
-ErrorAction Stop                        # Throw error
-ErrorAction Continue                    # Show error, continue
-ErrorAction SilentlyContinue            # Hide error, continue
-ErrorAction Inquire                     # Ask user
$ErrorActionPreference = "Stop"          # Set default
```

## String Manipulation

### String Operations
```powershell
"text".ToUpper()                         # Uppercase
"TEXT".ToLower()                         # Lowercase
"  text  ".Trim()                        # Trim whitespace
"hello world".Replace("world", "PS")     # Replace
"a,b,c".Split(",")                       # Split
"a", "b", "c" -join ","                  # Join
"text".Length                            # Length
"hello world".Substring(0, 5)            # Substring
"text" -match "pattern"                  # Regex match
```

### String Formatting
```powershell
"Hello, $name"                           # Variable interpolation
"Result: $(2 + 2)"                       # Expression interpolation
'Literal $var'                           # No interpolation
"Line1`nLine2"                           # Newline
"Tab`tSeparated"                         # Tab
"{0} {1}" -f "Hello", "World"            # Format operator
```

## Regular Expressions

### Regex Matching
```powershell
"text" -match "pattern"                  # Match
$Matches[0]                              # Full match
$Matches[1]                              # First group
"text" -replace "old", "new"             # Replace
Select-String "pattern" file.txt         # Search in file
Select-String "pattern" file.txt -AllMatches  # All matches
```

## Modules

### Module Management
```powershell
Get-Module                               # List loaded modules
Get-Module -ListAvailable                # List available modules
Import-Module ModuleName                 # Import module
Remove-Module ModuleName                 # Remove module
Find-Module ModuleName                   # Search online
Install-Module ModuleName                # Install from gallery
Update-Module ModuleName                 # Update module
```

## Execution Policy

### Policy Management
```powershell
Get-ExecutionPolicy                      # Get current policy
Set-ExecutionPolicy RemoteSigned         # Set policy
Set-ExecutionPolicy Bypass -Scope Process  # Temporary bypass
# Policies: Restricted, AllSigned, RemoteSigned, Unrestricted, Bypass
```

## Useful Cmdlets

### System Information
```powershell
Get-ComputerInfo                         # Computer information
Get-WmiObject Win32_OperatingSystem      # OS information
Get-WmiObject Win32_ComputerSystem       # System information
Get-WmiObject Win32_LogicalDisk          # Disk information
Get-EventLog -LogName System -Newest 10  # Event logs
```

### User Management
```powershell
Get-LocalUser                            # List local users
New-LocalUser -Name "username"           # Create user
Remove-LocalUser -Name "username"        # Remove user
Get-LocalGroup                           # List local groups
Add-LocalGroupMember -Group "Administrators" -Member "user"
```

## Aliases

### Common Aliases
```powershell
ls, dir → Get-ChildItem
cd, chdir → Set-Location
pwd → Get-Location
cat, type → Get-Content
cp, copy → Copy-Item
mv, move → Move-Item
rm, del → Remove-Item
echo, write → Write-Output
cls, clear → Clear-Host
man, help → Get-Help
ps → Get-Process
kill → Stop-Process
```

### Alias Management
```powershell
Get-Alias                                # List all aliases
Get-Alias -Name ls                       # Get specific alias
Set-Alias -Name ll -Value Get-ChildItem  # Create alias
Remove-Alias -Name ll                    # Remove alias
```

## Profile

### Profile Locations
```powershell
$PROFILE                                 # Current user, current host
$PROFILE.AllUsersAllHosts                # All users, all hosts
$PROFILE.CurrentUserAllHosts             # Current user, all hosts
Test-Path $PROFILE                       # Check if exists
New-Item -Path $PROFILE -ItemType File -Force  # Create profile
notepad $PROFILE                         # Edit profile
```

## Best Practices

1. **Use approved verbs** for function names (Get, Set, New, Remove, etc.)
2. **Use CmdletBinding** for advanced functions
3. **Use parameter validation** to ensure correct input
4. **Write-Verbose** for detailed logging
5. **Use -WhatIf** and -Confirm for destructive operations
6. **Comment your code** with `#` or `<# #>`
7. **Use proper error handling** with try-catch
8. **Follow naming conventions** (PascalCase for functions)
9. **Use pipeline** for efficient data processing
10. **Test scripts** before running in production

## Quick Tips

```powershell
# Get command history
Get-History
Invoke-History 5                         # Run command #5

# Measure execution time
Measure-Command { Get-Process }

# Run as administrator
Start-Process powershell -Verb RunAs

# Background jobs
Start-Job -ScriptBlock { Get-Process }
Get-Job
Receive-Job -Id 1

# Transcript (log session)
Start-Transcript -Path log.txt
Stop-Transcript
```

## Resources

- Official Documentation: https://docs.microsoft.com/powershell
- PowerShell Gallery: https://www.powershellgallery.com
- Community: https://reddit.com/r/PowerShell
- Learn PowerShell: https://learn.microsoft.com/powershell
