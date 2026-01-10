---
title: Install Plesk Panel Obsidian
layout: archive
author: iqbwl
---
## Plesk Panel

Plesk merupakan Control Panel yang cukup terkenal di dunia hosting setelah cPanel. Plesk sendiri adalah Control Panel berbayar sama seperti cPanel, namun kita bisa mendapatkan Trial nya selama 15 hari.

## Requirements Linux

### Hardware

Berikut ini adalah requirements yang saya rekomendasikan.

1. Minimum RAM 2 GB
2. Minimum CPU 2 Core
2. Minimum Storage 40 GB
3. 1 IP Publik

Silakan dilihat pada docs resmi Plesk Panel, untuk rekomendasi dari tim Plesk: https://docs.plesk.com/release-notes/obsidian/hardware-requirements/

### Software

Sistem operasi yang didukung Plesk Panel adalah sebagai berikut:

1. Debian 8 & 9 64-bit
2. Ubuntu 16.04, 18.04 & 20.04 64-bit
3. CentOS 6, 7 & 8 64-bit
4. RHEL 6, 7 & 8 64-bit
5. CloudLinux 6.x, 7.1 & terbaru 64-bit
6. Virtuozzo Linux 7 64-bit
7. Windows: https://docs.plesk.com/release-notes/obsidian/software-requirements/#s2-2

Untuk sistem operasi yang saya gunakan saat ini adalah CentOS 7 64-bit.

## Installation

- Login ke VPS sebagai user `root`, kemudian update sistem operasi terlebih dahulu dengan perintah berikut:

 ```bash
  yum update -y
 ```

- Setelah update selesai, install Plesk Panel dengan perintah berikut:

  ```bash
  sh <(curl https://autoinstall.plesk.com/one-click-installer || wget -O - https://autoinstall.plesk.com/one-click-installer)
  ```

  ![Installation Command](/migrated/blog/img/plesk-install_centos.png)

- Setelah installasi selesai, klik tautan yang tersedia pada instruksi untuk membuka setup pada web browser.

  ![Installation Completed](/migrated/blog/img/plesk-install-finish_centos.png)

- Pada setup web, masukan data-data yang dibutukan seperti nama, email, password dan lisensi lalu klik **Enter Plesk**

  ![Web Setup](/migrated/blog/img/plesk-install-setupweb_centos.png)

  > *) _Untuk lesensi trial/percobaan bisa didapatkan melalui tautan berikut: https://www.plesk.com/plesk-free-download/_
  > Silakan daftar menggunakan email.

- Tunggu sampai proses initializing selesai.

  ![Initializing](/migrated/blog/img/plesk-install-setupweb2_centos.png)
  
- Setelah proses initializing selesai, maka kita akan dibawa ke halaman dashboard Plesk Panel.

  ![Dashboard Plesk](/migrated/blog/img/plesk-dashboard.png)
  
## Tambah Domain

Setelah installasi selesai, sekarang kita tambahkan domain pada Plesk Panel.

- Klik **Add Domain** pada dashboard Plesk Panel, kemudian masukan data-data yang dibutuhkan lalu klik **OK**.

  ![Add a Domain](/migrated/blog/img/plesk-dashboard-adddomain.png)
  
- Setelah itu tunggu sampai proses penambahan domain selesai.

  ![Add a Domain Completed](/migrated/blog/img/plesk-dashboard-adddomain-finish.png)

- Berikut ini merupakan tampilan default dari laman website yang ditambahkan pada Plesk Panel.

  ![Plesk Default Pages](/migrated/blog/img/plesk-default-pages.png)

Installasi dan penambahan domain pada Plesk Panel telah selesai, semoga bermanfaat.
