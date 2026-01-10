---
title: The test with getenv("PATH") only returns an empty response
layout: archive
author: iqbwl
---
Saat melakukan installasi Owncloud, saya menemukan peringatan **The test with getenv("PATH") only returns an empty response**.

Untuk mengatasi hal tersebut, buka file konfigurasi php-fpm.

```bash
vim /etc/php/7.4/fpm/pool.d/www.conf
```

Kemudian cari dan uncomment baris dibawah ini:
```bash
env[HOSTNAME] = $HOSTNAME
env[PATH] = /usr/local/bin:/usr/bin:/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp
```

Setelah itu restart php-fpm.
