---
title: BunsenLabs, Distro Ringan Turunan Debian Jessie
layout: archive
author: iqbwl
---
[BunsenLabs](https://www.bunsenlabs.org) merupakan Distro Linux turunan Debian "Jessie". Distro ini adalah lanjutan dari Distro Linux [Crunchbang](http://distrowatch.com/crunchbang). Versi rilis terbarunya yaitu Hydrogen RC2.

![BunsenLabs](/migrated/blog/img/bunsenlabs.png)

Distro ini sangat ringan karena menggunakan [Openbox](http://openbox.org/wiki/Main_Page) sebagai window managernya. Dan juga menggunakan Thunar sebagai File Managernya.

![Thunar](/migrated/blog/img/bunsenlabs-thunar.png)

Aplikasi lain yang terinstall pada BunsenLabs yaitu tint2 panel, conky system monitor, iceweasel, vlc, dan lain lain. Juga dilengkapi software editing seperti Inkscape dan Gimp.

Keunggulan distro ini ialah sedikitnya memori ram yang digunakan ketika idle (tidak menjalankan aplikasi), tetapi masih dibawah **Lubuntu**.

Untuk mendapatkan BunsenLabs, bisa di unduh melalui halaman resmi [BunsenLabs](https://www.bunsenlabs.org/installation.html).

Untuk membuat USB Bootable, usahakan menggunakan linux dengan perintah di terminal :

```bash
dd if=/path/to/bunsenlab.iso of=/dev/sd{letter}
```

karena jika menggunakan YUMI atau Unetbootin di windows akan menimbulkan error.

Sekian, semoga bermanfaat.


Sumber :
- http://linuxsec.org
