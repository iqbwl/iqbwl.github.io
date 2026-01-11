---
title: Membuat Repository Git
layout: archive
author: iqbwl
---
Pertama-tama kita perlu buat akun github atau gitlab, jika mempunyai server git sendiri itu bagus.

Silakan daftar akun github/gitlab pada link dibawah ini.

- [GitHub](https://github.com/join)
- [GitLab](https://gitlab.com/users/sign_up)

Setelah punya akun github/gitlab, siapkan repository di akun github/gitlab masing-masing.

Install git pada sistem operasi masing-masing, disini saya pakai linux dengan distro ubuntu.

Untuk install git, gunakan perintah berikut:

```bash
apt install git
```

Untuk cek versi, gunakan perintah berikut:

```bash
git --version
```

Setelah installasi dilakukan, lakukan konfigurasi awal dengan perintah berikut:

```bash
git config --global user.name "Lime"
git config --global user.email "limegit@gmail.com"
```

Buat directory dimana repositorymu akan diletakan.

```bash
mkdir test-git
cd test-git
```

Lakukan remote ke repository di github/gitlab, berikut perintahnya:

```bash
git init
git remote add <nama-remote> <url-remote>
```
`<nama-remote>` merupakan nama dari repository, sedangkan `<url-remote>` merupakan url dari repository github/gitlab.

Sebagai contoh:

```bash
git remote add gitlab https://gitlab.com/limegit/jeruk.git
```

Ketikan perintah `git remote -v` untuk melihat repository mana saja yang diremote:

```bash
root@node:~/git-test/jeruk# git remote -v
gitlab  https://gitlab.com/limegit/jeruk.git (fetch)
gitlab  https://gitlab.com/limegit/jeruk.git (push)
```

Buat 1 file sebagai untuk test push dari lokal ke github/gitlab:

```bash
touch README.md
git add README.md
git commit -m "add readme"
```

Perintah commit disini berfungsi untuk memberikan pesan/catatan perubahan apa saja yang telah dilakukan.

Langkah terakhir adalah push ke repository:

```bash
git push -u gitlab master
```

Kemudian akan muncul form untuk memasukan credential, karena sebelumnya remote yang digunakan adalah https sehingga memerlukan authentikasi.

Apabila sudah selesai push, cek pada laman repository github/gitlab. Sebagai contoh file yang sudah di*push* ada pada gambar dibawah ini.

![File Repository](/static/img/migrated/blog/img/github_sample_repo-1.png)

Selesai, semoga bermanfaat.

> Sc: archive [lime.web.id](http://lime.web.id)
