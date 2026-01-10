---
title: Mengamankan SSH dengan Fail2ban
layout: archive
author: iqbwl
---
Disini saya akan menggunakan fail2ban untuk meminimalisir serangan brute force ke service SSH.

## Update repository

Ubuntu 18.04 LTS

```bash
apt update -y
apt upgrade -y
```

CentOS 7

```bash
yum install epel-release -y
yum update -y
yum upgrade -y
```

## Install Fail2ban

Ubuntu 18.04 LTS

```bash
apt install fail2ban -y
```

CentOS 7

```bash
yum install fail2ban -y
```

### Start fail2ban

```bash
systemctl start fail2ban
systemctl enable fail2ban
```

### Konfigurasi fail2ban

- Salin file `jail.conf` ke `jail.local`
    ```bash
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    ```

- Buat konfigurasi

    ```bash
    vim /etc/fail2ban/jail.local
    ```

    Masukan konfigurasi seperti berikut terlebih dahulu:

    ```bash
    ignoreip = 127.0.0.1/8 ::1 (pengecualian IP untuk tidak diban pada saat gagal login)
    bantime = -1 (Banned permanen IP)
    findtime = 300s (waktu yang ditentukan, apakah IP layak di ban)
    maxretry = 3 (3x percobaan gagal= banned)
    ```

    Buat konfigurasi untuk SSH:

    ```bash
    [sshd]
    enabled = true
    port    = ssh
    logpath = %(sshd_log)s
    backend = %(sshd_backend)s
   ```
    Simpan dan restart fail2ban

### Status jail fail2ban

Untuk melihat status jail fail2ban dapat menggunakan perintah berikut:

```bash
fail2ban-client status sshd
```

![Jail status](/migrated/blog/img/fail2ban-jail-status.png)

Masukan perintah berikut untuk melihat log fail2ban:

```bash
tail -f /var/log/fail2ban.log
```

![Log fail2ban](/migrated/blog/img/fail2ban-banned-ip.png)

### Unban IP

Untuk melakukan unban IP, dapat menggunakan perintah berikut:

```bash
fail2ban-client set sshd unbanip IP_ADDRESS
```

Sekian dan terima kasih..
