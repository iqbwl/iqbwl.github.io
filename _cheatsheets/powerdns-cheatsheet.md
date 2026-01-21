---
layout: cheatsheet
title: PowerDNS Cheatsheet
description: PowerDNS is a high-performance authoritative-only name server.
---

PowerDNS is a high-performance authoritative-only name server.

## Service Management

### SystemD (Ubuntu/Debian/CentOS/RHEL)
```bash
sudo systemctl start pdns         # Start service
sudo systemctl stop pdns          # Stop service
sudo systemctl restart pdns       # Restart service
sudo systemctl status pdns        # Check status
sudo systemctl enable pdns        # Enable at boot
```

## PDNSUtil Commands

### Zone Management
```bash
# Create a new zone
pdnsutil create-zone example.com

# Add a record
pdnsutil add-record example.com www A 192.168.1.10
pdnsutil add-record example.com mail MX "10 mail.example.com"

# Delete a zone
pdnsutil delete-zone example.com

# List all zones
pdnsutil list-all-zones

# Show zone details
pdnsutil list-zone example.com
```

### Zone Manipulation
```bash
# Check zone consistency
pdnsutil check-zone example.com

# Rectify zone (fix ordering/DNSSEC)
pdnsutil rectify-zone example.com

# Secure a zone (DNSSEC)
pdnsutil secure-zone example.com

# Show DNSSEC keys
pdnsutil show-zone example.com
```

### Backup and Restore
```bash
# Bind-style export
pdnsutil b2b-export example.com > example.com.zone

# Bind-style import
pdnsutil load-zone example.com example.com.zone
```

## PowerDNS Recursor

### Service Management
```bash
sudo systemctl start pdns-recursor
sudo systemctl stop pdns-recursor
sudo systemctl restart pdns-recursor
```

### Control
```bash
rec_control ping           # Check if running
rec_control reload-zones   # Reload zones
rec_control wipe-cache example.com  # Clear cache for domain
```

## Configuration

### Main Config Files
- Authoritative: `/etc/powerdns/pdns.conf`
- Recursor: `/etc/powerdns/recursor.conf`

### Common Settings
```ini
# pdns.conf
launch=gmysql              # Backend to use
gmysql-host=127.0.0.1
gmysql-user=pdns
gmysql-dbname=pdns

local-address=0.0.0.0      # Listen on all interfaces
local-port=53              # DNS port
```

## Troubleshooting

### Logs
```bash
journalctl -u pdns
journalctl -u pdns-recursor
```

### Testing
```bash
dig @localhost example.com
dig @localhost example.com AAAA
```

## Resources

- [Official Documentation](https://doc.powerdns.com/)
