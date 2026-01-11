---
title: Konfigurasi DNS Server Di Ubuntu 18.04 LTS
layout: archive
author: iqbwl
---
# DNS
DNS (Domain Name System) adalah layanan yang menerjemahkan nama domain situs web seperti, contoh: `google.com` menjadi alamat IP (IP Address) sehingga pengguna internet bisa membuka situs tujuan dengan cepat.

![DNS Server](/static/img/migrated/blog/img/dns.png)

## Fungsi DNS
- Melakukan identifikasi alamat komputer dalam suatu jaringan.
- Mentranskripsikan nama domain menjadi IP Address.

## Konsep atau cara kerja DNS
Untuk menjalankan tugasnya, DNS server memerlukan program resolver untuk menghubungkan setiap komputer pengguna dengan DNS server. Program resolver yang dimaksud adalah web browser dan mail client.

### Komponen-komponen DNS Server
- DNS Resolver : adalah klien yang merupakan komputer pengguna, pihak yang membuat permintaan DNS dari suatu program aplikasi
- Recursive DNS server : adalah pihak yang melakukan pencarian melalui DNS berdasarkan permintaan resolver, kemudian memberikan jawaban pada resolver tersebut.
- Authoritative DNS server : pihak yang memberikan respon setelah recursive melakukan pencarian. Respon dapat berupa sebuah jawaban maupun delegasi ke DNS server lainnya.

### Cara Kerja DNS
- Mencari alamat host pada file HOSTS, bila ada berikan alamatnya dan proses selesai. 
- Mencari pada data cache yang dibuat oleh resolver untuk menyimpan hasil permintaan sebelumnya, bila ada simpan dalam data cache, berikan 	hasilnya dan selesai. 
- Mencari pada alamat Server DNS pertama yang telah ditentukan oleh user. 
- Server DNS yang ditunjuk akan mencari nama domain pada cache-nya. 
- Apabila tidak ketemu, pencarian dilakukan dengan melihat file database domain (zones) yang dimiliki oleh server. 
- Apabila tetap tidak menemukan, maka server ini akan menghubungi Server DNS lain yang sudah dikaitkan dengan server ini. Jika ketemu simpan dalam cache dan berikan hasilnya. 
- Apabila pada Server DNS pertama tidak ditemukan pencarian dilanjutkan pada Server DNS kedua dan seterusnya dengan proses yang sama seperti diatas.

## Manfaat DNS Server
- Alamat sebuah situs web atau blog, menjadi lebih mudah untuk diingat.
- DNS memudahkan kita untuk mengakses website tertentu tanpa harus repot mengetikan alamat IP yang berupa angka panjang seperti `112.108.11.11`. Kita cukup mengingat nama domain website yang kita tuju seperti `yahoo.com`, `google.com`.

## Membuat DNS Server
Saya belajar membuat DNS server menggunakan sistem operasi Ubuntu Server 18.04 LTS.

- Langkah pertama yaitu install `bind9`

```bash
root@cloudsrv2:~# apt update
root@cloudsrv2:~# apt install bind9 bind9utils
```

- Konfigurasi `bind9`

```bash
root@cloudsrv2:~# cd /etc/bind/
root@cloudsrv2:/etc/bind# vi named.conf
```

-  Edit file `named.conf` menjadi seperti berikut:

```bash
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";

# include "/etc/bind/named.conf.default-zones";

include "/etc/bind/named.conf.external";
```

- Edit file `named.conf.options`, menjadi seperti berikut:

```bash
root@cloudsrv2:/etc/bind# vi named.conf.options
# buat konfigurasi seperti berikut
options {
        directory "/var/cache/bind";
        allow-query { localhost; 117.53.46.186; };
        allow-transfer { localhost; 117.53.46.186; };
        allow-recursion { localhost; 117.53.46.186; };

        dnssec-validation auto;
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { none; };
};
```

- Buat file `named.conf.external`:

```bash
root@cloudsrv2:/etc/bind# vi named.conf.external

# masukan konfigurasi seperti berikut

view "external" {
        match-clients { any; };
        allow-query { any; };
        recursion no;

        zone "iqbalbirrul.web.id" { # sesuaikan nama domain
                type master;
                file "/etc/bind/server1.db";
                allow-update { none; };
        };
};                       
```

- Buat file zone untuk record-record DNS `server1.db`:

```bash
root@cloudsrv2:/etc/bind# vi server1.db

# buat zone sebagai berikut:
# untuk record-record, silakan menyesuaikan

$TTL 86400
@       IN      SOA      ns1.iqbalbirrul.web.id. root.iqbalbirrul.web.id.(
                                2019070914      ;Serial
                                3600            ;Refresh
                                1800            ;Retry
                                604800          ;Expire
                                86400           ;Minimum TTL
)

@       IN      NS      ns1.iqbalbirrul.web.id.
@       IN      NS      ns2.iqbalbirrul.web.id.

@       IN      A       117.53.46.186
ns1     IN      A       117.53.46.186
ns2     IN      A       117.53.46.186

cloudsrv2       IN      A       117.53.46.186

www     IN      CNAME iqbalbirrul.web.id.
```

- Konfigurasi selesai, sekarang jalankan service `bind9`

```bash
root@cloudsrv2:~# systemctl start bind9
```

### Private Nameserver

Setelah membuat DNS server, silakan membuat private nameserver/glue record untuk domain pada penyedia nama domain.

Berikut nameserver yang harus di tambahkan:

```bash
Nameserver: ns1
IP Address: IP Address DNS Server

Nameserver: ns2
IP Address: IP Address DNS Server
```

- Kemudian ubah nameserver domain ke private nameserver yang telah dibuat.

> Sebagai catatan, perubahan nameserver pada domain akan membuat domain mengalami propagasi. Propagasi sendiri diperlukan waktu maksimal 48 Jam, lama atau tidaknya proses propagasi tergantung dari resolver ISP yang digunakan.

- Kemudian, test apakah domain sudah terhubung ke nameserver dengan cara berikut:

```bash
iqbal@ThinkPad-E450:~$ dig iqbalbirrul.web.id +short
117.53.46.186
iqbal@ThinkPad-E450:~$ nslookup iqbalbirrul.web.id
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	iqbalbirrul.web.id
Address: 117.53.46.186
```

Konfigurasi selesai, semoga bermanfaat

Sumber : https://www.server-world.info/en/note?os=Ubuntu_18.04&p=dns&f=1
