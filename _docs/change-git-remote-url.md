---
title: Change Git remote URL
layout: docs
author: iqbwl
---
Masuk ke repository terlebih dahulu, kemudian gunakan perintah berikut:

```bash
$ git remote -v
```
```bash
$ git remote set-url origin https://github.com/USERNAME/REPOSITORY.git
```
```bash
$ git remote -v
# Verify new remote URL
> origin  https://github.com/USERNAME/REPOSITORY.git (fetch)
> origin  https://github.com/USERNAME/REPOSITORY.git (push)
```

> Sc: archive [kuro.zone](http://kuro.zone)
