---
layout: cheatsheet
title: LDAP & Identity Management Cheatsheet
description: LDAP (Lightweight Directory Access Protocol) is an industry standard application protocol for accessing and maintaining distributed directory information services.
---


LDAP (Lightweight Directory Access Protocol) is an industry standard application protocol for accessing and maintaining distributed directory information services.


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

