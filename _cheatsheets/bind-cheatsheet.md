---
layout: cheatsheet
title: BIND Cheatsheet
description: BIND (Berkeley Internet Name Domain) is the most widely used Domain Name System (DNS) software.
---

BIND (Berkeley Internet Name Domain) is the most widely used Domain Name System (DNS) software.

## Service Management

### SystemD (Ubuntu/Debian)
```bash
sudo systemctl start bind9        # Start service
sudo systemctl stop bind9         # Stop service
sudo systemctl restart bind9      # Restart service
sudo systemctl reload bind9       # Reload configuration
sudo systemctl status bind9       # Check status
```

### SystemD (CentOS/RHEL)
```bash
sudo systemctl start named        # Start service
sudo systemctl stop named         # Stop service
sudo systemctl restart named      # Restart service
sudo systemctl reload named       # Reload configuration
sudo systemctl status named       # Check status
```

## Configuration Checking

### Check Configuration File
```bash
# Check syntax of named.conf
named-checkconf /etc/bind/named.conf

# Check with no output if successful (useful for scripts)
named-checkconf -z
```

### Check Zone File
```bash
# named-checkzone <zone> <file>
named-checkzone example.com /etc/bind/zones/db.example.com
```

## Control Commands (rndc)

### General Control
```bash
rndc reload                 # Reload configuration and zones
rndc reload example.com     # Reload specific zone
rndc reconfig               # Reload configuration file only warning: new zones only
rndc status                 # Show server status
rndc flush                  # Flush the server's cache
rndc stop                   # Gracefully stop the server
```

## Configuration Examples

### Zone Definition (named.conf.local)
```nginx
zone "example.com" {
    type master;
    file "/etc/bind/zones/db.example.com";
    allow-transfer { 192.168.1.5; };  # Secondary NS IP
};

zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.1";
};
```

### Zone File (db.example.com)
```bind
$TTL    604800
@       IN      SOA     ns1.example.com. admin.example.com. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.example.com.
@       IN      NS      ns2.example.com.
@       IN      A       192.168.1.10
ns1     IN      A       192.168.1.10
ns2     IN      A       192.168.1.11
www     IN      A       192.168.1.20
mail    IN      A       192.168.1.30
```

## Diagnostic Tools

### Dig
```bash
# Basic query
dig example.com

# Query specific nameserver
dig @127.0.0.1 example.com

# Query specific record type
dig example.com MX
dig example.com TXT

# Reverse lookup
dig -x 192.168.1.10

# Short answer
dig +short example.com
```

## Resources

- [ISC BIND Documentation](https://www.isc.org/bind/)
