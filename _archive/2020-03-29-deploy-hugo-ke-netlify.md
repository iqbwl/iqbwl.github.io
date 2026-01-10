---
title: Deploy Hugo ke Netlify
layout: archive
author: iqbwl
---
## Konfigurasi Netlify

Buat konfigurasi Netlify pada repository terlebih dahulu.

- Buat file `netlify.toml` pada root project Hugo:

    ```bash
    [build]
    publish = "public"
    command = "hugo --gc --minify"

    [context.production.environment]
    HUGO_VERSION = "0.68.3"
    HUGO_ENV = "production"
    HUGO_ENABLEGITINFO = "true"

    [context.split1]
    command = "hugo --gc --minify --enableGitInfo"

    [context.split1.environment]
    HUGO_VERSION = "0.68.3"
    HUGO_ENV = "production"

    [context.deploy-preview]
    command = "hugo --gc --minify --buildFuture -b $DEPLOY_PRIME_URL"

    [context.deploy-preview.environment]
    HUGO_VERSION = "0.68.3"

    [context.branch-deploy]
    command = "hugo --gc --minify -b $DEPLOY_PRIME_URL"

    [context.branch-deploy.environment]
    HUGO_VERSION = "0.68.3"

    [context.next.environment]
    HUGO_ENABLEGITINFO = "true"
    ```
    
    Konfigurasi ini berguna agar netlify dapat membaca versi hugo dan perintah yang digunakan untuk deploy.

- Push ke repository.

## Daftar Netlify

- Buka website [Netlify](https://netlify.com), dan buat akun.
- Apabila akun sudah dibuat, klik New Site from Git.
 ![New Site](/migrated/blog/img/hugo/netlify/netlify-new-site.png)

- Pilih antara GitHub, GitLab atau BitBucket tempat dimana repository Hugo sebelumnya dideploy.
 ![Continuous Deployment](/migrated/blog/img/hugo/netlify/netlify-deployment.png)

 - Pilih repository.
  ![Select Repository](/migrated/blog/img/hugo/netlify/netlify-repo.png)

- Klik Deploy Site.
  ![Deploy Site](/migrated/blog/img/hugo/netlify/netlify-deploy-site.png)

- Tunggu beberapa saat, dan Hugo berhasil dideploy ke Netlify.
  ![Deploy Success](/migrated/blog/img/hugo/netlify/netlify-deploy-success.png)

  **Note:** Nantinya setiap kita melakukan update konten dan push repository, maka website pada Netlify akan secara otomatis terupdate.

### Ubah Subdomain

Pada screenshot diatas, kita mendapatkan subdomain `quirky-einstein-28a6c9.netlify.com`. Subdomain ini dapat kita ubah.

- Masuk ke Site Settings
  ![Site Settings](/migrated/blog/img/hugo/netlify/netlify-site-settings.png)

- Pada Site Details, klik Change site name
  ![Site Details](/migrated/blog/img/hugo/netlify/netlify-change-site-name.png)

- Ubah subdomain, sesuai keinginan (bila tersedia) lalu klik Save.
  ![Change Site Name](/migrated/blog/img/hugo/netlify/netlify-change-site-name-save.png)

- Subdomain berhasil diubah.
  ![New Site Details](/migrated/blog/img/hugo/netlify/netlify-change-site-name-success.png)

- Akses subdomain
  ![Website Hugo](/migrated/blog/img/hugo/netlify/netlify-subdomain.png)
  ![Website Hugo](/migrated/blog/img/hugo/netlify/netlify-subdomain2.png)

- Selesai..

**Sumber:** https://gohugo.io/documentation/
