---
title: Implementasi Nginx sebagai Reverse Proxy
layout: learning
author: iqbwl
---
## Reverse Proxy

Yang pertama, kita perlu tau apa itu Proxy Server.

Proxy Server adalah sebuah server perantara yang meneruskan request konten dari client ke beberapa server yang berbeda.

Dan untuk reverse proxy adalah salah satu jenis dari proxy, yang biasanya reverse proxy digunakan sebagai perantara antara client dengan web server/aplikasi.

## Nginx Reverse Proxy

Semua web server yang memiliki fitur proxy, akan mampu digunakan sebagai reverse proxy, salah satunya adalah Nginx.

Nginx ini selain ringan juga dapat digunakan sebagai reverse proxy untuk beberapa protokol misalnya, seperti: HTTP, HTTPS, TCP, UDP, SMTP, IMAP, dan POP3.

Cara kerjanya seperti ini, Saat client akses website yang menggunakan reverse proxy, maka requestnya akan ditampung oleh Nginx dimana Nginx ini bertindak sebagai reverse proxy, kemudian Nginx akan meneruskan request ke node backend yang sudah ditentukan sebelumnya (misal node A), node A ini akan memberikan respon nya ke Nginx dan Nginx akan memberikan respon tersebut ke client.

Nginx Reverse Proxy memiliki beberapa kegunaan lain:

### Load Balancing

Nginx dapat digunakan sebagai load balancing, nah load balancing ini adalah sebuah metode untuk membagi request yang ditujukan ke webserver maupun protocol lainnya dan akan di distribusikan secara merata ke beberapa server/node yang sudah ditentukan sehingga dapat menghindari skenario dimana server mengalami kelebihan beban atau overload.

Jadi jika salah satu server backend down, maka akan digantikan oleh server backend lain yang sudah di tentukan.

#### Web Acceleration

Reverse Proxy dapat mengkompress data inbound dan outbond serta dapat menyimpan cache ataupun konten static dan dapat mempercepat koneksi antara client dan server.

#### Security & Anonymity

Dengan mencegah akses langsung ke server backend, reverse proxy dapat melindungi identitas server backend dan bertindak sebagai keamanan tambahan terhadap serangan.

Jadi client tidak langsung akses secara langsung atau direct ke node backend.


## Membagi beban dengan Nginx Reverse Proxy

Seperti yang saya sebutkan sebelumnya, reverse proxy pada Nginx dapat digunakan untuk load balancing.

Untuk Load Balancing di Nginx ada beberapa metode yaitu:

### Round Robin

Round Robin ini merupakan metode default. Jika pada nginx parameter load balancing nya tidak ditentukan, metode yang digunakan secara otomatis adalah round robin.

Metode Round Robin ada kelebihan dan kekurangannya, metode ini akan menjamin beban akses yang masuk ke setiap node backend akan selalu sama.

Untuk kelemahannya adalah operator/sysadmin harus menyiapkan metode untuk mempertahankan session, dengan menggunakan metode round robin, bisa saja user yang sedang login di node A dapat terlempar ke node B di detik berikutnya dan mengakibatkan user log out dari website atau mengalami error.

Contoh konfigurasi:
```
upstream backend{
server 192.168.2.2; # Node A
server 192.168.2.3; # Node B
}
```


### Least Connections

Least Connections merupakan metode yang mengarahkan request pada node dengan jumlah koneksi paling sedikit, tidak peduli besarnya beban akses dan siapa clientnya. Jika node A sudah memiliki 50 akses (akses ringan) dan node B memiliki 40 akses (akses berat) maka akses selanjutnya tetap akan diberikan ke node B.

Untuk metode ini msaih berpengaruh ke session, meski tidak sebesar round robin.

Contoh konfigurasi:
```
upstream backend{
    least_conn;
    server 192.168.2.2; # Node A
    server 192.168.2.3; # Node B
}
```

### IP Hash

IP Hash ini dimana IP Client akan dihitung dengan rumusan hashing tertentu, sehingga akan menentukan Client akan mendapatkan node yang mana, node A atau B.

Dengan metode IP Hash ini, akan lebih menjamin Client tidak akan terputus sessionnya karena dipindahkan ke node lain dan tidak perlu mengatur konfigurasi session.

Contoh konfigurasi:
```
upstream backend{
ip_hash;
server 192.168.2.2; # Node A
server 192.168.2.3; # Node B
}
```

### Generic Hash

Dengan metode Generic Hash ini, backend tujuan akan ditentukan berdasarkan sesuatu yang dibawa oleh si client yang dalam hal ini adalah "key" bisa saja berupa variable, string atau parameter lain.

Contoh konfigurasi:
```
upstream backend{
hash $request_uri consistent;
server 192.168.2.2; # Node A
server 192.168.2.3; # Node B
}
```

Kelemahan metode hashing ini adalah tingkat kerataan beban akses masing-masing node, ini jelas akan kalah dengan round robin ataupun least conn. Ditambah lagi, proses hashing ini dan rumusan itu akan menambah proses pada nginx untuk mendapatkan hasil hashing load balancer, dikhawatirkan proses ini akan membebani node nya.

____________
#### Session

Dari beberapa metode yang sudah dibahas, metode yang paling simple adalah round robin dan least connections, karena dalam prosesnya nginx tidak perlu membuat hash ip dan segala hal. Namun dibalik simple nya itu, seperti yang sudah saya sebutkan sebelumnya bahwa operator/sysadmin harus menyiapkan metode untuk mempertahankan session, yaitu dengan menggunakan session replication.

Nah session ini adalah salah satu sistem penyimpanan data sementara ke server web.

Dengan menggunakan session replication, maka setiap session yang terbentuk di node A juga akan terbentuk di node B.

Untuk konfigurasinya bisa dilakukan melalui konfigurasi php, disini kita bisa memakai memcached atau redis sebagai session handler nya.

Memcached ini merupakan sebuah program yang digunakan untuk menyimpan cache, agar proses yang biasa dijalankan dapat disimpan dan digunakan ulang. Memcached bersifat sebagai network service yang berjalan pada port 11211.

Kemudian redis adalah penyimpanan data struktur didalam memory yang digunakan sebagai database, cache, message broker dan thread.

Sebenarnya masih ada cara lain untuk mendapatkan presistent session, namun hanya ada di Nginx plus.