---
title: Cara Install NodeJS di Ubuntu 20.04
layout: archive
author: iqbwl
---
Untuk installasi NodeJS pada Ubuntu sangatlah mudah, kita gunakan saja script nvm berikut:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```
```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

Setelah selesai, close terminal/console kemudian buka kembali agar nvm berjalan.

Gunakan perintah `nvm install --lts` untuk install NodeJS versi LTS.

```bash
iqbal@app-server:~$ node -v
v14.17.5
iqbal@app-server:~$ npm -v
6.14.14
iqbal@app-server:~$ nvm -v
0.38.0
```

Selesai.

**Source**: [https://github.com/nvm-sh/nvm#readme](https://github.com/nvm-sh/nvm#readme)