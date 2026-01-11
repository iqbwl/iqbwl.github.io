---
title: Setup FTP di CentOS 7
layout: archive
author: iqbwl
---
#### Install  VSFTPD
```bash
yum update -y
``` 
```bash
yum install vsftpd -y
```
```bash
systemctl start vsftpd
systemctl enable vsftpd
```

#### Konfigurasi VSFTPD

```bash
cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
```

Edit file `/etc/vsftpd/vsftpd.conf` dan sesuaikan dengan konfigurasi berikut:
```bash
anonymous_enable=NO
```
```bash
local_enable=YES
```
```bash
write_enable=YES
```
```bash
chroot_local_user=YES
allow_writeable_chroot=YES
```

##### Tambah user list

Masih dengan mode edit file `/etc/vsftpd/vsftpd.conf`,  sesuaikan dengan konfigurasi berikut:

```bash
userlist_enable=YES
```
```bash
userlist_file=/etc/vsftpd/user_list
```
```bash
userlist_deny=NO
```

Simpan perubahan kemudian restart `vsftpd`.

```bash
systemctl restart vsftpd
```

Tambah user:
```bash
adduser user1
```
```bash
passwd user1
```

Masukan user baru ke list user ftp:

```bash
echo “user1” | sudo tee –a /etc/vsftpd/user_list
```

Restart kembali `vsftpd`.

```bash
systemctl restart vsftpd
```

#### Testing

```bash
~]# ftp
ftp> open IP_ADDRESS_or_HOSTNAME
```

![ftp](/static/img/migrated/blog/img/ftp-cli-test1.png)

Semoga bermanfaat.
