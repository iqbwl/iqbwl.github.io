---
title: Installasi WordPress dengan Nginx sebagai Load Balancer
layout: archive
author: iqbwl
---
Sebelumnya saya mencoba untuk membuat web wordpress menggunakan topologi load balancer, kira-kira topologinya seperti gambar berikut.

![Topologi](/static/img/wordpress.svg)


| **Name** | **Service** | **IP Address** |  **OS Type** |
|:--------:|:-----------:|:--------------:|:------------:|
|    LB    |    Nginx    |   192.168.7.1  | Ubuntu 20.04 |
|    DB    |   MariaDB   |   192.168.7.5  | Ubuntu 20.04 |
|  Web 01  |    Nginx    |   192.168.7.6  | Ubuntu 20.04 |
|  Web 02  |    Nginx    |   192.168.7.7  | Ubuntu 20.04 |
|    NFS   |     NFS     |   192.168.7.8  | Ubuntu 20.04 |

## Silakan disimak langkah-langkah installasi-nya.

### Install service yang dibutuhkan.

###### Install nginx pada server LB
   ```bash
   apt update -y
   apt install nginx -y
   ```
  
###### Install nginx, php dan nfs client pada server Web01 dan Web02. 
   ```bash
   apt update -y
   apt install nginx -y
   apt install php php-imagick php-fpm php-mbstring php-bcmath php-xml php-mysql php-common php-gd php-json php-cli php-curl php-zip -y
   systemctl disable apache2
   apt install nfs-common -y
   ```
  
###### Install MySQL atau MariaDB pada server DB.
  
   ```bash
   apt update -y
   apt install mariadb -y
   ```
   
###### Install nfs server pada server NFS.
   ```bash
   apt update -y
   apt install nfs-kernel-server
   ```
   
### Konfigurasi
###### Pertama kita konfigurasi dulu untuk NFS nya.
   Pada server NFS, buat directory untuk meletakan file wordpress.
   ```bash
   mkdir data
   cd data
   wget https://wordpress.org/latest.tar.gz
   apt install unzip -y
   unzip latest.zip
   chown -R nobody:nogroup wordpress/
   ```
    
   Setup NFS sharing dengan cara ubah file `/etc/exports`, dan masukan file baris konfigurasi berikut:
   ```bash
   /root/data/wordpress 192.168.7.6(rw,sync,no_root_squash,no_subtree_check)
   /root/data/wordpress 192.168.7.7(rw,sync,no_root_squash,no_subtree_check)
   ```
   `Ganti ip address diatas dengan ip address kalian`
    
   Restart service nfs server
   ```bash
   systemctl restart nfs-kernel-server
   ```
    
###### Kedua kita konfigurasi Web01 dan Web02

   Mount nfs server pada kedua VM Web.
   ```bash
   mkdir -p /var/www/wordpress
   mount 192.168.7.8:/root/data/wordpress /var/www/wordpress
   ```

   Cek dengan `df -Th` untuk melihat apakah sudah berhasil di mount dengan benar.

   Masukan baris berikut pada `/etc/fstab` agar mounting otomatis apabila server mengalami restart.
   ```bash
   192.168.7.8:/root/data/wordpress /var/www/wordpress nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
   ```

   Ubah owner dan permission dari docroot wordpress.
   ```bash
   chown -R www-data:www-data /var/www/wordpress
   cd /var/www/wordpress
   find . -type d -exec chmod 755 {} \;
   find . -type f -exec chmod 644 {} \;
   ```

   Buat konfigurasi nginx pada /etc/nginx/conf.d/wordpress.conf
   ```bash
   vim /etc/nginx/conf.d/wordpress.conf
   ```

   Masukan konfigurasi berikut dan sesuaikan.
   ```bash
   server {
    listen 80;
    server_name domain.com;
    root /var/www/wordpress/;
    index index.php index.html index.htm index.nginx-debian.html;

    location / {
     try_files $uri $uri/ /index.php;
    }

    location ~ ^/wp-json/ {
     rewrite ^/wp-json/(.*?)$ /?rest_route=/$1 last;
    }

    location ~* /wp-sitemap.*\.xml {
     try_files $uri $uri/ /index.php$is_args$args;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;

    client_max_body_size 20M;

    location = /50x.html {
     root /usr/share/nginx/html;
    }

    location ~ \.php$ {
     fastcgi_pass unix:/run/php/php7.4-fpm.sock;
     fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
     include fastcgi_params;
     include snippets/fastcgi-php.conf;
    }

    gzip on;
    gzip_vary on;
    gzip_min_length 1000;
    gzip_comp_level 5;
    gzip_types application/json text/css application/x-javascript application/javascript image/svg+xml;
    gzip_proxied any;

    location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
       access_log        off;
       log_not_found     off;
       expires           360d;
    }

    location ~ /\.ht {
      access_log off;
      log_not_found off;
      deny all;
    }

    access_log /var/log/nginx/wp-access.log combined;
    error_log /var/log/nginx/wp-error.log;
   }
   ```

   Cek konfigurasi nginx
   ```bash
   root@web01:~# nginx -t
   nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
   nginx: configuration file /etc/nginx/nginx.conf test is successful
   ```

   Start nginx dan php-fpm
   ```bash
   systemctl restart nginx
   systemctl restart php7.4-fpm
   systemctl enable nginx
   systemctl enable php7.4-fpm
   ```

   Selesai untuk Web01 dan Web02

###### Ketiga konfigurasi Database

   Masuk ke console mysql dan create database serta grant user.
   ```bash
   systemctl start mariadb
   ```

   ```bash
   mysql
   MariaDB [(none)]> create database wp_lb;
   MariaDB [(none)]> CREATE USER 'wp_user_lb'@'192.168.7.6' IDENTIFIED BY 'Password12345@@@@';
   MariaDB [(none)]> CREATE USER 'wp_user_lb'@'192.168.7.7' IDENTIFIED BY 'Password12345@@@@';
   MariaDB [(none)]> GRANT ALL ON wp_lb.* to 'wp_user_lb'@'192.168.7.6';
   MariaDB [(none)]> GRANT ALL ON wp_lb.* to 'wp_user_lb'@'192.168.7.7';
   MariaDB [(none)]> flush privileges;
   MariaDB [(none)]> quit;
   ```

###### Keempat konfigurasi nginx Load balancer

   Buat konfigurasi `/etc/nginx/conf.d/wordpress.conf`.
   ```bash
   vim /etc/nginx/conf.d/wordpress.conf
   ```

   Masukan konfigurasi berikut:
   ```bash
   upstream wp_backend {
     least_conn;
     server 192.168.7.6:80;
     server 192.168.7.7:80;
   }

   server {
    listen 80;
    server_name domain.com;

    location / {
     proxy_pass http://wp_backend;
     proxy_set_header X-Real-IP  $remote_addr;
     proxy_set_header X-Forwarded-For $remote_addr;
     proxy_set_header Host $host;
    }

    access_log /var/log/nginx/wp-access.log combined;
    error_log /var/log/nginx/wp-error.log;
   }
   ```

   Cek konfigurasi menggunakan `nginx -t`, jika sudah silakan start nginx.
   ```bash
   nginx -t
   systemctl restart nginx
   ```

### Konfigurasi WordPress

Setelah semuanya selesai, silakan akses wordpress melalui browser dan konfigurasi mulai dari input database sampai konfigurasi user-nya.

Selesai..
