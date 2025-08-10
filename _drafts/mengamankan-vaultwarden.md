---
title: Mengamankan Vaultwarden
---

Setelah Vaultwarden berhasil di-install, langkah selanjutnya adalah memastikan layanan ini benar-benar aman. Walaupun Vaultwarden sudah punya sistem enkripsi bawaan, tetap saja kita perlu menambahkan lapisan perlindungan ekstra, supaya risiko serangan dari luar bisa ditekan semaksimal mungkin.

Di sini kita akan bahas dua hal penting:

1. Mengamankan Vaultwarden dengan Cloudflare
2. Menyetel firewall di server

### 1. Mengamankan Vaultwarden dengan Cloudflare

Cloudflare bisa menjadi “tameng” tambahan untuk server kamu. Dengan Cloudflare, semua traffic akan melewati jaringan mereka terlebih dahulu sebelum sampai ke server, sehingga IP asli server tidak mudah terdeteksi dan kamu mendapat proteksi tambahan seperti DDoS protection.

Langkah-langkah:
1. Tambahkan domain ke Cloudflare
	
	Login ke Cloudflare, lalu tambahkan domain yang akan digunakan untuk Vaultwarden (misalnya vault.domainkamu.com).

2. Ubah DNS
	
	Di menu DNS Cloudflare, buat record A atau CNAME yang mengarah ke IP publik server kamu. Pastikan ikon awan oranye aktif, artinya traffic akan melewati Cloudflare.
			
3. Aktifkan SSL/TLS
	
	Di menu SSL/TLS, pilih mode Full atau Full (Strict) agar koneksi dari Cloudflare ke server tetap aman. Pastikan Nginx di server sudah memiliki sertifikat SSL dari Let’s Encrypt atau sumber lain.
		 
4. Aktifkan proteksi tambahan
	
	Gunakan fitur Rate Limiting atau WAF (Web Application Firewall) di Cloudflare untuk memblokir request mencurigakan.

***

### 2. Setting Firewall pada Server Vaultwarden

Firewall adalah “pagar” pertama server kamu. Kita bisa menggunakan UFW (Uncomplicated Firewall) di Ubuntu untuk membatasi akses.

Cek status UFW:
```bash
sudo ufw status
```

Izinkan port penting saja:
```bash
# Akses SSH
sudo ufw allow 22/tcp

# Akses HTTP dan HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

Aktifkan UFW:
```bash
sudo ufw enable
```

***

### 3. Backup Data Vaultwarden

Backup itu ibarat asuransi — semoga tidak pernah terpakai, tapi akan sangat menyelamatkan kalau terjadi masalah. Di Vaultwarden, semua data disimpan di folder /data (sesuai pengaturan di docker-compose.yml tadi). Jadi kita cukup backup folder ini secara rutin.

**Backup Manual:**

Kalau ingin backup manual ke file .tar.gz:
```bash
# Masuk ke folder Vaultwarden
cd ~/vaultwarden

# Stop container agar data konsisten
docker-compose down

# Backup folder data
tar -czvf vaultwarden-backup-$(date +%F).tar.gz data/

# Start lagi container
docker-compose up -d

```

**Backup Otomatis ke Google Drive (Opsional):**

Kalau mau backup otomatis, kita bisa pakai rclone:
1. Install rclone:
	
	```bash
	sudo apt install -y rclone
	```
	
2. Konfigurasi Google Drive:
	
	```bash
	rclone config
	```
	Ikuti wizard untuk membuat koneksi ke Google Drive.
	
3. Buat script backup:
	
	```bash
	vim ~/backup-vaultwarden.sh
	```
	
	Isi
	```bash
	#!/bin/bash
 BACKUP_FILE="vaultwarden-backup-$(date +%F).tar.gz"
 cd ~/vaultwarden
 docker-compose down
 tar -czvf $BACKUP_FILE data/
 docker-compose up -d
 rclone copy $BACKUP_FILE gdrive:/VaultwardenBackup/
 rm $BACKUP_FILE
 
	```
			
7. Jadwalkan di cron:

	```bash
	crontab -e
	```
	
	Tambahkan:
	```bash
	0 2 * * * /bin/bash /home/username/backup-vaultwarden.sh
	```

Dengan begitu, setiap jam 2 pagi backup akan otomatis dibuat dan dikirim ke Google Drive.

***

💡 Tips ekstra keamanan:

* Gunakan master password yang panjang dan unik.
* Aktifkan Two-Factor Authentication (2FA) di akun Vaultwarden kamu.
* Rajin update Docker dan Vaultwarden ke versi terbaru.
