---
title: Could not resolve module "@parcel/namer-default"
layout: archive
author: iqbwl
---
Saat sedang menjalankan command `npm install`, kemudian failed karena ada error seperti berikut:

```bash
13:12:14 PM: Node version v16.15.0
13:12:15 PM: Gatsby version: 4.16.0
13:12:15 PM: Gatsby version Gatsby CLI version: 4.16.0
13:12:15 PM: BUILDS
13:12:15 PM: Note: this is the Gatsby version for the site at: /usr/src/app/www
13:12:16 PM: Setting gatsby to /usr/src/app/www/node_modules/gatsby
13:12:16 PM: info Running Inc Build CLI v2.0.4
13:12:27 PM: ERROR Failed to compile Gatsby files (Error):
13:12:27 PM: Could not resolve module "@parcel/namer-default" from "/usr/src/app/www/node\_modules/@gatsbyjs/parcel-namer-relative-to-cwd/lib/index.js".
13:12:27 PM: not finished compile gatsby files - 8.768s
```

Ini menandakan module `@parcel/namer-default` tidak ter-install, maka install terlebih dahulu agar berjalan normal.

```bash
npm install @parcel/namer-default
```

Jika ada error saat melakukan installasi, tambahkan `--force` atau `--legacy-peer-deps`.

Selesai.