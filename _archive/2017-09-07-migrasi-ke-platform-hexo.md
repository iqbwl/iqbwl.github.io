---
title: Migrasi ke Platform Hexo
layout: archive
author: iqbwl
---
Sebelumnya, saya adalah pengguna layanan Blogger.com, setelah beberapa bulan saya membeli layanan Shared Hosting dan berMigrasi ke Platform Wordpress Self-Host.

![Hexo.io](/static/img/migrated/blog/img/hexo.png)

Namun saya kurang puas, karena saya harus membeli Layanan dengan spesifikasi yang tinggi untuk sebuah situs Wordpress yang powerfull hehe. Saya memutuskan untuk bermigrasi ke Platform Hexo, sebuah Framework blog sederhana tapi POWERFULL yang didukung oleh NodeJs. 

Saya memigrasikan artikel saya di Wordpress ke Hexo dengan menggunakan perintah:

```bash
$ npm install hexo-migrator-wordpress --save
$ hexo migrate wordpress <source>
```

Lalu saya edit menggunakan plugin yang sudah dibuat oleh Hexo agar bisa mengolah konten melalui GUInya, yaitu dengan menginstall plugin `hexo-admin`.

```bash
$ npm install --save hexo-admin
$ hexo server -d
```

Kemudian buka `localhost:4000/admin/` dan saya pun mulai mengedit konten yang sudah saya migrasikan, dari mulai mengganti tautan yang rusak, memindahkan gambar yang masih ngehost di hostinnya, dan lain-lain.

![https://iqbalbirrul.com](/static/img/migrated/blog/img/hexo-localhost-1.png)

Gambar diatas adalah tampilan dari situs ini.

Sekian dan terima kasih :).
