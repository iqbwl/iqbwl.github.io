---
title: Cara Install Vaultwarden
date: '2025-08-09 21:32:25'
categories:
- ''
- vaultwarden
---

Kalau di tulisanku sebelumnya aku sudah membahas apa itu Vaultwarden dan kenapa penting menggunakan password manager, sekarang saatnya masuk ke bagian yang paling seru, menginstall Vaultwarden di server sendiri atau vps.  

Disini aku menggunakan VPS dengan spesifikasi **1 vCPU, 1GB RAM, 20GB SSD dan OS Debian 12**, aku akan pakai Docker Compose supaya prosesnya cepat, rapi, dan gampang di-maintain. Lalu aku juga akan setup Nginx sebagai reverse proxy.

***

### 1. Install Vaultwarden dengan Docker Compose

**Persiapan:**

Sebelum mulai, pastikan server kamu sudah terpasang:
* Docker
* Docker Compose
* Akses SSH ke server

Kalau belum punya Docker, kamu bisa install dengan perintah berikut:
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

Kalau kamu pakai distro lain, bisa cek dokumentasi resmi docker ya: [docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

Buat network untuk Vaultwarden
```bash
docker network create vaultwarden-network
```

Buat folder untuk Vaultwarden:
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
      # DOMAIN: "https://vaultwarden.example.com"  # ganti dengan nama domain yang akan kamu inginkan saat menggunakan Nginx reverse proxy
      SIGNUPS_ALLOWED: "true" # ubah jadi "false" kalau kamu sudah selesai setup user Vaultwarden
    volumes:
      - ./vw-data:/data # kamu bisa ganti "vw-data" dengan nama folder yang kamu mau
    ports:
      - 8080:80

    networks:
      - vaultwarden-network # pakai network yang sudah dibuat

networks:
  vaultwarden-network:
    external: true
```

Jalankan Vaultwarden:
```bash
docker compose up -d
```

Kalau sudah, Vaultwarden akan bisa diakses lewat `http://IP_SERVER:8080`. Nanti kita akan arahkan domain kamu ke sini melalui Nginx.

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
        proxy_pass http://127.0.0.1:8080;
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

Pasang SSL dengan Certbot (opsional tapi disarankan):
```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d vault.domainkamu.com
```

Sekarang Vaultwarden kamu sudah bisa diakses aman melalui HTTPS. 🚀
