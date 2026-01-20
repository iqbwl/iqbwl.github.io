---
layout: cheatsheet
title: Fail2ban Cheatsheet
description: Fail2ban is an intrusion prevention software framework that protects computer servers from brute-force attacks by banning IP addresses that show the malicious signs.
---

Fail2ban is an intrusion prevention software framework that protects computer servers from brute-force attacks by banning IP addresses that show the malicious signs.

## Installation

### Debian/Ubuntu
```bash
# Update package list
sudo apt update

# Install fail2ban
sudo apt install fail2ban -y

# Start and enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Check status
sudo systemctl status fail2ban
```

### RHEL/CentOS/Rocky Linux/AlmaLinux
```bash
# Install EPEL repository (required for fail2ban)
sudo dnf install epel-release -y

# Install fail2ban
sudo dnf install fail2ban fail2ban-systemd -y

# Start and enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Check status
sudo systemctl status fail2ban
```

## Basic Configuration

### Configuration Files
```bash
# Main configuration file
/etc/fail2ban/fail2ban.conf

# Jail configuration (don't edit directly)
/etc/fail2ban/jail.conf

# Local jail configuration (create this)
/etc/fail2ban/jail.local

# Custom jail configurations
/etc/fail2ban/jail.d/

# Filter definitions
/etc/fail2ban/filter.d/

# Action definitions
/etc/fail2ban/action.d/
```

### Create Local Configuration
```bash
# Copy default jail.conf to jail.local
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Or create a minimal jail.local
sudo nano /etc/fail2ban/jail.local
```

### Basic jail.local Configuration
```ini
[DEFAULT]
# Ban IP for 1 hour (3600 seconds)
bantime = 3600

# Time window to count failures (10 minutes)
findtime = 600

# Number of failures before ban
maxretry = 5

# Email settings (optional)
destemail = your-email@example.com
sendername = Fail2Ban
mta = sendmail

[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log  # Debian/Ubuntu
# logpath = /var/log/secure   # RHEL/CentOS
maxretry = 3
bantime = 3600
```

## Fail2ban Service Management

### Service Control
```bash
# Start fail2ban
sudo systemctl start fail2ban

# Stop fail2ban
sudo systemctl stop fail2ban

# Restart fail2ban
sudo systemctl restart fail2ban

# Reload configuration without restarting
sudo systemctl reload fail2ban

# Enable at boot
sudo systemctl enable fail2ban

# Disable at boot
sudo systemctl disable fail2ban

# Check status
sudo systemctl status fail2ban
```

## Fail2ban Client Commands

### Status and Information
```bash
# Show fail2ban status
sudo fail2ban-client status

# Show status of specific jail
sudo fail2ban-client status sshd

# Show all jails
sudo fail2ban-client status

# Get jail configuration
sudo fail2ban-client get sshd bantime
sudo fail2ban-client get sshd maxretry
sudo fail2ban-client get sshd findtime

# Ping fail2ban server
sudo fail2ban-client ping
```

### Jail Management
```bash
# Start a jail
sudo fail2ban-client start sshd

# Stop a jail
sudo fail2ban-client stop sshd

# Reload a jail
sudo fail2ban-client reload sshd

# Reload all jails
sudo fail2ban-client reload

# Add a jail
sudo fail2ban-client add sshd

# Remove a jail
sudo fail2ban-client remove sshd
```

### Ban Management
```bash
# Ban an IP manually
sudo fail2ban-client set sshd banip 192.168.1.100

# Unban an IP
sudo fail2ban-client set sshd unbanip 192.168.1.100

# Unban all IPs from a jail
sudo fail2ban-client unban --all

# Get list of banned IPs
sudo fail2ban-client status sshd
```

## Common Jails Configuration

### SSH Protection
```ini
[sshd]
enabled = true
port = ssh,22
filter = sshd
logpath = /var/log/auth.log  # Debian/Ubuntu
# logpath = /var/log/secure   # RHEL/CentOS
maxretry = 3
bantime = 3600
findtime = 600
```

### Apache/Nginx Protection
```ini
[apache-auth]
enabled = true
port = http,https
filter = apache-auth
logpath = /var/log/apache2/error.log  # Debian/Ubuntu
# logpath = /var/log/httpd/error_log   # RHEL/CentOS
maxretry = 5

[nginx-http-auth]
enabled = true
port = http,https
filter = nginx-http-auth
logpath = /var/log/nginx/error.log
maxretry = 5

[nginx-noscript]
enabled = true
port = http,https
filter = nginx-noscript
logpath = /var/log/nginx/access.log
maxretry = 6

[nginx-badbots]
enabled = true
port = http,https
filter = nginx-badbots
logpath = /var/log/nginx/access.log
maxretry = 2
```

### MySQL/MariaDB Protection
```ini
[mysqld-auth]
enabled = true
port = 3306
filter = mysqld-auth
logpath = /var/log/mysql/error.log  # Debian/Ubuntu
# logpath = /var/log/mariadb/mariadb.log  # RHEL/CentOS
maxretry = 5
```

### Postfix Protection
```ini
[postfix]
enabled = true
port = smtp,465,submission
filter = postfix
logpath = /var/log/mail.log
maxretry = 5
```

### WordPress Protection
```ini
[wordpress-hard]
enabled = true
port = http,https
filter = wordpress-hard
logpath = /var/log/apache2/access.log
maxretry = 3
bantime = 86400
```

## Log Files

### View Fail2ban Logs
```bash
# Main log file
sudo tail -f /var/log/fail2ban.log

# Show recent bans
sudo grep "Ban" /var/log/fail2ban.log | tail -20

# Show recent unbans
sudo grep "Unban" /var/log/fail2ban.log | tail -20

# Show bans for specific jail
sudo grep "sshd.*Ban" /var/log/fail2ban.log

# Show all actions for an IP
sudo grep "192.168.1.100" /var/log/fail2ban.log

# Watch live ban actions
sudo tail -f /var/log/fail2ban.log | grep "Ban"
```

## Testing and Debugging

### Test Configuration
```bash
# Test fail2ban configuration
sudo fail2ban-client -v start

# Test specific jail configuration
sudo fail2ban-client -v start sshd

# Test regex filter
sudo fail2ban-regex /var/log/auth.log /etc/fail2ban/filter.d/sshd.conf

# Verbose mode
sudo fail2ban-client -v status sshd
```

### Debug Mode
```bash
# Stop fail2ban
sudo systemctl stop fail2ban

# Run in foreground with debug
sudo fail2ban-client -x -v start

# Or with more verbosity
sudo fail2ban-client -xv -v -v start
```

## Custom Filters

### Create Custom Filter
```bash
# Create filter file
sudo nano /etc/fail2ban/filter.d/myapp.conf
```

```ini
# myapp.conf example
[Definition]
failregex = ^.* Failed login attempt from <HOST>.*$
            ^.* Authentication failure for .* from <HOST>.*$
ignoreregex =
```

### Test Custom Filter
```bash
# Test the filter against log file
sudo fail2ban-regex /var/log/myapp.log /etc/fail2ban/filter.d/myapp.conf

# Test with verbose output
sudo fail2ban-regex -v /var/log/myapp.log /etc/fail2ban/filter.d/myapp.conf
```

## Advanced Configuration

### Whitelist IPs
```ini
[DEFAULT]
# Ignore specific IPs/networks
ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24 10.0.0.0/8
```

### Custom Actions
```bash
# Create custom action
sudo nano /etc/fail2ban/action.d/myaction.conf
```

```ini
[Definition]
actionstart =
actionstop =
actioncheck =
actionban = iptables -I INPUT -s <ip> -j DROP
actionunban = iptables -D INPUT -s <ip> -j DROP
```

### Email Notifications
```ini
[DEFAULT]
# Email configuration
destemail = admin@example.com
sendername = Fail2Ban
mta = sendmail
action = %(action_mwl)s

# Available actions:
# action_     - ban only
# action_mw   - ban and send email with whois
# action_mwl  - ban and send email with whois and logs
```

## Performance and Optimization

### Optimize Database
```bash
# Fail2ban database location
/var/lib/fail2ban/fail2ban.sqlite3

# Check database size
sudo du -h /var/lib/fail2ban/fail2ban.sqlite3

# Clear old entries (stop fail2ban first)
sudo systemctl stop fail2ban
sudo rm -f /var/lib/fail2ban/fail2ban.sqlite3
sudo systemctl start fail2ban
```

### Monitor Resources
```bash
# Check fail2ban process
ps aux | grep fail2ban

# Monitor CPU and memory
top -p $(pgrep -d',' fail2ban)
```

## Useful Tips

### Permanent Bans
```ini
[sshd]
# Ban permanently (10 years)
bantime = 315360000
```

### Incremental Ban Time
```ini
[sshd]
# Increase ban time for repeat offenders
bantime.increment = true
bantime.factor = 1
bantime.formula = ban.Time * (1<<(ban.Count if ban.Count<20 else 20)) * banFactor
bantime.maxtime = 5w
```

### Check Banned IPs with iptables
```bash
# Show all fail2ban iptables rules
sudo iptables -L -n | grep fail2ban

# Show specific chain
sudo iptables -L f2b-sshd -n -v

# For IPv6
sudo ip6tables -L -n | grep fail2ban
```

## Troubleshooting

### Common Issues
```bash
# Fail2ban not starting
sudo systemctl status fail2ban
sudo journalctl -xeu fail2ban

# Check configuration syntax
sudo fail2ban-client -t

# Check if jail is running
sudo fail2ban-client status sshd

# Verify log file exists and is readable
sudo ls -la /var/log/auth.log

# Check SELinux (RHEL/CentOS)
sudo ausearch -m avc -ts recent | grep fail2ban
sudo setsebool -P allow_ftpd_full_access on

# Reset fail2ban
sudo systemctl stop fail2ban
sudo rm -rf /var/lib/fail2ban/*
sudo systemctl start fail2ban
```

### Log Location Issues
```bash
# Debian/Ubuntu SSH logs
/var/log/auth.log

# RHEL/CentOS SSH logs
/var/log/secure

# If using systemd journal
logpath = /var/log/journal
backend = systemd
```
