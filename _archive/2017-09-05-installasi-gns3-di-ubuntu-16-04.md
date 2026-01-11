---
title: Installasi GNS3 di Ubuntu 16.04
layout: archive
author: iqbwl
---
Baiklah, langsung saja, bagaimana cara install GNS3. Sebelumnya, dalam hal ini sistem operasi yang digunakan adalah Ubuntu 16.04.

![GNS3](/static/img/migrated/blog/img/gns3-1.png)

Catatan: Prosedur instalasi ini dapat pula dilakukan di Ubuntu (atau bahkan distro lain, utamanya turunan Debian) versi lain dengan penyesuaian.

Tambahkan PPA GNS3

``` bash
  sudo add-apt-repository ppa:gns3/ppa
```

Tekan Enter, Ketikkan password, lalu Enter lagi. Lalu update repository kita dengan perintah :

``` bash
  sudo apt update
```

Jika proses di atas sudah selesai, kita dapat menginstall GNS3 :

``` bash
  sudo apt install gns3-gui
```

Selesai instalasi, aplikasi GNS3 dapat diakses melalui menu `Aplikasi > Edukasi > GNS3`, atau dengan mengetikkan perintah di terminal :

``` bash
  gns3
```

Tampilannya sebagai berikut :

![Tampilan GNS3](/static/img/migrated/blog/img/gns3-2.png)

Sebagai tambahan yang diperlukan, kita juga meng-install `qemu` :

``` bash
sudo apt install qemu
```

Qemu digunakan untuk menjalankan OS MikroTik di dalam GNS3.

Lihat video ini, bisa di copas lho :).

<script type="text/javascript" src="https://asciinema.org/a/136309.js" id="asciicast-136309" async></script>

Sumber :
- http://wiki.smktikwt.sch.id/doku.php/MikroTik/Install_GNS3_di_Ubuntu_16.04
- https://www.gns3.com
