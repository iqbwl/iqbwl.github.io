---
title: Make a Private Git Repository Using GitLab CE
layout: archive
author: iqbwl
---
**GitLab Community Edition (CE)** adalah platform pengembangan end-to-end perangkat lunak open source dengan built-in version control, issue tracking, code review, CI/CD, dan banyak lagi.

![GitLab CE](/static/img/migrated/blog/img/gitlab-ce.png)

# Requirments

Installasi ini menggunakan sistem operasi CentOS 7:

- Fresh install CentOS 7 Server dengan IP Public ex: _`117.53.46.186`_
- Sudo User
- Domain yang mengarah ke IP Server (CentOS 7) ex: [_repo.iqbal.es_](https://repo.iqbal.es)
- RAM minimal 4GB

# Tahap Installasi

Login menggunakan SSH sebagai root user.

## Tambah Swap

Saat menggunakan GitLab CE 11.x pada server dengan RAM 4GB, diperlukan untuk menyiapkan partisi swap 4GB agar berjalan lancar.

```bash
dd if=/dev/zero of=/swapfile count=4096 bs=1M
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile   none    swap    sw    0   0' | tee -a /etc/fstab
free -m
```

_**Catatan**: Jika Anda menggunakan ukuran server yang berbeda, ukuran partisi swap dapat menyesuaikan._

Untuk tujuan kinerja sistem, disarankan untuk mengkonfigurasi pengaturan kernel swappiness ke nilai terendah, misal `10`:

```bash
echo 'vm.swappiness=10' | tee -a /etc/sysctl.conf
sudo sysctl -p
cat /proc/sys/vm/swappiness
```

_Output dari perintah cat adalah `10`._

## Setup Hostname dengan FQDN

Ubah hostname server dengan FQDN (ex : repo.iqbal.es) dengan perintah berikut:

```bash
hostnamectl set-hostname repo.iqbal.es
hostname -f
# Output //
repo.iqbal.es.
```

## Ubah Rule Firewall
```bash
yum install firewalld -y
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
systemctl restart firewalld
```

## Install Repository Epel dan Update system
```bash
yum install -y epel-release
yum -y update && shutdown -r now
```
Login kembali setelah server berjalan lagi.

### Install paket-paket yang dibutuhkan
Sebelum menginstall GitLab CE, install terlebih dahulu paket yang dibutuhkan.

```bash
yum install -y curl policycoreutils-python openssh-server openssh-clients
```

Jika ingin menggunakan postfix agar mengirimkan notifikasi email, silakan install postfix dan ubah rule dari firewlld:

```bash
yum install -y postfix
systemctl enable postfix
systemctl start postfix
firewall-cmd --permanent --add-service=smtp
firewall-cmd --permanent --add-service=pop3
firewall-cmd --permanent --add-service=imap
firewall-cmd --permanent --add-service=smtps
firewall-cmd --permanent --add-service=pop3s
firewall-cmd --permanent --add-service=imaps
systemctl restart firewalld
```
_**Note**: Setelah Postfix diinstal, Anda perlu mengkonfigurasi Postfix dengan mengedit file konfigurasi pada `/etc/postfix/main.cf` sesuai dengan pengaturan server Anda._

### Tambah GitLab Repository dan Install GitLab CE

Install Repository GitLab CE

```bash
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash
```
Selanjutnya, install GitLab CE

```bash
sudo EXTERNAL_URL="http://gitlab.example.com" yum install -y gitlab-ce
```
Ubah `http://gitlab.examle.com` menggunakan domain atau subdomain, misal `http://repo.iqbal.es`.

Installasi berjalan kurang lebih 5 sampai 10 menit.

Setelah installasi selesai, akses domain atau subdomain Anda dan login sebagai Administrator menggunakan :

- User : root
- Password : < password baru >

### Mengaktifkan SSL dengan Let's Encrypt

Edit file `/etc/gitlab/gitlab.rb`

```bash
vi /etc/gitlab/gitlab.rb
```

Cari baris berikut:

```bash
external_url 'http://gitlab.example.com' // subdomain Anda
# letsencrypt['enable'] = nil
# letsencrypt['contact_emails'] = [] # This should be an array of email addresses to add as contacts
# letsencrypt['group'] = 'root'
# letsencrypt['owner'] = 'root'
# letsencrypt['wwwroot'] = '/var/opt/gitlab/nginx/www'
# See http://docs.gitlab.com/omnibus/settings/ssl.html#automatic-renewal for more on these sesttings
# letsencrypt['auto_renew'] = true
# letsencrypt['auto_renew_hour'] = 0
# letsencrypt['auto_renew_minute'] = nil # Should be a number or cron expression, if specified.
# letsencrypt['auto_renew_day_of_month'] = "*/4"
```

Ubah menjadi seperti berikut:

```bash
external_url 'https://gitlab.example.com' // subdomain Anda
letsencrypt['enable'] = nil
letsencrypt['contact_emails'] = ['repository@gitlab.example.com'] # This should be an array of email addresses to add as contacts
letsencrypt['group'] = 'root'
letsencrypt['key_size'] = 2048
letsencrypt['owner'] = 'root'
letsencrypt['wwwroot'] = '/var/opt/gitlab/nginx/www'
# See http://docs.gitlab.com/omnibus/settings/ssl.html#automatic-renewal for more on these sesttings
letsencrypt['auto_renew'] = true
letsencrypt['auto_renew_hour'] = 0
letsencrypt['auto_renew_minute'] = nil # Should be a number or cron expression, if specified.
letsencrypt['auto_renew_day_of_month'] = "*/4"
```
Simpan dengan perintah `wq`.

Update konfigurasi GitLab dengan perintah berikut:

```bash
gitlab-ctl reconfigure
```

Setelah proses reconfigure selesai, semua pengguna akan otomatis menggunakan protocol HTTPS.

![https://repo.iqbal.es](/static/img/migrated/blog/img/gitlab-ce-site.png)

![Dashboard GitLab CE](/static/img/migrated/blog/img/gitlab-ce-dashboard.png)

Untuk installasi pada sistem operasi lain, silakan ikuti tautan berikut:

- [https://about.gitlab.com/install](https://about.gitlab.com/install)

- [https://vultr.com/docs/how-to-install-gitlab-community-edition-ce-11-x-on-centos-7](https://vultr.com/docs/how-to-install-gitlab-community-edition-ce-11-x-on-centos-7)_
