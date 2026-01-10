---
title: Nextcloud under pfSense & Cloudflare
layout: archive
author: iqbwl
---
Untuk judul diatas, kira-kira gambaranya seperti ini.

![NextCloud + pfSense + Cloudflare](svg/nextcloud.svg)

Ini bertujuan agar akses web server hanya akan dari cloudflare saja, dan dari pihak luar tidak bisa langsung direct ke web server.

> Jika menggunakan vpn yang terhubung dengan pfsense, maka kita tetap bisa akses direct ke web server.

Pertama, siapkan vm untuk nextcloud dan vm untuk mariadb dan harus terhubung dengan pfsense.

- Nextcloud (Nginx): 192.168.2.3
- MariaDB: 192.168.2.4

Konfigurasi web server dan database nya agar saling terhubung, seperti akses database dari vm nextcloud ke vm mariadb dan documentroot Nextcloud-nya.

Untuk server block nginx bisa menggunakan konfigurasi di gist berikut:
> [https://gist.github.com/iqbwl/df4736b09d0c9e0b71c140aea4197c06](https://gist.github.com/iqbwl/df4736b09d0c9e0b71c140aea4197c06)

Setelah vm web dan mariadb siap, buka menu **firewall > alias > ip** di pfsense.
![Alias](/img/nextcloud/Screenshot_1.png)

Klik Add, kemudian tambahkan ip address dari cloudflare yang bisa dicek disini: [https://www.cloudflare.com/ips-v4](https://www.cloudflare.com/ips-v4)
![IP](/img/nextcloud/Screenshot_3.png)

Untuk type, pilih **network**
![Add Network](/img/nextcloud/Screenshot_4.png)

Setelah itu, masuk ke menu **firewall > nat > port forward**
![Nat](/img/nextcloud/Screenshot_2.png)

Klik Add, kemudian atur source dan destinasi nya.
![Port Forward](/img/nextcloud/Screenshot_5.png)

Pada source, pilih **single host or alias** kemudian pilih alias yang sebelumnya sudah ditambahkan.

Untuk **destination** jangan lupa set ke IP Public yang digunakan dan **rediret port range** ke **http** serta **redirect target ip** ke ip private vm nextcloud
![Config](/img/nextcloud/Screenshot_6.png)

Jika sudah selesai, arahkan domain di cloudflare ke ip public yang sudah ditentukan. Jangan lupa nyalakan proxy serta ssl pada sisi cloudflare.

Langkah selanjutnya adalah installasi nextcloud nya.

> Metode ini dilakukan apabila website terkena serangan atau ddos, maka akan tidak langsung direct ke web server yang dapat menyebabkan traffic network penuh atau web server mengalami down.
>
> Pada sisi cloudflare dapat diaktifkan fitur **under attack mode** atau **anti-ddos**.

Sekian...