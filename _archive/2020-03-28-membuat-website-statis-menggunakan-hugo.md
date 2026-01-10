---
title: Membuat Website Statis menggunakan Hugo
layout: archive
author: iqbwl
---
## Requirements

- **Git**
- **Hugo** - Generator Hugo
- **Text Editor** - Untuk edit konfigurasi dan edit konten

## Install Hugo

> Sistem Operasi yang saya gunakan adalah **Ubuntu 18.04 LTS**

Download file `.deb` hugo di laman [https://github.com/gohugoio/hugo/releases](https://github.com/gohugoio/hugo/releases), kemudian install.

```bash
root@static:~# wget https://github.com/gohugoio/hugo/releases/download/v0.68.3/hugo_extended_0.68.3_Linux-64bit.deb
```

```bash
root@static:~# dpkg -i hugo_extended_0.68.3_Linux-64bit.deb
(Reading database ... 101872 files and directories currently installed.)
Preparing to unpack hugo_extended_0.68.3_Linux-64bit.deb ...
Unpacking hugo (0.68.3) over (0.64.1) ...
Setting up hugo (0.68.3) ...
```

```bash
root@static:~# hugo version
Hugo Static Site Generator v0.68.3-157669A0/extended linux/amd64 BuildDate: 2020-03-24T12:13:38Z
```

### Create a New Site

Buat website baru dengan perintah berikut:

```bash
root@static:~# hugo new site namablog
```

```bash
root@static:~# hugo new site bloghugo
Congratulations! Your new Hugo site is created in /root/bloghugo.

Just a few more steps and you're ready to go:

1. Download a theme into the same-named folder.
   Choose a theme from https://themes.gohugo.io/ or
   create your own with the "hugo new theme <THEMENAME>" command.
2. Perhaps you want to add some content. You can add single files
   with "hugo new <SECTIONNAME>/<FILENAME>.<FORMAT>".
3. Start the built-in live server via "hugo server".

Visit https://gohugo.io/ for quickstart guide and full documentation.
```

### Add a Theme

Download tema terlebih dahulu dengan perintah dibawah ini.

```bash
root@static:~# cd bloghugo
root@static:~/bloghugo# git init
root@static:~/bloghugo# git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
```

**Note**: tema dapat Anda unduh di laman https://themes.gohugo.io/

Kemudian, tambahkan tema ke konfigurasi Hugo.

```bash
echo 'theme = "ananke"' >> config.toml
```

### Add Some Content

Tambahkan sebuah konten ke website Hugo.

```bash
hugo new posts/my-first-post.md
```

```bash
root@static:~/bloghugo# hugo new posts/my-first-post.md
/root/bloghugo/content/posts/my-first-post.md created
```

Anda juga dapat membuat konten file secara manual ke directory `content/posts`.

Edit file yang dusah dibuat, kira-kira menjadi seperti berikut:

**Catatan:** konten atau artikel ditulis menggunakan _markdown_

```bash
---
title: "My First Post"
date: 2019-03-26T08:47:11+01:00
draft: true
---

Halo,

Ini adalah post pertama saya di website statis Hugo.

Sekian...
```

Edit file `.md` menggunakan `vim` jika Anda pengguna server atau sublime, vscode jika Anda pengguna linux desktop.

### Start the Hugo server

Kemudian, jalankan hugo dengan perintah berikut:

```bash
hugo server -D
```

```bash
root@static:~/bloghugo# hugo server -D
Building sites …

                   | EN  
-------------------+-----
  Pages            | 10  
  Paginator pages  |  0  
  Non-page files   |  0  
  Static files     |  3  
  Processed images |  0  
  Aliases          |  1  
  Sitemaps         |  1  
  Cleaned          |  0  

Built in 53 ms
Watching for changes in /root/bloghugo/{archetypes,content,data,layouts,static,themes}
Watching for config changes in /root/bloghugo/config.toml
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

Akses website hugo dengan alamat [http://127.0.0.1:1313/](http://127.0.0.1:1313/) atau [http://hostname:1313/](http://hostname:1313/).

![Hugo Localhost](/migrated/blog/img/hugo/localhost-hugo-site.png)

Sekian, semoga bermanfaat...

**Sumber:** [https://gohugo.io/documentation/](https://gohugo.io/documentation/)
