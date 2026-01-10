---
title: Konfigurasi NAT Iptables
layout: archive
author: iqbwl
---
Sebelumnya saya sedang mencoba membuat website WordPress dengan topology load balancing, dengan detailnya dibawah ini:

- 1 VM LB
- 2 VM Web Server
- 1 VM Database

Untuk VM LB, terdapat 2 interface yaitu IP Publik (eth0) dan IP Private sebagai gateway (eth1) . Sedangkan untuk 3 VM lainnya hanya mempunyai 1 interface saja yaitu IP Private (eth0), sehingga untuk 3 VM ini tidak mendapatkan akses ke internet untuk install maupun update package.

Guna mengatasi hal tersebut saya memasukan beberapa konfigurasi pada Iptables, agar si eth1 ini mendapatkan akses internet. Cara sebagai berikut:

Backup terlebih dahulu konfigurasi Iptables yang ada

```bash
cp /etc/sysconfig/iptables-config /etc/sysconfig/iptables-config.bak
```

Masukan konfigurasi pada kernel

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i "s/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g" /etc/sysctl.conf
```

Tambahkan konfigurasi pada Iptables

```bash
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
```

Restart Iptables

```bash
systemctl reload iptables
```

Konfigurasi diatas bertujuan agar koneksi internet bisa diteruskan dari `eth0` ke` eth1`, shingga IP Private yang lain dengan subnet yang sama akan mendapatkan akses internet.

Segitu saja, semoga bermanfaat.

> Sc: archive [lime.web.id](http://lime.web.id)
