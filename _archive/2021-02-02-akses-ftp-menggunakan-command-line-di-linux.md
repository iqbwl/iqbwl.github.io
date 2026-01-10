---
title: Akses FTP Menggunakan Command Line di Linux
layout: archive
author: iqbwl
---
Gunakan perintah `ftp` jika tidak pakai ssl atau `ftp-ssl` jika pakai ssl, seperti berikut:

```bash
ftp-ssl
```
Hasil:

```bash
root@new:~# ftp-ssl
ftp> 
```

Konek ke ftp server dengan perintah `open <hostname>` lalu masukan user dan password, contoh:

```bash
ftp> open hostname.domain.com
Connected to hostname.domain.com.
220 ProFTPD Server (ProFTPD) [123.123.123.123]
Name (hostname.domain.com:root): kuro
234 AUTH TLS successful
[SSL Cipher TLS_AES_256_GCM_SHA384]
200 PBSZ 0 successful
200 Protection set to Private
[Encrypted data transfer.]
331 Password required for kuro
Password:
230 User kuro logged in
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> 
```

Untuk perintah-perintah nya dibawah ini:

| Command | Details |
| -------- | -------- |
| help or ? | list semua perintah yang tersedia |
| cd | pindah directory |
| lcd | pindah directory di local |
| ls | untuk list file di server ftp |
| mkdir | membuat directory di server ftp |
| pwd | menunjukan path saat ini |
| delete | hapus file di server ftp |
| rmdir | hapus directory di server ftp |
| get | download file dari server ftp ke local |
| mget | download beberapa file dari server ftp ke local |
| put | upload file dari local ke server ftp |
| mput | upload beberapa file dari local ke server ftp |
| quit | untuk keluar dari server ftp |

Semoga bermanfaat.

> Sc: archive [kuro.zone](http://kuro.zone)
