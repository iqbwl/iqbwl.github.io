---
title: Cek Kecepatan Koneksi Internet Melalui Terminal Linux
layout: archive
author: iqbwl
---
![Speedtest](/static/img/migrated/blog/img/speedtest.png)

Seringkali kita sebagai pengguna internet ingin mengetahui berapa kecepatan koneksi internet milik kita. Jika kamu pengguna linux untuk mengecek kecepatan koneksi internet kamu sangatlah mudah. Kita tidak perlu menunggu loading dari situs pengetes koneksi seperti **speedtest.net, speedtest.cbn.net.id, speedtest.telin.co.id**.

Kita hanya perlu menginstall tool speedtest pada linux kita sebegai berikut

```bash
sudo apt install speedtest-cli
```

Jika sudah lalu ketikan `speedtest` pada terminal lalu tekan enter, maka akan mengukur berapa kecepatan koneksi internet kamu :) .

```bash
$ speedtest
Retrieving speedtest.net configuration...
Retrieving speedtest.net server list...
Testing from XL (112.215.173.161)...
Selecting best server based on latency...
Hosted by PT INDOSATM2 (Jakarta) [0.74 km]: 91.777 ms
Testing download speed........................................
Download: 0.07 Mbit/s
Testing upload speed..................................................
Upload: 0.05 Mbit/s
```

Selesai. Sangat mudah bukan.. semoga bermanfaat :) .
