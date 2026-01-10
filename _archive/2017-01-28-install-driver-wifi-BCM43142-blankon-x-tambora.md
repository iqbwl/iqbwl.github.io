---
title: Install Driver WiFi BCM43142 BlankOn X Tambora
layout: archive
author: iqbwl
---
Langsung saja buka `sources.list` dan tambahkan repository berikut :

```bash
# Debian 8 "Jessie"
deb http://httpredir.debian.org/debian/ jessie main contrib non-free
```

Lalu update dan install `linux-image`, `linux-header` dan `broadcom-sta-dkms`

```bash
apt-get update
apt-get install linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') broadcom-sta-dkms
```

Kemudian unload modul yang bermasalah

```bash
modprobe -r b44 b43 b43legacy ssb brcmsmac bcma
```

dan load modul `wl`

```
modprobe wl
```

![successful](/migrated/blog/img/wlan.png)

Selesai, semoga bermanfaat.
