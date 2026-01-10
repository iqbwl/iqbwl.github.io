---
title: Redirect menggunakan html
layout: docs
author: iqbwl
---
Untuk redirect menggunakan html, cukup tambahkan parameter berikut pada header html:
```html
<meta http-equiv="Refresh" content="0; url='https://iqbal.id'" />
```

Agar ada jeda beberapa detik sebelum redirect, ganti value `content` menjadi angka yang diinginkan, misal 3 untuk 3 detik.
```html
<meta http-equiv="Refresh" content="3; url='https://iqbal.id'" />
```

Contoh html:
```html
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="refresh" content="3; url='https://iqbal.id'" />
  </head>
  <body>
    <p>lanjut ke <a href="https://iqbal.id">iqbal.id</a>.</p>
  </body>
</html>
```

Selesai.