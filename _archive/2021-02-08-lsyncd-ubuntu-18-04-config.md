---
title: 'Lsyncd: Ubuntu 18.04 Config'
layout: archive
author: iqbwl
---
### Default

Edit file `/etc/lsyncd/lsyncd.conf.lua`

```bash
settings {
        logfile         = "/var/log/lsyncd/lsyncd.log",
        statusFile      = "/tmp/lsyncd.stat",
        statusInterval  = 1,
}
sync {
        default.rsync,
        source  = "/var/www/html/web",
        target  = "192.168.xx.x:/var/www/html/web",
}
rsync = {
        update  = true,
        perms   = true,
        owner   = true,
        group   = true,
        rsh     = "/usr/bin/ssh -l root -i /root/.ssh/id_rsa"
}
```

### Custom Port

Edit file `/etc/lsyncd/lsyncd.conf.lua`

```bash
settings {

	logfile = "/var/log/lsyncd/lsyncd.log",
	statusFile = "/var/log/lsyncd/lsyncd.status"
}

sync{
    default.rsync,
    source    = "/var/www/html",
    target    = "192.168.xx.x:/data/public_html",
    rsync     = {
        archive  = true,
        compress = true,
        update  = true,
        perms   = true,
--      port    = 2022,
        owner   = true,
        group   = true,
        rsh     = "/usr/bin/ssh -p 2022 -o StrictHostKeyChecking=no",
        _extra   = {"--omit-dir-times","-e ssh -i /root/.ssh/id_rsa"}
    }
}
```

> Sc: archive [kuro.zone](http://kuro.zone)
