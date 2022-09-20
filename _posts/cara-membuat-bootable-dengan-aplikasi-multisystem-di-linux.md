---
title: Cara membuat Bootable dengan Aplikasi Multisystem di Linux
date: '2016-02-23 15:27:00 +0000'
draft: false
tags:
- multisystem
- bootable
author: iqbal
---

Multisystem adalah aplikasi di linux Ubuntu dan turunannya yang memungkinkan seseorang untuk dapat membuat multiboot sistem operasi pada media Flashdisk. Dengan aplikasi Multisystem ini kita dapat menambah atau membuat beberapa bootable atau installer sistem operasi seperti Windows, Linux (Ubuntu, Linux Mint) dan masih banyak lagi.

![Multisystem](https://gh.iqbal.id/blog/img/multisystem.png)

Kini saya akan membagikan Cara membuat Bootable dengan Aplikasi Multisystem di Linux.

Pertama, download terlebih dahulu installer multisystemnya, di [SINI](http://idsly.com/EjGo59PM).

Ekastrak file `tar.bz2` tersebut, lalu Anda akan mendapati file `.sh`.

Install Multisystem dengan mengetikan perintah berikut di Terminal.

![Installasi 1](https://gh.iqbal.id/blog/img/multisystem_1.png)

Masukan password, dan tunggu Installasi hingga selesai.

![Installasi Selesai](https://gh.iqbal.id/blog/img/multisystem_2.png)

Masukan USB FlashDisk ke Komputer, ukuran FlashDisk minimal 8 GB dan pastikan sudah di Format menggunakan filesystem `fat32`.
Buka aplikasi multisystem. `Menu > Accessories > Multisystem`, lalu klik Konfirmasi.

![Interface](https://gh.iqbal.id/blog/img/multisystem_3.png)

Jika muncul dialog Harap konfirmasi `installasi grub2 di volume:/dev/sdb1` klik Ok.

![Installasi Grub2](https://gh.iqbal.id/blog/img/multisystem_4.png)

Lalu klik ikon CD untuk memilih file `.iso`.

![Memilih File .iso](https://gh.iqbal.id/blog/img/multisystem-5.png)

Pilih file .iso yang akan di jadikan Installer, lalu klik OK.

![Pilih File](https://gh.iqbal.id/blog/img/multisystem-6.png)

Masukan Password lalu tekan Enter dan tunggu hingga Proses pembuatan Installer selesai.

![Masukan Password](https://gh.iqbal.id/blog/img/multisystem-7.png)

Untuk menambahkan Installer Lainnya, caranya sama saja.

![Multisystem](https://gh.iqbal.id/blog/img/multisystem-8.png)

Kemudian tes Installer untuk melihat sudah berjalan dengan baik atau belum dengan klik menu `Boot > Tes LiveUSB Anda di Qemu`, lalu masukan Password dan tekan Enter.

![Password Again](https://gh.iqbal.id/blog/img/multisystem-9.png)

Ini adalah tampilan Bootable saat proses Booting.

![Tampilan Bootable](https://gh.iqbal.id/blog/img/multisystem-10.png)


Selesai, semoga bermanfaat :).
