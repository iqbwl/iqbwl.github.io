---
title: Remote Access MySQL atau MariaDB
layout: archive
author: iqbwl
---
## Konfigurasi

Konfigurasi MariaDB dengan merubah bind address dari `127.0.0.1` menjadi `0.0.0.0`, kemudian restart service.

```bash
root@db:~# vim /etc/mysql/mariadb.conf.d/50-server.cnf

###
# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
bind-address            = 0.0.0.0
###

root@db:~# systemctl restart mariadb
```

Cek ketersediaan port database:

```bash
root@db:~# netstat -tulpn | grep 3306
tcp        0      0 0.0.0.0:3306            0.0.0.0:*               LISTEN      3675/mysqld         
```

Buat user MySQL/MariaDB:

```bash
root@db:~# mysql -u root -p
Enter password: 

MariaDB [(none)]> use mysql

Database changed
MariaDB [mysql]> CREATE USER 'username'@'CLIENT_IP' IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.00 sec)
```

Cek privileges dari user tersebut:

```bash
select * from user where user='username' \G
```

![Privileges 1](/static/img/migrated/blog/img/mariadb-privileges1.png)

User tersebut belum mendapatkan hak akses. Tambahkan hak akses terlebih dahulu pada user tersebut.

```bash
MariaDB [mysql]> GRANT ALL ON *.* to 'username'@'CLIENT_IP';
MariaDB [mysql]> update user SET Grant_priv='Y'  WHERE User = 'kilat';
```

Cek kembali privileges dari user tersebut.

```bash
select * from user where user='username' \G
```

![Privileges 2](/static/img/migrated/blog/img/mariadb-privileges2.png)

Sekarang user tersebut sudah mendapatkan hak akses penuh pada MySQL/MariaDB.

### Percobaan

Tes koneksi ke database menggunakan telnet:

```bash
$ telnet IP_DATABASE 3306
```

![Testing 1](/static/img/migrated/blog/img/mariadb-testing1.png)

Tes login ke MySQL/MariaDB:

```bash
$ mysql -h IP_DATABASE -u username -p
```

![Testing 2](/static/img/migrated/blog/img/mariadb-testing2.png)

Selesai.
