---
layout: cheatsheet
title: Linux Command Cheatsheet
description: Essential Linux commands for daily use
---

# Linux Command Cheatsheet

A comprehensive reference for commonly used Linux commands.

## File Operations

### Navigation
```bash
pwd                    # Print working directory
ls                     # List files
ls -la                 # List all files with details
cd /path/to/dir        # Change directory
cd ..                  # Go up one directory
cd ~                   # Go to home directory
cd -                   # Go to previous directory
```

### File Management
```bash
touch file.txt         # Create empty file
mkdir dirname          # Create directory
mkdir -p path/to/dir   # Create nested directories
cp file.txt copy.txt   # Copy file
cp -r dir1 dir2        # Copy directory recursively
mv old.txt new.txt     # Rename/move file
rm file.txt            # Remove file
rm -rf dirname         # Remove directory recursively (use with caution!)
```

### File Viewing
```bash
cat file.txt           # Display file contents
less file.txt          # View file with pagination
head file.txt          # Show first 10 lines
head -n 20 file.txt    # Show first 20 lines
tail file.txt          # Show last 10 lines
tail -f file.txt       # Follow file updates (logs)
```

### File Search
```bash
find /path -name "*.txt"              # Find files by name
find /path -type f -mtime -7          # Find files modified in last 7 days
grep "pattern" file.txt               # Search text in file
grep -r "pattern" /path               # Recursive search
grep -i "pattern" file.txt            # Case-insensitive search
locate filename                       # Quick file search (uses database)
```

## System Information

### System Status
```bash
uname -a               # System information
hostname               # Show hostname
uptime                 # System uptime
date                   # Current date and time
cal                    # Calendar
whoami                 # Current user
w                      # Who is logged in
```

### Hardware Info
```bash
lscpu                  # CPU information
free -h                # Memory usage
df -h                  # Disk space usage
du -sh /path           # Directory size
lsblk                  # List block devices
lsusb                  # List USB devices
lspci                  # List PCI devices
```

## Process Management

### Process Viewing
```bash
ps aux                 # List all processes
ps aux | grep nginx    # Find specific process
top                    # Interactive process viewer
htop                   # Better interactive viewer (if installed)
pgrep nginx            # Find process ID by name
```

### Process Control
```bash
kill PID               # Terminate process
kill -9 PID            # Force kill process
killall processname    # Kill all processes by name
pkill processname      # Kill processes by name pattern
bg                     # Send to background
fg                     # Bring to foreground
nohup command &        # Run command immune to hangups
```

## Network Commands

### Network Info
```bash
ip addr                # Show IP addresses
ip link                # Show network interfaces
ifconfig               # Network configuration (older)
hostname -I            # Show all IP addresses
```

### Connectivity
```bash
ping google.com        # Test connectivity
ping -c 4 google.com   # Ping 4 times
traceroute google.com  # Trace route to host
curl https://api.com   # Make HTTP request
wget https://file.com  # Download file
```

### Network Services
```bash
netstat -tuln          # Show listening ports
ss -tuln               # Socket statistics (modern)
lsof -i :80            # Show what's using port 80
nslookup domain.com    # DNS lookup
dig domain.com         # DNS query tool
```

## User Management

### User Operations
```bash
sudo command           # Run as superuser
su - username          # Switch user
useradd username       # Add user
userdel username       # Delete user
passwd username        # Change password
groups username        # Show user groups
id username            # Show user ID and groups
```

### Permissions
```bash
chmod 755 file         # Change file permissions
chmod +x script.sh     # Make file executable
chown user:group file  # Change file owner
chgrp group file       # Change file group
umask                  # Show default permissions
```

## Package Management

### Debian/Ubuntu (APT)
```bash
sudo apt update                    # Update package list
sudo apt upgrade                   # Upgrade packages
sudo apt install package           # Install package
sudo apt remove package            # Remove package
sudo apt autoremove                # Remove unused packages
sudo apt search keyword            # Search packages
```

### RedHat/CentOS (YUM/DNF)
```bash
sudo yum update                    # Update packages
sudo yum install package           # Install package
sudo yum remove package            # Remove package
sudo dnf install package           # DNF (newer)
```

## Text Processing

### Text Manipulation
```bash
cat file1 file2 > combined         # Combine files
sort file.txt                      # Sort lines
uniq file.txt                      # Remove duplicates
wc -l file.txt                     # Count lines
cut -d',' -f1 file.csv            # Cut columns
sed 's/old/new/g' file.txt        # Replace text
awk '{print $1}' file.txt         # Print first column
```

### Compression
```bash
tar -czf archive.tar.gz dir/       # Create compressed archive
tar -xzf archive.tar.gz            # Extract archive
zip -r archive.zip dir/            # Create zip
unzip archive.zip                  # Extract zip
gzip file.txt                      # Compress file
gunzip file.txt.gz                 # Decompress file
```

## System Services

### Systemd
```bash
systemctl start service            # Start service
systemctl stop service             # Stop service
systemctl restart service          # Restart service
systemctl status service           # Check service status
systemctl enable service           # Enable on boot
systemctl disable service          # Disable on boot
journalctl -u service              # View service logs
```

## Disk Management

### Disk Operations
```bash
fdisk -l               # List partitions
mount /dev/sdb1 /mnt   # Mount partition
umount /mnt            # Unmount
mkfs.ext4 /dev/sdb1    # Format partition
fsck /dev/sdb1         # Check filesystem
```

## Useful Shortcuts

### Command Line
```bash
Ctrl + C               # Cancel current command
Ctrl + Z               # Suspend current command
Ctrl + D               # Exit/logout
Ctrl + L               # Clear screen
Ctrl + A               # Move to line start
Ctrl + E               # Move to line end
Ctrl + R               # Search command history
!!                     # Repeat last command
!$                     # Last argument of previous command
```

## Tips

- Use `man command` to read manual pages for any command
- Use `command --help` for quick help
- Use Tab for auto-completion
- Use `history` to see command history
- Use `alias` to create command shortcuts
