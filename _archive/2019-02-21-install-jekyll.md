---
title: Install Jekyll
layout: archive
author: iqbwl
---
Jekyll adalah generator situs web statis sederhana, yang diperuntukan untuk situs pribadi, proyek, atau organisasi.

Jekyll ditulis dalam bahasa pemrograman `Ruby` oleh **Tom Preston-Werner**, co-founder GitHub, dan didistribusikan di bawah lisensi [sumber terbuka](https://id.wikipedia.org/wiki/Sumber_terbuka).

![Jekyll](/static/img/migrated/blog/img/jekyll-logo.png)

# Installasi Jekyll
Jekyll dapat diinstal pada sistem operasi macOS, Ubuntu, [Distro Linux Lain](https://jekyllrb.com/docs/installation/other-linux), Windows.

Pada tulisan ini, installasi menggunakan sistem operasi Ubuntu 18.04 LTS

## Requirments
- [Ruby](https://www.ruby-lang.org/en/downloads/) version `2.2.5` or above, including all development headers (ruby version can be checked by running `ruby -v`)
- [RubyGems](https://rubygems.org/pages/download) (which you can check by running `gem -v`)
- [GCC](https://gcc.gnu.org/install/) and [Make](https://www.gnu.org/software/make/) (in case your system doesn’t have them installed, which you can check by running `gcc -v`,`g++ -v` and `make -v` in your system’s command line interface)
- Translate sendiri lah

## Installasi di Ubuntu 18.04 LTS

Sebelum Jekyll di install, terlebih dahulu install paket yang dibutuhkan

```bash
$ sudo apt update
$ sudo apt install ruby-full build-essential zlib1g-dev
```

Usahakan tidak menggunakan root saat install `Ruby Gems`. Oleh karena itu, buat directory installasi `gem` untuk user Anda.

Tambahkan beberapa konfigurasi pada file `./bashrc` dengan perintah berikut:

```bash
$ echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
$ echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
$ echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
$ source ~/.bashrc
```

Selanjutnya, install jekyll dengan perintah berikut:

```bash
$ gem install jekyll bundler
```

Sekarang Jekyll siap digunakan.

## Buat Blog dengan Jekyll

Siapkan directory untuk Jekyll

```bash
$ mkdir Jekyll
$ cd Jekyll
```

Kemudian buat Jekyll Site.

```bash
~/Jekyll$ jekyll new iqbal-jekyll
~/Jekyll$ cd iqbal-jekyll
```

Jalankan Jekyllnya

```bash
~/Jekyll/iqbal-jekyll$ bundle exec jekyll serve
Configuration file: /home/iqbal/Jekyll/iqbal-jekyll/_config.yml
            Source: /home/iqbal/Jekyll/iqbal-jekyll
       Destination: /home/iqbal/Jekyll/iqbal-jekyll/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
       Jekyll Feed: Generating feed for posts
                    done in 0.424 seconds.
 Auto-regeneration: enabled for '/home/iqbal/Jekyll/iqbal-jekyll'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

Akses jekyll dengan alamat [_http://localhost:4000/_](http://localhost:4000/)

![Localhost Jekyll](/static/img/migrated/blog/img/jekyll-localhost.png)

### Konfigurasi Jekyll

Untuk configurasi Jekyll sendiri berada pada file `_config.yml`.

```bash
title: Iqbal Birrul Walidain
email: kontak@iqbalbirrul.com
description: >- # this means to ignore newlines until "baseurl:"
  This is just another Jekyll site jekyll.iqbal.es
baseurl: "" # the subpath of your site, e.g. /blog
url: "" # the base hostname & protocol for your site, e.g. http://example.com
twitter_username: iqbalbirrul
github_username:  iqbalbirrul

# Build settings
markdown: kramdown
theme: minima
plugins:
  - jekyll-feed
```

Untuk dokumentasi dari jekyll tentang tema, deploy dan migrasi dari wordpress atau blogger, silakan ikuti tautan berikut:

- https://jekyllrb.com/docs/
- https://jekyllrb.com/docs/usage/
- https://jekyllrb.com/docs/templates/
- http://import.jekyllrb.com/
- https://jekyllrb.com/docs/deployment/
