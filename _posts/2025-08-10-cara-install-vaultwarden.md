---
title: Cara Install Vaultwarden
layout: post
author: iqbwl
date: '2025-08-10 19:19:00 +0700'
categories:
- vaultwarden
---

Sebelumnya aku sudah membahas apa itu Vaultwarden dan kenapa penting menggunakan password manager, sekarang saatnya bahas install Vaultwarden di server sendiri atau vps.  

Disini aku menggunakan vps dengan spesifikasi **1 vCPU, 1GB RAM, 20GB SSD dan OS Debian 12**, aku akan pakai Docker Compose supaya prosesnya cepat, rapi, dan gampang di-maintain. Lalu aku juga akan setup Nginx sebagai reverse proxy.

![Trying to install Vaultwarden](/static/static/img/vaultwarden/trying-to-install-vw.png "Trying to install Vaultwarden")

***

### 1. Install Vaultwarden dengan Docker Compose

**Persiapan:**

Beberapa hal yang perlu disiapkan:
* Docker
* Docker Compose
* Nginx
* Akses SSH ke server

Kalau belum punya Docker, bisa install dengan perintah berikut:
```bash
# Tambah Docker official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Tambah repository docker:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker dan docker compose
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Tambahkan user ke groups docker
sudo usermod -aG docker $USER
```

Kalau pakai OS lain, bisa cek dokumentasi resmi docker: [docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

Buat dulu network untuk Vaultwarden
```bash
docker network create vaultwarden-network
```

Buat directory untuk Vaultwarden:
```bash
mkdir -p data/vaultwarden && cd data/vaultwarden/
```

Buat file `docker-compose.yml`:

```yaml
services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: always
    environment:
      DOMAIN: "https://vaultwarden.example.com"  # ganti dengan nama domain yang akan digunakan saat menggunakan Nginx reverse proxy
      SIGNUPS_ALLOWED: "true" # ubah jadi "false" kalau sudah selesai setup user Vaultwarden
    volumes:
      - ./vw-data:/data # bisa ganti "vw-data" dengan nama yang berbeda

    networks:
      - vaultwarden-network # pakai network yang sudah dibuat

networks:
  vaultwarden-network:
    external: true
```

> directory **vw-data** ini nantinya akan otomatis dibuat dan akan berisi data-data Vaultwarden, kalau mau migrasi ke server baru jangan lupa bawa directory ini dan juga file `docker-compose.yml` supaya tinggal jalankan docker compose di server baru.

Jalankan Vaultwarden:
```bash
docker compose up -d
```

![Start Vaultwarden using Docker Compose](/static/static/img/vaultwarden/docker-compose-up.png "Start Vaultwarden using Docker Compose")

Sebelum menggunakan nginx, kita memerlukan ip private dari container Vaultwarden.

Cek IP Private container pakai command ini:
{% raw %}
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name>
```
{% endraw %}

Simpan IP Private Vaultwarden.

***

### 2. Setup Nginx untuk Vaultwarden

Kita akan membuat Nginx jadi reverse proxy, supaya Vaultwarden bisa diakses lewat domain (misalnya `https://vault.domainkamu.com`) dan juga aman pakai SSL.

Install Nginx:
```bash
sudo apt install -y nginx
```

Buat konfigurasi Nginx baru:
```bash
sudo vim /etc/nginx/sites-available/vaultwarden.conf
```

Masukan konfigurasi berikut:
```nginx
server {
    listen 80;
    server_name vault.domainkamu.com;

    location / {
        proxy_pass http://127.0.0.1:80; # Ganti ke IP Private container Vaultwarden
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

```

Aktifkan konfigurasi:
```bash
sudo ln -s /etc/nginx/sites-available/vaultwarden.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

Pasang SSL dengan Certbot:
```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d vault.domainkamu.com
```

![Vaultwarden Login](/static/static/img/vaultwarden/vaultwarden-login.png "Vaultwarden")

Sekarang Vaultwarden sudah bisa diakses aman melalui HTTPS. 🚀
