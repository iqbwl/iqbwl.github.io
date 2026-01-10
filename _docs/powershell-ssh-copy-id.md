---
title: Powershell ssh-copy-id
layout: docs
author: iqbwl
---
Cara import ssh public key melalui powershell.

```bash
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh user@domain.com "cat >>.ssh/authorized_keys"
```
