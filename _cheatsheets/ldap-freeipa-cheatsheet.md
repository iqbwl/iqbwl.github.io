---
layout: cheatsheet
title: LDAP & Identity Management Cheatsheet
description: Essential commands for Generic LDAP, FreeIPA, Samba AD DC, and OpenLDAP
---


A comprehensive reference for managing LDAP directories and Identity Management systems.

## Generic LDAP Tools

Standard tools available in `ldap-utils` (Debian/Ubuntu) or `openldap-clients` (RHEL).

### Browsing & Search
```bash
# Basic search (search everything)
ldapsearch -x -b "dc=example,dc=com"

# Search with filter
ldapsearch -x -b "dc=example,dc=com" "(objectClass=person)"

# Search specific user by UID
ldapsearch -x -b "dc=example,dc=com" "(uid=jdoe)"

# Authenticated search (bind DN)
ldapsearch -x -D "cn=admin,dc=example,dc=com" -W -b "dc=example,dc=com"

# Show specific attributes only
ldapsearch -x -b "dc=example,dc=com" "(uid=jdoe)" cn mail mobile
```

### Modification
```bash
# Add entry from LDIF file
ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f user.ldif

# Modify entry (LDIF must contain 'changetype: modify')
ldapmodify -x -D "cn=admin,dc=example,dc=com" -W -f modify.ldif

# Delete entry
ldapdelete -x -D "cn=admin,dc=example,dc=com" -W "uid=jdoe,ou=people,dc=example,dc=com"

# Change password
ldappasswd -x -D "cn=admin,dc=example,dc=com" -W -S "uid=jdoe,ou=people,dc=example,dc=com"
```

---

## FreeIPA

Identity, Policy, and Audit. All commands require `kinit admin` first.

### User Management
```bash
ipa user-find jdoe           # Find user
ipa user-add jdoe --first=John --last=Doe --password  # Add user
ipa user-mod jdoe --email=jdoe@example.com  # Modify user
ipa user-disable jdoe        # Disable user
ipa user-enable jdoe         # Enable user
ipa user-del jdoe            # Delete user
ipa user-show jdoe           # Show details
```

### Group Management
```bash
ipa group-add developers --desc="Developer Team" # Create group
ipa group-add-member developers --users=jdoe     # Add user to group
ipa group-find developers    # Find group
ipa group-del developers     # Delete group
```

### Host & Service Management
```bash
ipa host-add server01.example.com       # Register generic host
ipa host-del server01.example.com       # Remove host
ipa service-add HTTP/server01.example.com # Add service principal
ipa getkeytab -s ipaserver.example.com -p HTTP/server01.example.com -k /etc/krb5.keytab # Generate keytab
```

### Access Control (HBAC)
```bash
ipa hbacrule-add allow_ssh              # Create HBAC rule
ipa hbacrule-add-user allow_ssh --groups=admins # Add user/group context
ipa hbacrule-add-host allow_ssh --hosts=server01.example.com # Add target host
ipa hbacrule-add-service allow_ssh --hbacsvcs=sshd # Add service
ipa hbacrule-enable allow_ssh           # Enable rule
# Test HBAC
ipa hbac-test --user=jdoe --host=server01.example.com --service=sshd
```

### Topology & Replication
```bash
ipa-replica-manage list                 # List replicas
ipa-replica-manage connect server1 server2 # Create replication agreement
ipa-replica-manage del server2          # Remove replica
ipa topologysegment-find                # Show topology segments
```

---

## Samba AD DC
Active Directory Domain Controller on Linux. Managed via `samba-tool`.

### Domain & DNS
```bash
samba-tool domain info 127.0.0.1        # Domain info
samba-tool domain level show            # Functionality level
samba-tool drs showrepl                 # Check replication status
samba-tool dns query localhost example.com @ A # Query DNS record
samba-tool dns add localhost example.com myserver A 10.0.0.5 # Add DNS A record
```

### User & Group Management
```bash
samba-tool user list                    # List all users
samba-tool user create jdoe             # Create user (prompt for pass)
samba-tool user setpassword jdoe        # Reset password
samba-tool user delete jdoe             # Delete user
samba-tool user disable jdoe            # Disable account

samba-tool group list                   # List groups
samba-tool group add "Domain Admins"    # Add group
samba-tool group addmembers "Team" jdoe # Add member
samba-tool group listmembers "Team"     # List members
```

### Service Management (FSMO)
```bash
samba-tool fsmo show                    # Show FSMO roles owners
samba-tool fsmo seize --role=all        # Seize roles (disaster recovery)
samba-tool fsmo transfer --role=all     # Transfer roles gracefully
```

---

## OpenLDAP (Slapd)
Low-level OpenLDAP server management.

### Configuration & Database
```bash
# Check configuration
slaptest -f /etc/ldap/slapd.conf

# Export database to LDIF (Backup)
slapcat -n 1 -l backup.ldif

# Import LDIF to database
slapadd -n 1 -l backup.ldif

# Index regeneration
slapindex
```

### Runtime Config (cn=config)
```bash
# Modify dynamic config
ldapmodify -Y EXTERNAL -H ldapi:/// -f changes.ldif

# Check who am I (auth test)
ldapwhoami -H ldap://localhost -x -D "cn=admin,dc=example,dc=com" -W
```

---

## Troubleshooting & Ports

### Common Ports & Protocols
| Port | Protocol | Description |
|------|----------|-------------|
| 389 | TCP/UDP | LDAP (StartTLS recommended) |
| 636 | TCP | LDAPS (LDAP over SSL) |
| 88 | TCP/UDP | Kerberos |
| 53 | TCP/UDP | DNS (AD/FreeIPA Integrated) |
| 445 | TCP | SMB/CIFS (Samba) |

### Debugging
```bash
# Check listening ports
ss -tulpn | grep -E ":(389|636|88)"

# Test Kerberos ticket (FreeIPA/AD)
kinit admin
klist

# Test connectivity
nc -zv ldap.example.com 389
openssl s_client -connect ldap.example.com:636
```
