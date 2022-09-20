---
title: Cara Install Gatsby di Ubuntu 20.04
date: 2021-08-24 12:27:00 +0000
---

[Gatsby.js](https://www.gatsbyjs.com/) merupakan framework yang berbasis dari React.js dan bersifat open-source.

Persyaratan:

1. Node.js (v12.13 or newer)
2. Git
3. Gatsby CLI

Pertama install NodeJS terlebih dahulu, silakan klik url berikut untuk cara install NodeJS: [Cara Install NodeJS di Ubuntu 20.04](/blog/cara-install-nodejs-di-ubuntu-20-04/)

Install Gatsby dengan perintah dibawah ini.

```bash
npm install -g gatsby-cli
```

Jika sudah, silakan buat site dengan perintah berikut:

```bash
gatsby new
```
atau
```bash
gatsby new my-blog https://github.com/wangonya/the-plain-gatsby
```

Masuk ke directory `my-blog` kemudian jalankan `npm install`. Kemudian jalankan Gatsby dengan perintah `gatsby develop`.

```bash
cd my-blog/
npm install
gatsby develop
```

Buka `localhost:8000` atau `IP_Address:8000` pada browser untuk akses Gatsby. Untuk development bisa gunakan text editor yang ada.

Selesai.

[^1]: https://www.gatsbyjs.com/docs/tutorial/part-0/
[^2]: https://github.com/wangonya/the-plain-gatsby