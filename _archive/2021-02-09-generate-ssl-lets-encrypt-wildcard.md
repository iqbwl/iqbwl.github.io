---
title: Generate SSL Let's Encrypt Wildcard
layout: archive
author: iqbwl
---
### Certbot

Gunakan certbot untuk generate Wildcard SSL.

##### DNS Only Verification

Wildcard SSL

```bash
certbot certonly --manual --preferred-challenges=dns --email email@domain.com --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.domain.com -d domain.com
```

Proses generate membutuhkan verifikasi dns, jadi record dns yang dibutuhkan harus ditambahkan di dns management domain. Record dns yang perlu ditambahkan akan muncul pada saat proses generate.

```bash
certbot renew --dry-run
```

Semoga bermanfaat.


> Sc: archive [kuro.zone](http://kuro.zone)
