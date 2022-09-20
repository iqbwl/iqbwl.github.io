---
title: Membuat Jekyll agar running di background
tags:
- jekyll
date: '2021-02-03 05:28:18'
---

Secara default jekyll tidak bisa dijalankan sebagai daemon, jadi ada cara tersendiri untuk membuat jekyll berjalan dalam background.

Berikut perintahnya:

```bash
setsid bundle exec jekyll serve --port 4000 --host 127.0.0.1 --watch --force_polling &>/dev/null </dev/null &
```

> Untuk hostnya disesuaikan dengan IP Address yang ingin dipakai.

Semoga bermanfaat.

> Sc: archive [kuro.zone](http://kuro.zone)
