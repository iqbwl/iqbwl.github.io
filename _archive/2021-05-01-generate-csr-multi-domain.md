---
title: Generate CSR Multi-Domain
layout: archive
author: iqbwl
---
#### Contoh

Contoh domain yang akan digunakan:

> - `*.iqbal.page`
> - www.iqbal.id
> - secure.iqbal.id

#### Proses

Salin konfigurasi openssl

```bash
cp /etc/ssl/openssl.cnf /var/www/certs/iqbal.page.cnf
```

Buka file `iqbal.page.cnf`, cari baris dibawah ini lalu uncomment

```bash
req_extensions = v3_req
```

Setelahnya tambahkan beberapa konfigurasi berikut dibawah baris `[ v3_req ]`

```bash
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = www.iqbal.id
DNS.2 = secure.iqbal.id
```

Selesai.

#### Generate

Masih didalam directory `certs`, lakukan generate privkey.

```bash
openssl genrsa -out iqbal.page.key 2048
```

Kemudian generate CSR dengan perintah berikut:

```bash
openssl req -new -key iqbal.page.key -out iqbal.page.csr -config iqbal.page.cnf
```

> option `-config` harus ditambahkan, jika tidak maka CSR hanya berlaku untuk 1 common name.
> pada kolom common name saat generate, masukan domain utama, contoh: `*.iqbal.page`

![generate csr](/static/img/migrated/blog/img/csr-generate.png)

Verify CSR

```bash
openssl req -in iqbal.page.csr -noout -text
```

Hasilnya sebagi berikut:

![csr check](/static/img/migrated/blog/img/csr-preview.png)
