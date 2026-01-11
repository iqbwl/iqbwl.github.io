---
title: Server Block Nginx
layout: archive
author: iqbwl
---
![Nginx Logo https://dwglogo.com](/static/img/migrated/blog/img/nginx-logo.png)

Berikut contoh konfigurasi server block Nginx:

### Server Block Umum

```bash
server {
  listen 80;

  server_name domain.tld;
  root /var/www/public_html;

  index index.html index.php;
}
```

### Nginx dengan PHP FPM Socket

```bash
server {
 listen 80;

 server_name domain.tld;
 root /var/www/public_html;

 index index.php;

 location ~* \.php$ {
 fastcgi_pass unix:/run/php/php-fpm.sock;
 include	fastcgi_params;
 fastcgi_param	SCRIPT_FILENAME	$document_root$fastcgi_script_name;
 fastcgi_param	SCRIPT_NAME	$fastcgi_script_name;
  }
}
```

### Nginx dengan SSL

```bash
server {
  listen 80;

  server_name domain.tld;
}

server {
    listen 443 quic reuseport;
    listen 443 http2 ssl;
    
    server_name  domain.tld;

    ssl_certificate     /etc/fullchain.pem;
    ssl_certificate_key /etc/privkey.pem;
    ssl_session_timeout 15m;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP;
    ssl_prefer_server_ciphers on;
}
```

### Redirect http to https

```bash
server {
    server_name domain.tld;

    # Redirect to https://domain
    return 301 https://domain.tld$request_uri;
}
```

### Redirect www to non-www

```bash
server {
    server_name domain.tld;

    # Redirect to https://domain
    return 301 https://domain.tld$request_uri;
}

server {
   listen 443;
    server_name www.domain.tld;
  
    # Redirect to https://domain
    return 301 https://domain.tld$request_uri;

    # SSL for redirect
    ssl_certificate     /etc/fullchain.pem;
    ssl_certificate_key /etc/privkey.pem;
}
```

### Nginx sebagai Reverse Proxy

```bash
server {
  listen 80;

  server_name domain.tld;

  location / {
      proxy_pass http://192.168.2.2:9000;
  }
}
```

### Nginx: WordPress Server Blocks

```bash
upstream php {
        server unix:/tmp/php-cgi.socket;
        server 127.0.0.1:9000;
}

server {
        listen 80;
        listen [::]:80;
        ## Your website name goes here.
        server_name xxx.xxx.xxx;
        ## Your only path reference.
        root /var/www/html/web/wordpress;
        ## This should be in your http block and if it is, it's not needed here.
        index index.php;

        location = /favicon.ico {
                log_not_found off;
                access_log off;
        }

        location = /robots.txt {
                allow all;
                log_not_found off;
                access_log off;
        }

        location / {
                # This is cool because no php is touched for static content.
                # include the "?$args" part so non-default permalinks doesn't break when using query string
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                try_files $uri $uri/ /index.php?$args;
        }

        location ~ \.php$ {
                #NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
                include fastcgi_params;
                fastcgi_intercept_errors on;
                fastcgi_pass php;
                #The following parameter can be also included in fastcgi_params file
                fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
                expires max;
                log_not_found off;
        }
}
```

#### Nginx: Jekyll Server Blocks

```bash
server {
   listen 80;
   
   server_name domain.tld;
   return 301 https://$http_host$request_uri;
}

server {
    listen 443 quic reuseport;
    listen 443 http2 ssl;

    server_name domain.tld;

    ssl_certificate     /etc/fullchain.pem;
    ssl_certificate_key /etc/privkey.pem;
    ssl_session_timeout 15m;
    ssl_protocols SSLv3 TLSv1.2;
    ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP;
    ssl_prefer_server_ciphers on;

    location / {
        proxy_pass http://192.168.1.2:4000;
        allow 123.123.123.123;
        deny all;
    }

    # Jekyll Admin
    location ~ ^/(admin|_api)(/.*)? {
        auth_basic "Administration";
        auth_basic_user_file /etc/nginx/htpasswd;

        allow 123.123.123.123;
        deny all;

        proxy_pass http://192.168.1.2:4000/$1$2;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;

   }

    error_page 403 /403.html;
    location = /403.html {
        root /usr/local/nginx/html/;
        internal;
    }
}
```


Semoga bermanfaat.

Sumber : [https://www.nginx.com](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/)
