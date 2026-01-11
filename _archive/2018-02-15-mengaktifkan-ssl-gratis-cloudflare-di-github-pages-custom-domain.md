---
title: Mengaktifkan SSL Gratis Cloudflare di GitHub Pages
layout: archive
author: iqbwl
---
Sebenarnya, di GitHub sudah tersedia ssl gratis untuk setiap halaman yang dibuat (_GitHub Pages_). Namun untuk yang menggunakan nama domain sendiri atau custom domain, github tidak menyediakan ssl gratis.

![Cloudflare](/static/img/migrated/blog/img/ssl-cloudflare.png)

Contoh halaman github menggunakan ssl : `https://iqbalbirrul.github.io`
Lihat pada `https` yang menandakan ssl-nya aktif, sedangkan untuk custom domain, `http://www.iqbalbirrul.com` tidak diberi ssl.

##### Mengapa menggunakan SSL?
Situs saya `https://www.iqbalbirrul.com`, menggunakan platform blogging `Hexo.io` di GitHub Pages.

Saya sendiri menggunakan ssl karena senang saja dan ingin terlihat keren saja blognya _**(blognya keren pake ssl)**_, dan saya sudah menggunakan ssl sejak menggunakan platform WordPress, dengan ssl gratis dari `Let's Encrypt`. Terlebih lagi, situs/blog yang menggunakan ssl/https cenderung lebih disukai oleh mesin pencari dan meningkatkan kualitas **SEO**.

##### Mengaktifkan SSL Cloudflare
Langkah pertama, buatlah akun [Cloudflare](https://cloudflare.com) dan setting agar domain mengarah ke `name server` Cloudflare.
Jika domain sudah mengarah ke `name server` Cloudflare, masuk ke menu **DNS** dan setting dns di Cloudflare agar mengarah ke GitHub Pages , contoh seperti pada gambar dibawah ini.

![DNS Cloudflare](/static/img/migrated/blog/img/ssl-cloudflare-1.png)

Artinya, situs GitHub Pages kita akan melewati Cloudflare, baru kemudian diteruskan ke client.
Setelah domain berhasil di arahkan ke GitHub Pages, masuk ke menu **Crypto**, lalu atur ssl-nya menjadi **Full**.

![Mengaktifkan SSL](/static/img/migrated/blog/img/ssl-cloudflare-2.png)

Ada 4 pilihan, `Off, Flexible, Full, dan Full (strict)`. Perbedaannya seperti ini:

![Cloudflare SSL Modules](/static/img/migrated/blog/img/ssl-cloudflare-3.png)

##### Membuat Page Rules
Agar `http` diarahkan ke `https`, maka buatlah page rules. Masuk ke menu **Page Rules**, kemudian tambahkan _rules_ seperti ini.

![301 - Permanent Redirect](/static/img/migrated/blog/img/ssl-cloudflare-4.png)
![Always Use HTTPS](/static/img/migrated/blog/img/ssl-cloudflare-5.png)

Tambahkan juga _rules_ untuk chace-nya, seperti ini:

![Chace Everything](/static/img/migrated/blog/img/ssl-cloudflare-6.png)

##### Mengubah CNAME
Karena kita ingin menggunakan alamat domain dengan `https`, maka perlu mengubah konfigurasi pada setelan situs.
Di Hexo, buka `_config.yml` lalu setting sesuaikan seperti berikut:

```
url: https://www.iqbalbirrul.com
root: /
```

Tambahkan file `CNAME`,

```
www.iqbalbirrul.com
```

Masukan ke dalam folder `/source`, lalu generate dan deploy. Dan ssl-pun sudah aktif sepenuhnya.

![Iqbalbirrul.com](/static/img/migrated/blog/img/ssl-cloudflare-7.png)

Selesai, semoga bermanfaat.

NB: Untuk platform blog statis lainnya, dimohon untuk menyesuaikan.

sumber:
[blog.cloudflare.com](https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/), [www.petanikode.com](https://www.petanikode.com/ssl-untuk-github-pages)
