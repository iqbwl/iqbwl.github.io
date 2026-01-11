---
title: Deploy Hugo ke Github Pages
layout: archive
author: iqbwl
---
## Buat Repositori

Yang pertama adalah siapkan 2 repository GitHub, sebagai berikut:

- Repo 1: bloghugo (sebagai repositori project)
- Repo 2: _username_.github.io (untuk github pages)

![Repositori Project](/static/img/migrated/blog/img/hugo/repo-project.png)
Repositori `bloghugo` berfungsi untuk menyimpan semua file project Hugo. Repositori ini bisa digunakan sebagai backup.

![GitHub Pages](/static/img/migrated/blog/img/hugo/repo-pages.png)
Sementara repositori `username.github.io` untuk menyimpan file yang ada di `public` atau hasil render dari Hugo.

Semua file statis yang ada di repositori `username.github.io`, nantinya akan diakses melalui https://username.github.io.

## Remote Repositori

Remote kedua repositori:

```bash
git init
git remote add origin https://github.com/iqbalbirrul/bloghugo.git
git submodule add -b master https://github.com/iqbalbirrul/iqbalbirrul.github.io.git public
```

## Buat file Bash

```bash
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# tambah perubahan
git add -A

# buat commit
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# push
git push origin master

# Genterate
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# pindah ke public
cd public
# tambahkan perubahan
git add -A

# buat commit
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# pushb
git push origin master

# Balik ke direktori sebelumnya
cd ..
```

Beri permission pada file bash:

```bash
chmod +x deploy.sh
```

## Deploy Git

Eksekusi file bash:

```bash
./deploy.sh
```

```bash
root@static:~/bloghugo# ./deploy.sh 
Deploying updates to GitHub...
warning: adding embedded git repository: public
hint: You've added another git repository inside your current repository.
hint: Clones of the outer repository will not contain the contents of
hint: the embedded repository and will not know how to obtain it.
hint: If you meant to add a submodule, use:
hint: 
hint:   git submodule add <url> public
hint: 
hint: If you added this path by mistake, you can remove it from the
hint: index with:
hint: 
hint:   git rm --cached public
hint: 
hint: See "git help submodule" for more information.
[master (root-commit) b9575c2] rebuilding site Sun Mar 29 00:52:44 WIB 2020
 99 files changed, 9267 insertions(+)
 create mode 100644 .gitmodules
 create mode 100644 archetypes/default.md
 create mode 100644 config.toml
 create mode 100644 content/posts/my-first-post.md
 create mode 100755 deploy.sh
 create mode 160000 public
 create mode 100644 themes/ananke/CHANGELOG.md
 create mode 100755 themes/ananke/LICENSE.md
 create mode 100644 themes/ananke/README.md
 create mode 100755 themes/ananke/archetypes/default.md
 create mode 100644 themes/ananke/data/webpack_assets.json
 create mode 100644 themes/ananke/exampleSite/config.toml
 create mode 100644 themes/ananke/exampleSite/content/_index.md
 create mode 100644 themes/ananke/exampleSite/content/about/_index.md
 create mode 100644 themes/ananke/exampleSite/content/contact.md
 create mode 100644 themes/ananke/exampleSite/content/post/_index.md
 create mode 100644 themes/ananke/exampleSite/content/post/chapter-1.md
 create mode 100644 themes/ananke/exampleSite/content/post/chapter-2.md
 create mode 100644 themes/ananke/exampleSite/content/post/chapter-3.md
 create mode 100644 themes/ananke/exampleSite/content/post/chapter-4.md
 create mode 100644 themes/ananke/exampleSite/content/post/chapter-5.md
 create mode 100644 themes/ananke/exampleSite/content/post/chapter-6.md
 create mode 100644 themes/ananke/exampleSite/static/images/Pope-Edouard-de-Beaumont-1844.jpg
 create mode 100644 themes/ananke/exampleSite/static/images/Victor_Hugo-Hunchback.jpg
 create mode 100644 themes/ananke/exampleSite/static/images/esmeralda.jpg
 create mode 100644 themes/ananke/exampleSite/static/images/notebook.jpg
 create mode 100644 themes/ananke/i18n/de.toml
 create mode 100644 themes/ananke/i18n/en.toml
 create mode 100644 themes/ananke/i18n/es.toml
 create mode 100644 themes/ananke/i18n/fr.toml
 create mode 100644 themes/ananke/i18n/it.toml
 create mode 100644 themes/ananke/i18n/nl.toml
 create mode 100644 themes/ananke/i18n/pt.toml
 create mode 100644 themes/ananke/i18n/ru.toml
 create mode 100644 themes/ananke/i18n/sv.toml
 create mode 100644 themes/ananke/i18n/uk.toml
 create mode 100644 themes/ananke/i18n/zh.toml
 create mode 100644 themes/ananke/images/screenshot.png
 create mode 100644 themes/ananke/images/tn.png
 create mode 100755 themes/ananke/layouts/404.html
 create mode 100755 themes/ananke/layouts/_default/baseof.html
 create mode 100755 themes/ananke/layouts/_default/list.html
 create mode 100755 themes/ananke/layouts/_default/single.html
 create mode 100644 themes/ananke/layouts/_default/taxonomy.html
 create mode 100644 themes/ananke/layouts/_default/terms.html
 create mode 100755 themes/ananke/layouts/index.html
 create mode 100644 themes/ananke/layouts/page/single.html
 create mode 100644 themes/ananke/layouts/partials/commento.html
 create mode 100644 themes/ananke/layouts/partials/i18nlist.html
 create mode 100644 themes/ananke/layouts/partials/menu-contextual.html
 create mode 100644 themes/ananke/layouts/partials/new-window-icon.html
 create mode 100644 themes/ananke/layouts/partials/page-header.html
 create mode 100644 themes/ananke/layouts/partials/site-favicon.html
 create mode 100755 themes/ananke/layouts/partials/site-footer.html
 create mode 100755 themes/ananke/layouts/partials/site-header.html
 create mode 100644 themes/ananke/layouts/partials/site-navigation.html
 create mode 100644 themes/ananke/layouts/partials/site-scripts.html
 create mode 100644 themes/ananke/layouts/partials/social-follow.html
 create mode 100644 themes/ananke/layouts/partials/social-share.html
 create mode 100644 themes/ananke/layouts/partials/summary-with-image.html
 create mode 100644 themes/ananke/layouts/partials/summary.html
 create mode 100644 themes/ananke/layouts/partials/svg/facebook.svg
 create mode 100644 themes/ananke/layouts/partials/svg/github.svg
 create mode 100644 themes/ananke/layouts/partials/svg/gitlab.svg
 create mode 100644 themes/ananke/layouts/partials/svg/instagram.svg
 create mode 100644 themes/ananke/layouts/partials/svg/keybase.svg
 create mode 100644 themes/ananke/layouts/partials/svg/linkedin.svg
 create mode 100644 themes/ananke/layouts/partials/svg/mastodon.svg
 create mode 100644 themes/ananke/layouts/partials/svg/medium.svg
 create mode 100644 themes/ananke/layouts/partials/svg/new-window.svg
 create mode 100644 themes/ananke/layouts/partials/svg/slack.svg
 create mode 100644 themes/ananke/layouts/partials/svg/stackoverflow.svg
 create mode 100644 themes/ananke/layouts/partials/svg/twitter.svg
 create mode 100644 themes/ananke/layouts/partials/svg/youtube.svg
 create mode 100644 themes/ananke/layouts/partials/tags.html
 create mode 100644 themes/ananke/layouts/post/list.html
 create mode 100644 themes/ananke/layouts/post/summary-with-image.html
 create mode 100644 themes/ananke/layouts/post/summary.html
 create mode 100644 themes/ananke/layouts/robots.txt
 create mode 100644 themes/ananke/layouts/shortcodes/form-contact.html
 create mode 100644 themes/ananke/package-lock.json
 create mode 100755 themes/ananke/package.json
 create mode 100644 themes/ananke/src/css/_code.css
 create mode 100644 themes/ananke/src/css/_hugo-internal-templates.css
 create mode 100644 themes/ananke/src/css/_social-icons.css
 create mode 100644 themes/ananke/src/css/_styles.css
 create mode 100644 themes/ananke/src/css/_tachyons.css
 create mode 100644 themes/ananke/src/css/main.css
 create mode 100644 themes/ananke/src/css/postcss.config.js
 create mode 100644 themes/ananke/src/js/main.js
 create mode 100644 themes/ananke/src/package-lock.json
 create mode 100644 themes/ananke/src/package.json
 create mode 100644 themes/ananke/src/readme.md
 create mode 100644 themes/ananke/src/webpack.config.js
 create mode 100644 themes/ananke/stackbit.yaml
 create mode 100644 themes/ananke/static/dist/css/app.1cb140d8ba31d5b2f1114537dd04802a.css
 create mode 100644 themes/ananke/static/dist/js/app.3fc0f988d21662902933.js
 create mode 100644 themes/ananke/static/images/gohugo-default-sample-hero-image.jpg
 create mode 100755 themes/ananke/theme.toml
Username for 'https://github.com': username
Password for 'https://username@github.com': 
Counting objects: 130, done.
Compressing objects: 100% (119/119), done.
Writing objects: 100% (130/130), 2.63 MiB | 1.76 MiB/s, done.
Total 130 (delta 6), reused 0 (delta 0)
remote: Resolving deltas: 100% (6/6), done.
To https://github.com/username/bloghugo.git
 * [new branch]      master -> master
Building sites … WARN 2020/03/29 00:53:01 Page.URL is deprecated and will be removed in a future release. Use .Permalink or .RelPermalink. If what you want is the front matter URL value, use .Params.url

                   | EN  
-------------------+-----
  Pages            | 11  
  Paginator pages  |  0  
  Non-page files   |  0  
  Static files     |  3  
  Processed images |  0  
  Aliases          |  1  
  Sitemaps         |  1  
  Cleaned          |  0  

Total in 74 ms
[master 4a1930f] rebuilding site Sun Mar 29 00:53:01 WIB 2020
 10 files changed, 38 insertions(+), 38 deletions(-)
Username for 'https://github.com': username
Password for 'https://username@github.com': 
Counting objects: 16, done.
Compressing objects: 100% (15/15), done.
Writing objects: 100% (16/16), 1.51 KiB | 771.00 KiB/s, done.
Total 16 (delta 10), reused 0 (delta 0)
remote: Resolving deltas: 100% (10/10), completed with 10 local objects.
To https://github.com/username/username.github.io.git
   fb0dad3..4a1930f  master -> master
root@static:~/bloghugo# 
```

Deploy selesai..

![Deploy sukses](/static/img/migrated/blog/img/hugo/repo-project-deployed.png)
![Deploy sukses](/static/img/migrated/blog/img/hugo/repo-pages-deployed.png)

Sekarang, akses alamat `https://username.github.io`

![GitHub Pages berhasil di buat](/static/img/migrated/blog/img/hugo/iqbalbirrul-github-pages.png)

Hugo berhasil di deploy ke GitHub Pages..

Sekian, semoga bermanfaat..

**Sumber:** https://gohugo.io/hosting-and-deployment/hosting-on-github/
