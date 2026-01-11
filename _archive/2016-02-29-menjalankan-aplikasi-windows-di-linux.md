---
title: Menjalankan Aplikasi Windows di Linux
layout: archive
author: iqbwl
---
Apakah sobat pernah berpikir bahwa aplikasi _Windows_ tidak bisa dijalankan di Lain sistem operasi? Jawabannya adalah tentu saja bisa. Ada beberapa cara untuk menjalankan aplikasi _Windows_ di linux kita tercinta ini seperti menggunakan Virtual Machine, PlayOnLinux, Wine, dan Remote Desktop. Tapi kali saya akan menggunakan Wine.

![Line](/static/img/migrated/blog/img/Wine_Line.png)

Wine merupakan salah satu Software gratis untuk menjalankan aplikasi Windows di Linux. Tetapi tidak semua aplikasi _Windows_ dapat dijalankan di oleh Wine, untuk mengetahui apa saja yang dapat di jalankan oleh Wine lihat di [Wine Application Database](http://appdb.winehq.org/).

Caranya :

Pertama Install Wine terlebih dahulu dengan mengetikan perintah berikut di terminal.

```bash
sudo apt-get install wine
```
lalu masukan password dan tekan enter, dan tunggu hingga Installasi selesai.

Pastikan Wine sudah terinstall dengan membuka `Menu > Wine`.

Kemudian siapkan aplikasi _Windows_ yang akan di install, pada kasus ini saya akan install Line Desktop.

![Line App](/static/img/migrated/blog/img/wine_1.png)

Klik kana pada `LineInst.exe` lalu pilih Buka dengan Wine.

Kemudian lanjutkan proses installasi seperti saat menginstall aplikasi di _Windows_ dan tunggu sampai Installasi selesai.

![Install Line](/static/img/migrated/blog/img/wine_2.png)

![Install Line](/static/img/migrated/blog/img/wine_3.png)

Jika sudah selesai maka aplikasi akan otomatis berada di Desktop, jika tidak ada bisa buka di `Menu > Wine > Nama Aplikasi`.

![Aplikasi sudah terinstall](/static/img/migrated/blog/img/wine_4.png)

Jalankan aplikasi layaknya menggunakan aplikasi tersebut di _Windows_.

![Line](/static/img/migrated/blog/img/wine_5.png)

Semoga bermanfaat :D.
