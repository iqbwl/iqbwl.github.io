---
title: Membuat Blog dengan Framework Hexo di GitHub
layout: archive
author: iqbwl
---
Hexo adalah framework blog sederhana tapi powerful yang didukung oleh Node.js. Web statis generator ini super cepat dan hanya membutuhkan waktu beberapa detik untuk membangun website yang lengkap.

![Hexo.io](/migrated/blog/img/hexo.png)

Hexo mendukung semua fitur GitHub-flavored Markdown dan sebagian besar plugin Octopress. Salah satu keuntungan utama dari Hexo adalah memungkinkan Anda untuk mentransfer blog atau situs ke web host dengan satu perintah.

Pastikan kamu sudah Install Git.

```bash
sudo apt install git-core
```

Jika sudah terinstall Git dan NodeJS, sekarang kita install Hexo dengan perintah berikut.

```bash
npm install -g hexo-cli
```

Setelah Hexo terinstal , jalankan perintah berikut untuk menginisialisasi Hexo di target

```bash
hexo init <folder>
cd <folder>
npm install
```

Setelah menjalankan perintah diatas, maka folder tadi akan terlihat seperti ini.

```bash
.
├── _config.yml
├── package.json
├── scaffolds
├── source
|   ├── _drafts
|   └── _posts
└── themes
```
Edit file configurasi di `_config.yml`

Di dalam file `_config.yml` kamu harus menghubungkan ke repository git kamu agar mudah di deploy oleh Hexo.

Pertama, install terlebih dahulu Plugin `hexo-deployer-plugin`.
```bash
npm install hexo-deployer-git --save
```

Lalu masukan configurasi berikut kedalam file `_config.yml`

```bash
deploy:
  type: git
  repo: <repository url>
  branch: [branch]
  message: [message]
```

Untuk membuat artikel.

```bash
hexo new post <title>
```

Generate terlebih dahulu website Hexo-nya.

```bash
hexo generate
```

Lalu deploy ke github.

```bash
hexo deploy
```

Atau bisa juga menjalankan di server lokal kita dengan perintah berikut.

```bash
hexo server
```
Lalu buka `http://localhost:4000`.

Selesai, selamat mencoba dan semoga bermanfaat.

Sumber :
- [Hexo.io](https://hexo.io)
