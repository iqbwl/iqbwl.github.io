---
layout: cheatsheet
title: IPTables Firewall Cheatsheet
description: iptables is a user-space utility program that allows a system administrator to configure the IP packet filter rules of the Linux kernel firewall.
---


iptables is a user-space utility program that allows a system administrator to configure the IP packet filter rules of the Linux kernel firewall.


## Basic Commands

### List Rules
```bash
iptables -L                          # List all rules
iptables -L -v                       # Verbose
iptables -L -n                       # Numeric (no DNS)
iptables -L -n --line-numbers        # With line numbers
iptables -L INPUT                    # Specific chain
iptables -t nat -L                   # NAT table
```

### Flush Rules
```bash
iptables -F                          # Flush all rules
iptables -F INPUT                    # Flush INPUT chain
iptables -X                          # Delete custom chains
iptables -t nat -F                   # Flush NAT table
```

### Default Policies
```bash
iptables -P INPUT DROP               # Drop all incoming
iptables -P FORWARD DROP             # Drop all forwarding
iptables -P OUTPUT ACCEPT            # Accept all outgoing
```

## Add Rules

### Allow Traffic
```bash
# Allow specific port
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow from specific IP
iptables -A INPUT -s 192.168.1.100 -j ACCEPT

# Allow from subnet
iptables -A INPUT -s 192.168.1.0/24 -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT
```

### Block Traffic
```bash
# Block specific IP
iptables -A INPUT -s 192.168.1.100 -j DROP

# Block specific port
iptables -A INPUT -p tcp --dport 23 -j DROP

# Block ping
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
```

### Delete Rules
```bash
# Delete by line number
iptables -D INPUT 3

# Delete specific rule
iptables -D INPUT -p tcp --dport 80 -j ACCEPT
```

### Insert Rules
```bash
# Insert at specific position
iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT
```

## Common Rules

### SSH Access
```bash
# Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow SSH from specific IP
iptables -A INPUT -p tcp -s 192.168.1.100 --dport 22 -j ACCEPT

# Limit SSH connections
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
```

### Web Server
```bash
# Allow HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow from specific IP
iptables -A INPUT -p tcp -s 192.168.1.0/24 --dport 80 -j ACCEPT
```

### DNS
```bash
# Allow DNS queries
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
```

### FTP
```bash
# Allow FTP
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp --dport 20 -j ACCEPT
```

## Port Ranges
```bash
# Allow port range
iptables -A INPUT -p tcp --dport 1000:2000 -j ACCEPT
```

## NAT (Network Address Translation)

### Port Forwarding
```bash
# Forward port 80 to 8080
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

# Forward to different IP
iptables -t nat -A PREROUTING -p tcp -d 192.168.1.1 --dport 80 -j DNAT --to-destination 192.168.1.100:8080
```

### Masquerading (NAT)
```bash
# Enable masquerading
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
```

## Logging

### Log Dropped Packets
```bash
# Log before drop
iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: "
iptables -A INPUT -j DROP

# Log with limit
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "IPTables-Dropped: "
```

## Rate Limiting

### Limit Connections
```bash
# Limit new connections
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

# Limit by IP
iptables -A INPUT -p tcp --dport 80 -m connlimit --connlimit-above 20 -j REJECT
```

## Save and Restore

### Save Rules
```bash
# Debian/Ubuntu
iptables-save > /etc/iptables/rules.v4

# CentOS/RHEL
service iptables save
```

### Restore Rules
```bash
# Debian/Ubuntu
iptables-restore < /etc/iptables/rules.v4

# CentOS/RHEL
service iptables restart
```

### Make Persistent
```bash
# Debian/Ubuntu
apt-get install iptables-persistent
netfilter-persistent save

# CentOS/RHEL
chkconfig iptables on
```

## Complete Firewall Script

### Basic Firewall
```bash
#!/bin/bash

# Flush existing rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow ping
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Log dropped packets
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "IPTables-Dropped: "

# Save rules
iptables-save > /etc/iptables/rules.v4
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `iptables -L` | List rules |
| `iptables -F` | Flush rules |
| `iptables -A INPUT -j ACCEPT` | Allow input |
| `iptables -A INPUT -j DROP` | Drop input |
| `iptables -D INPUT 1` | Delete rule |
| `iptables -P INPUT DROP` | Default policy |
| `iptables-save` | Save rules |
| `iptables-restore` | Restore rules |

## Best Practices

1. **Test before deploying** to production
2. **Always allow SSH** before setting DROP policy
3. **Allow established connections**
4. **Use specific rules** instead of broad ones
5. **Log suspicious activity**
6. **Save rules** for persistence
7. **Use rate limiting** to prevent DoS
8. **Document your rules**
9. **Regular review** of rules
10. **Use firewalld or ufw** for easier management

## Resources

- IPTables Tutorial: https://www.netfilter.org/documentation/
- IPTables How-To: https://help.ubuntu.com/community/IptablesHowTo
- Firewall Guide: https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands
