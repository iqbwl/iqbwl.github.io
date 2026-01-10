---
title: Setup Custom Email gratis dengan Zoho Mail
layout: archive
author: iqbwl
---
Zoho Mail sebagai salah satu produk Zoho, merupakan layanan mail hosting pihak ketiga. Zoho menawarkan layanan email gratis hingga 5 user untuk tiap domain yang Anda daftarkan.

![Logo Zoho | sumber: zoho.com](/migrated/blog/img/zoho/zoho-logo.png)

Zoho adalah salah satu aplikasi online yang menyediakan berbagai fasilitas untuk kebutuhan bisnis sehari-hari. Aplikasinya beragam mulai dari aplikasi untuk kebutuhan sales & marketing, finance hingga email. Zoho juga menyediakan tools untuk menunjang produktivitas kerja seperti document creator, spreadsheet, tools presentasi bahkan hingga mencakup sosial media management.

Selengkapnya dapat Anda lihat pada laman resminya: https://www.zoho.com/workplace/

Berikut ini langkah-langkah untuk setup akun email gratis dengan custom domain di Zoho.

## Daftar Akun Zoho

1. Pertama masuk ke laman berikut: https://www.zoho.com/mail/
 - Klik **Sign Up**
 - Kemudian klik **Get Started** pada **FREE PLAN**
2. Masukan nama domain-nya (_misal: kwt.web.id_) >> klik **Add**
![Gambar 1: Masukan nama domain](/migrated/blog/img/zoho/zoho-1.png)
3. Lengkapi data-data yang diperlukan dan centang (_I agree to the Terms of Service and Privacy Policy._) kemudian klik **PROCEED**
![Gambar 2: Lengkapi data-data yang diperlukan](/migrated/blog/img/zoho/zoho-2.png)
4. Klik **Sign Up** kembali
![Gambar 3: Konfirmasi data-data](/migrated/blog/img/zoho/zoho-3.png)
5. Anda akan disuruh untuk memverifikasi akun dengan memasukan kode yang telah dikirimkan ke nomor ponsel yang Anda inputkan sebelumnya. Kemudian klik **VERIFIKASI TELEPON SELULAR**
![Gambar 4: Verifikasi telepon selular](/migrated/blog/img/zoho/zoho-4.png)
6. Selanjutnya, Anda akan disuruh untuk mengaktifkan Autentikasi Dua Faktor, Anda bisa men-skip tahap ini _terlebih dahulu_ dengan klik _**Ingatkan saya nanti**_ atau Anda dapat mengaktifkannya untuk keamanan akun.
![Gambar 5: Aktifkan autentikasi dua faktor](/migrated/blog/img/zoho/zoho-5.png)

## Domain Setup

1. Verifikasi Domain.
 - Pilih DNS manager: **Others**
 - Pilih verifikasi menggunakan CNAME atau dapat menggunakan metode Upload Files.
 ![Gambar 6: Pilih verifikasi menggunakan CNAME](/migrated/blog/img/zoho/zoho-6.png)
 - Kemudian tambahkan CNAME tersebut pada DNS management domain Anda.
 - Penambahan record DNS pada domain akan membuat domain mengalami propagasi dan proses propagasi biasa memakan waktu 48 Jam tergantung ISP yang Anda gunakan.
 - Apabila CNAME telah ditambahkan, klik **Proceed to CNAME Verification**
 ![Gambar 7: CNAME sudah ditambahkan](/migrated/blog/img/zoho/zoho-7.png)
 - Kemudian klik **Verify Now**
 ![Gambar 8: Verify Now](/migrated/blog/img/zoho/zoho-8.png)
 - Kemudian klik **Create Account** (isi sama seperti di step 3 saat mendaftarkan akun)
 ![Gambar 9: Create Administrator Account ](/migrated/blog/img/zoho/zoho-9.png)

2. Add User
 - Klik **Proceed to Add Users**
 ![Gambar 10: Add User](/migrated/blog/img/zoho/zoho-10.png)
 - Tambahkan user atau bisa di skip untuk melanjutkan prosesnya.
 ![Gambar 11: Tambah user](/migrated/blog/img/zoho/zoho-11.png)
 - User sudah ditambahkan, kemudian klik **Back to Setup**
 ![Gambar 12: User sudah ditambahkan](/migrated/blog/img/zoho/zoho-12.png)

3. Create Groups
 - Anda dapat melewati tahap ini jika tidak diperlukan group untuk distribution list atau dapat Anda lanjutkan dengan klik **Proceed to Create Groups**.
 ![Gambar 13: Create Groups 1](/migrated/blog/img/zoho/zoho-13.png)
 - Klik **Back to Setup** untuk kembali ke **Domain Setup**, atau klik **Add Group** untuk membuat group.
 ![Gambar 14: Create Groups 2](/migrated/blog/img/zoho/zoho-14.png)

4. Configure Email Delivery
 - Kemudian tambahkan mx record yang tertera pada gambar 15 ke DNS management domain
 ![Gambar 15: Tambahkan MX record pada DNS management](/migrated/blog/img/zoho/zoho-15.png)
 - Apabila MX record sudah ditambahkan, cek dengan menekan tombol **MX Lookup**
 ![Gambar 17: MX record sudah ditambahkan](/migrated/blog/img/zoho/zoho-17.png)
 - Kemudian klik **OK** lalu klik **Next**
 ![Gambar 16: MX record sudah ditambahkan](/migrated/blog/img/zoho/zoho-16.png)

5. SPF/DKIM
 - Tambahkan SPF record pada DNS management domain
 ![Gambar 18: ](/migrated/blog/img/zoho/zoho-18.png)
 - Klik Procees to Configure DKIM untuk konfigurasi DKIM
 ![Gambar 19: DKIM](/migrated/blog/img/zoho/zoho-19.png)
 - Klik tombol edit untuk mengaktifkan DKIM
 ![Gambar 20: Edit DKIM](/migrated/blog/img/zoho/zoho-20.png)
 - Kemudian klik **Add Selector**
 ![Gambar 21: Add Selector](/migrated/blog/img/zoho/zoho-21.png)
 - Masukan nama Selector kemudian klik **Save**
 ![Gambar 22: Simpan perubahan](/migrated/blog/img/zoho/zoho-22.png)
 - Tambahkan record TXT yang dihasilkan pada DNS management domain kemudian klik **Verify**
 ![Gambar 23: Tambah record DKIM](/migrated/blog/img/zoho/zoho-23.png)
 - Pastikan record SPF dan DKIM sudah resolve pada domain
 ![Gambar 24: SPF dan DKIM sudah resolve](/migrated/blog/img/zoho/zoho-24.png)
 - Klik **Back to Setup**

6. Email Migration dan Mobile Acces
 - Tahap ini dapat di skip

## Test Pengiriman Email

1. Test Kirim email ke email lain
 - Masuk ke https://mail.zoho.com/zm/
 - Klik New Mail
 - Masukan email tujuan, subjek, isi email kemudian **Send**
 ![Gambar 25: Test kirim email](/migrated/blog/img/zoho/zoho-25.png)
 - Kemudian periksa pada kotak masuk email tujuan
 ![Gambar 26: Email sudah masuk](/migrated/blog/img/zoho/zoho-26.png)
 - SPF dan DKIM bekerja
 ![Gambar 27: SPF dan DKIM bekerja](/migrated/blog/img/zoho/zoho-27.png)

2. Test menerima email
 ![Gambar 28: berhasil menerima email](/migrated/blog/img/zoho/zoho-28.png)

Selesai dan email siap digunakan..

***

Informasi tambahan:

- CNAME record : Canonical Name digunakan sebagai alias
- MX record : Record untuk pertukaran email (mail exchange). Fungsinya adalah untuk mengarahkan pengirim email dari luar ke mail server
- TXT record: Record untuk data acak, biasanya digunakan untuk record SPF dan DKIM
- SPF record (Sender Policy Framework): Menentukan server dan alamat IP yang berwenang untuk mengirim email dari domain anda. Fitur ini bekerja untuk mencegah email spam keluar.
- DKIM record (DomainKeys Identified Mail): Merupakan sarana verifikasi email yang masuk. Hal ini memastikan bahwa email yang masuk tidak dimodifikasi dari pengirim. Fitur ini bekerja untuk mencegah pesan spam yang masuk.
