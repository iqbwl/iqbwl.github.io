---
layout: cheatsheet
title: Windows CMD Cheatsheet
description: Essential commands for Windows Command Prompt administration and scripting
---


A quick reference for the Windows Command Prompt (cmd.exe).

## File & Directory Management

### Navigation
```cmd
dir                :: List files and directories
dir /a:h           :: List hidden files
cd \path\to\dir    :: Change directory
cd ..              :: Go up one level
cd /d D:           :: Change drive and directory
f:                 :: Switch to F: drive
tree               :: Graphically display directory structure
```

### File Operations
```cmd
copy file.txt new.txt      :: Copy file
xcopy /s /e source dest    :: Copy directory tree (robust)
robocopy source dest /mir  :: Robust File Copy (Mirror) - Best for backups
move file.txt folder\      :: Move file
ren old.txt new.txt        :: Rename file
del file.txt               :: Delete file
del /q *                   :: Delete all files quietly
type file.txt              :: Display file content
attrib +h file.txt         :: Make file hidden
```

### Directory Operations
```cmd
md foldername              :: Make directory (mkdir)
rd foldername              :: Remove directory (rmdir)
rd /s /q foldername        :: Remove directory tree quietly
```

---

## System Information & Management

### System Info
```cmd
systeminfo                 :: Detailed system configuration
hostname                   :: View hostname
ver                        :: Windows version
whoami                     :: Current user
wmic cpu get name          :: Get CPU info
wmic memorychip get capacity :: Get RAM size
driverquery                :: List installed drivers
```

### Process Management
```cmd
tasklist                   :: List running processes
tasklist /svc              :: List services for each process
taskkill /im notepad.exe   :: Kill process by name
taskkill /pid 1234 /f      :: Force kill process by PID
```

### Power & Shutdown
```cmd
shutdown /s /t 0           :: Shutdown immediately
shutdown /r /t 0           :: Restart immediately
shutdown /a                :: Abort shutdown
logoff                     :: Log off current user
```

---

## Networking

```cmd
ipconfig                   :: Show IP configuration
ipconfig /all              :: detailed IP info (MAC address, DNS)
ipconfig /flushdns         :: Clear DNS cache
ipconfig /release          :: Release IP address
ipconfig /renew            :: Renew IP address

ping google.com            :: Test connectivity
ping -t google.com         :: Ping continuously until stopped (Ctrl+C)
tracert google.com         :: Trace route to host
pathping google.com        :: Trace route with statistics

netstat -an                :: List all open ports and connections
netstat -b                 :: Show executable involved in connection (Admin)
nslookup google.com        :: DNS lookup
arp -a                     :: Show ARP table
getmac                     :: Show MAC address
```

---

## Disk Management

```cmd
chkdsk C: /f               :: Check and fix disk errors (Schedule on reboot)
format D: /fs:ntfs /q      :: Quick format drive D as NTFS
label C: System            :: Label disk volume
vol                        :: Show disk volume label and serial
diskpart                   :: Interactive disk partition tool
```

### Common Diskpart Commands
(Type `diskpart` first to enter interactive mode)
```cmd
list disk      :: List physical disks
select disk 0  :: Select a disk
list part      :: List partitions
clean          :: Wipe disk (Careful!)
create partition primary :: Create partition
format fs=ntfs quick     :: Format partition
assign letter=X          :: Assign drive letter
```

---

## User & Group Management

Requires Administrator privileges.

```cmd
net user                   :: List users
net user jdoe              :: View user info
net user jdoe /add         :: Add new user
net user jdoe password123  :: Change password
net user jdoe /delete      :: Delete user
net user jdoe /active:yes  :: Enable account

net localgroup             :: List groups
net localgroup administrators jdoe /add :: Add user to admin group
```

---

## Batch Scripting Basics

Common logic used in `.bat` or `.cmd` scripts.

```cmd
:: This is a comment
@echo off                  :: Hide command echoing

echo Hello World           :: Print text
pause                      :: Wait for user input

set VAR=value              :: Set variable
echo %VAR%                 :: Use variable

if exist file.txt (
    echo File exists
) else (
    echo File missing
)

for %%f in (*.txt) do echo Found %%f  :: Loop through files
```

### Environment Variables
```cmd
set                        :: List all variables
echo %PATH%                :: View PATH
echo %USERNAME%            :: View current user
echo %date% %time%         :: View date and time
```
