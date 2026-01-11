---
title: Mengalihkan Request HTTP ke HTTPS
layout: archive
author: iqbwl
---
Beberapa hari lalu beli hosting dan gratis SSL dari **Let's Encrypt** di [**IDHosts.co.id**](http://idhosts.co.id) dan langsung konfigurasi supaya SSLnya aktif.

![HTTPS](/static/img/migrated/blog/img/https-img.png)

Setelah aktif domain saya sudah bisa diakses melalui `https://iqbalbirrul.web.id` namun jika diakses menggunakan protokol `http://` saja tidak langsung mengarah ke `https://iqbalbirrul.web.id`, dan untuk mengatasinya saya mencari cara di google dan menemukan cara untuk mengalihkan request `http` ke `https`. Berikut caranya.

Buka file manager lewat cpanel atau FTP, lalu edit file `.htaccess` yang terletak didalam folder root `public_html` dan masukan kode berikut kedalam file `.htaccess`

```bash
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
```

Jika sudah, sekarang domain saya sudah bisa mengakses  `http://iqbalbirrul.web.id` akan langsung mengarah ke `https://iqbalbirrul.web.id`

Dan proses sudah selesai, sekian dan semoga bermanfaat.

sumber dan gambar :
- [google.com](//google.com)
- [orangorangan.com](//orangorangan.com)
