---
title: Generate SSL Let's Encrypt di CentOS 7
layout: archive
author: iqbwl
---
![Let's Encrypt https://seeklogo.com](/static/img/migrated/blog/img/ssl-letsencrypt.png)

Install terlebih dahulu repository `epel-release`

```bash
# yum install epel-release -y
```

Cloning source Let's Encrypt dari github:

```bash
 # yum install git
 # git clone https://github.com/letsencrypt/letsencrypt
 # cd letsencrypt
```

Berikut command untuk generate SSL Let's Encrypt:

```bash
 # ./letsencrypt-auto certonly --standalone --email -d -d www.
```

Sebagai contoh:

```bash
 # ./letsencrypt-auto certonly --standalone --email kontak@iqbalbirrul.com -d ssl.iqbal.es
```

Sebagai catatan : domain harus terpointing ke IP Address server tempat SSL Let's Encrypt di generate

Berikut outputnya:

```bash
[root@cloudsrv1 letsencrypt]# ./letsencrypt-auto certonly --standalone --email kontak@iqbalbirrul.com -d ssl.iqbal.es
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator standalone, Installer None
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for ssl.iqbal.es
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/ssl.iqbal.es/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/ssl.iqbal.es/privkey.pem
   Your cert will expire on 2019-05-15. To obtain a new or tweaked
   version of this certificate in the future, simply run
   letsencrypt-auto again. To non-interactively renew *all* of your
   certificates, run "letsencrypt-auto renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le

```

Note : Perhatikan juga target folder hasil generate ssl (/etc/letsencrypt/live/ssl.iqbal.es/fullchain.pem)

Semoga bermanfaat...
