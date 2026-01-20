---
layout: cheatsheet
title: Linux Server Command Cheatsheet
description: Linux Server administration involves managing and maintaining Linux-based servers to ensure reliability, security, and performance.
---


Linux Server administration involves managing and maintaining Linux-based servers to ensure reliability, security, and performance.


## System Information & Hardware

### General Info
```bash
uname -a               # Kernel & system info
hostnamectl            # Hostname & OS info
uptime                 # Server uptime & load average
dmesg | less           # Kernel ring buffer (boot logs/hardware errors)
lsb_release -a         # Distro version info
```

### CPU & Memory
```bash
lscpu                  # CPU architecture info
cat /proc/cpuinfo      # Detailed CPU info
free -h                # Memory & Swap usage (human readable)
dmidecode -t memory    # Hardware memory info
vmstat 1               # Virtual memory statistics (live)
```

### Disk & Filesystem
```bash
df -hT                 # Disk space usage & types
du -sh *               # Directory sizes in current path
lsblk                  # Block devices (disks/partitions)
blkid                  # UUIDs and filesystems
fdisk -l               # Partition tables
mount | column -t      # Mounted filesystems
tune2fs -l /dev/sda1   # Filesystem parameters (ext4)
```

## Performance Monitoring

### Real-time Monitoring
```bash
top                    # Process viewer (CPU/Mem)
htop                   # Interactive process viewer (Install if needed)
glances                # Advanced alternative to htop
btop                   # Modern resource monitor
```

### Detailed Statistics
```bash
vmstat 1               # System activity (CPU, Mem, IO)
iostat -xz 1           # Disk I/O stats (requires sysstat)
sar -u 1               # CPU utilization history
sar -r 1               # Memory utilization history
dstat                  # Versatile resource statistics
```

## Process Management

### Viewing & Searching
```bash
ps aux                 # List all running processes
ps auxf                # Process tree view
pgrep -a nginx         # Find PIDs by name
lsof -p <PID>          # List files opened by process
strace -p <PID>        # Trace system calls of a process
```

### Control
```bash
kill <PID>             # Terminate process (SIGTERM)
kill -9 <PID>          # Force kill (SIGKILL)
killall nginx          # Kill all processes named nginx
pkill -f "script.py"   # Kill process matching pattern
nice -n 10 command     # Run with lower priority
renice 10 -p <PID>     # Change priority of running process
```

## Networking

### Interfaces & Routing
```bash
ip addr                # Show IP addresses (modern)
ip link                # Show interfaces
ip route show          # Routing table
ifconfig               # Old style (avoid if possible)
ethtool eth0           # Interface statistics/speed
```

### Diagnostics & Connectivity
```bash
ping -c 4 1.1.1.1      # Test connectivity
mtr 1.1.1.1            # Ping + Traceroute combined
traceroute google.com  # Path to destination
nslookup domain.com    # DNS lookup
dig +short domain.com  # Concise DNS answer
curl -I https://api.com # Fetch headers only
wget -O output url     # Download file
```

### Ports & Sockets
```bash
ss -tulpn              # List listening ports (modern)
netstat -tulpn         # List listening ports (legacy)
lsof -i :80            # Who is using port 80?
nc -zv 1.2.3.4 22      # Test remote port connectivity (Netcat)
tcpdump -i eth0 port 80 # Capture traffic on port 80
```

## Security & Firewall

### User & Permissions
```bash
who                    # Who is logged in
w                      # What are they doing
last                   # Login history
sudo -i                # Switch to root
chage -l username      # Password expiry info
usermod -aG sudo user  # Add user to sudo group
```

### Firewall (UFW - Ubuntu/Debian)
```bash
ufw status verbose     # Check status
ufw allow 22/tcp       # Allow SSH
ufw allow 80,443/tcp   # Allow Web
ufw deny 23            # Deny Telnet
ufw enable             # Enable firewall
```

### Firewall (Firewalld - CentOS/RHEL)
```bash
firewall-cmd --list-all             # List rules
firewall-cmd --add-port=80/tcp      # Open port (runtime)
firewall-cmd --permanent --add-port=80/tcp # Open port (permanent)
firewall-cmd --reload               # Reload rules
```

### SSH Management
```bash
ssh-keygen -t ed25519  # Generate secure SSH key
ssh-copy-id user@host  # Copy public key to server
vi /etc/ssh/sshd_config # SSH Server config
# Important SSH config settings:
# PermitRootLogin no
# PasswordAuthentication no
```

## Logs & journals

### Journalctl (Systemd)
```bash
journalctl -f          # Follow logs (tail)
journalctl -u nginx    # Show logs for specific service
journalctl --since "1 hour ago" # Logs from last hour
journalctl -p err      # Show only errors
journalctl --disk-usage # Check log size
```

### Log Files (Common Locations)
```bash
/var/log/syslog        # General system logs (Debian)
/var/log/messages      # General system logs (RHEL)
/var/log/auth.log      # Authentication logs
/var/log/secure        # Auth logs (RHEL)
/var/log/dmesg         # Boot logs
/var/log/nginx/        # Web server logs
```

## File Management & Transfer

### Transfer
```bash
scp file user@host:/path            # Secure Copy
rsync -avz local/ user@host:/path/  # Sync directory (efficient)
rsync -avz --delete local/ remote/  # Sync exact mirror
python3 -m http.server 8000         # Quick HTTP server for sharing
```

### Search & Manipulation
```bash
find / -name "*.conf"               # Find files
find /var -size +100M               # Find large files
grep -r "error" /var/log/           # Recursive search text
sed -i 's/foo/bar/g' file           # Replace text in file
tar -czvf archive.tar.gz folder/    # Create tar.gz
tar -xvf archive.tar.gz             # Extract tar.gz
```

## System Services (Systemd)

```bash
systemctl list-units --type=service # List running services
systemctl start <service>           # Start
systemctl stop <service>            # Stop
systemctl restart <service>         # Restart
systemctl reload <service>          # Reload config without restart
systemctl enable <service>          # Enable at boot
systemctl disable <service>         # Disable at boot
systemctl is-active <service>       # Check if running
```

## Cron Jobs (Scheduling)

```bash
crontab -l                 # List user cron jobs
crontab -e                 # Edit user cron jobs
# Format: * * * * * command_to_execute
# Minute (0-59) Hour (0-23) Day(1-31) Month(1-12) Weekday(0-7)

# Examples:
# 0 2 * * * /backup.sh    # Run daily at 2AM
# */15 * * * * /check.sh  # Run every 15 minutes
```

## Package Management

### APT (Debian/Ubuntu)
```bash
apt update && apt upgrade -y   # Update system
apt install <pkg>              # Install package
apt remove <pkg>               # Remove package
apt autoremove                 # Clean unused deps
apt search <keyword>           # Search
dpkg -i file.deb               # Install local .deb
```

### DNF/YUM (RHEL/CentOS)
```bash
dnf update -y                  # Update system
dnf install <pkg>              # Install package
dnf remove <pkg>               # Remove package
dnf history                    # Transaction history
rpm -qa | grep <pkg>           # Check installed options
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `top` | View CPU/Mem usage |
| `df -h` | View disk space |
| `free -h` | View RAM usage |
| `journalctl -xe` | View system errors |
| `netstat -tulpn` | View open ports |
| `chmod +x script` | Make executable |
| `chown user:group` | Change ownership |
| `tar -czf` | Compress archive |
