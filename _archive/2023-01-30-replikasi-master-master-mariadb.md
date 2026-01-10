---
title: Replikasi Master-Master MariaDB + Nginx Reverse Proxy untuk Database
layout: archive
author: iqbwl
---
![Master-Master](/img/db-rep/db-master-master-nginx.png)

List server:

- Nginx - 192.168.2.3
- MariaDB 1 - 192.168.2.11
- MariaDB 2 - 192.168.3.11
- OS Ubuntu 22.04

Untuk instalasi MariaDB dan Nginx bisa dilihat pada tautan berikut:

- [https://www.server-world.info/en/note?os=Ubuntu_22.04&p=nginx&f=1](https://www.server-world.info/en/note?os=Ubuntu_22.04&p=nginx&f=1)
- [https://www.server-world.info/en/note?os=Ubuntu_22.04&p=mariadb&f=1](https://www.server-world.info/en/note?os=Ubuntu_22.04&p=mariadb&f=1)

## Konfigurasi MariaDB

Server 1 192.168.2.11

```bash
vim /etc/mysql/mariadb.conf.d/50-server.cnf
 
# ubah IP bind-address
bind-address = 192.168.3.11
 
# uncomment pada baris server-id
server-id = 1
 
# uncomment pada baris log_bin
log_bin = /var/log/mysql/mysql-bin.log 	
```

Server 2 192.168.3.11

```bash
vim /etc/mysql/mariadb.conf.d/50-server.cnf
 
# ubah IP bind-address
bind-address = 192.168.2.11
 
# uncomment pada baris server-id
server-id = 2
 
# uncomment pada baris log_bin
log_bin = /var/log/mysql/mysql-bin.log 	
```

Setelah itu restart mariadb di kedua server.
```bash
systemctl restart mariadb
```

## Buat user replikasi

Server 1 192.168.2.11
```bash
# masuk ke console mysql
mysql -u root -p

# berikan akses untuk server 2
GRANT REPLICATION SLAVE ON *.* TO 'replikasi'@'192.168.3.11' IDENTIFIED BY 'passwordkuat';

FLUSH PRIVILEGES;
```

Server 2 192.168.3.11
```bash
# masuk ke console mysql
mysql -u root -p

# berikan akses untuk server 1
GRANT REPLICATION SLAVE ON *.* TO 'replikasi'@'192.168.2.11' IDENTIFIED BY 'passwordkuat';

FLUSH PRIVILEGES;
```

## Konfigurasi Slave

Status Master Server 1
```bash
SHOW MASTER STATUS;

+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 |      564 |              |                  |
+------------------+----------+--------------+------------------+	
```

Status Master Server 2
```bash
SHOW MASTER STATUS;

+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 |      564 |              |                  |
+------------------+----------+--------------+------------------+	
```

### Server 1

Buat koneksi ke Server 2
```
CHANGE MASTER TO
MASTER_HOST='192.168.3.11',
MASTER_USER='replikasi',
MASTER_PASSWORD='passwordkuat',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=564; 
```

Jalankan slave:
```bash
START SLAVE;
```

Cek status apakah sudah berhasil login ke Server 2
```bash
SHOW SLAVE STATUS \G
```

### Server 2

Buat koneksi ke Server 1
```
CHANGE MASTER TO
MASTER_HOST='192.168.2.11',
MASTER_USER='replikasi',
MASTER_PASSWORD='passwordkuat',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=564; 
```

Jalankan slave:
```bash
START SLAVE;
```

Cek status apakah sudah berhasil login ke Server 1
```bash
SHOW SLAVE STATUS \G
```

#### Cara test

- Pada Server 1 buat database baru.
- Pada Server 2 cek database apakah database yang dibuat pada Server 1 muncul di Server 2.
- Lakukan juga sebaliknya.


## Nginx Reverse Proxy untuk Database

Untuk menggunakan reverse proxy ini cukup buat konfigurasi dibawah ini dan diletakan di `/etc/nginx.conf` diluar parameter `http {`.

```bash
stream {
 upstream db {
  server 192.168.2.11:3306;
  server 192.168.3.11:3306;
 }
 server {
  listen 3306;

  proxy_pass db;
  proxy_connect_timeout 1s;
 }
}
```

Lihat gambar dibawah:
![Nginx Proxy](/img/db-rep/nginx-proxy-db.png)

Cek port database dengan perintah `netstat -tulpn | grep nginx`:
![Port](/img/db-rep/nginx-port-db.png)

Untuk penggunaan database, berikan priveleges pada user database ke IP Address dari Server Nginx Reverse Proxy.

![Mysql console](/img/db-rep/mysql-console.png)

Selesai.