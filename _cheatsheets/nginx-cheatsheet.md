---
layout: cheatsheet
title: Nginx Command Cheatsheet
description: Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy, and HTTP cache.
---


Nginx is a web server that can also be used as a reverse proxy, load balancer, mail proxy, and HTTP cache.


## Basic Commands

### Service Management
```bash
# SystemD (Ubuntu 16.04+, CentOS 7+)
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl status nginx
sudo systemctl enable nginx
sudo systemctl disable nginx

# SysVinit (older systems)
sudo service nginx start
sudo service nginx stop
sudo service nginx restart
sudo service nginx reload
sudo service nginx status
```

### Configuration Testing
```bash
nginx -t                    # Test configuration
nginx -T                    # Test and dump configuration
nginx -v                    # Show version
nginx -V                    # Show version and configure options
```

### Signal Commands
```bash
nginx -s stop               # Fast shutdown
nginx -s quit               # Graceful shutdown
nginx -s reload             # Reload configuration
nginx -s reopen             # Reopen log files
```

## Configuration Files

### Main Configuration
```nginx
# /etc/nginx/nginx.conf

user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
    worker_connections 768;
}

http {
    # Basic Settings
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    
    # MIME types
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    # Logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml text/javascript 
               application/json application/javascript application/xml+rss;
    
    # Virtual Host Configs
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
```

## Server Blocks (Virtual Hosts)

### Basic HTTP Server
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;
    
    root /var/www/example.com;
    index index.html index.htm;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```

### HTTPS Server with SSL
```nginx
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name example.com www.example.com;
    
    ssl_certificate /etc/nginx/ssl/example.com.crt;
    ssl_certificate_key /etc/nginx/ssl/example.com.key;
    
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    
    root /var/www/example.com;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```

### HTTP to HTTPS Redirect
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;
    return 301 https://$server_name$request_uri;
}
```

## Location Blocks

### Static Files
```nginx
location / {
    root /var/www/html;
    index index.html index.htm;
    try_files $uri $uri/ =404;
}
```

### Reverse Proxy
```nginx
location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_cache_bypass $http_upgrade;
}
```

### PHP-FPM
```nginx
location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
}
```

### Deny Access
```nginx
location ~ /\.ht {
    deny all;
}

location /admin {
    deny all;
    allow 192.168.1.0/24;
}
```

## Load Balancing

### Upstream Configuration
```nginx
upstream backend {
    least_conn;  # or ip_hash, or round-robin (default)
    server backend1.example.com weight=3;
    server backend2.example.com;
    server backend3.example.com backup;
}

server {
    location / {
        proxy_pass http://backend;
    }
}
```

## Caching

### Proxy Cache
```nginx
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:10m 
                 max_size=10g inactive=60m use_temp_path=off;

server {
    location / {
        proxy_cache my_cache;
        proxy_cache_valid 200 60m;
        proxy_cache_valid 404 1m;
        proxy_cache_use_stale error timeout updating;
        add_header X-Cache-Status $upstream_cache_status;
        
        proxy_pass http://backend;
    }
}
```

## Security Headers

### Common Security Headers
```nginx
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "no-referrer-when-downgrade" always;
add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
```

## Rate Limiting

### Limit Requests
```nginx
limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;

server {
    location /api/ {
        limit_req zone=mylimit burst=20 nodelay;
    }
}
```

## Logging

### Custom Log Format
```nginx
log_format custom '$remote_addr - $remote_user [$time_local] '
                  '"$request" $status $body_bytes_sent '
                  '"$http_referer" "$http_user_agent"';

access_log /var/log/nginx/access.log custom;
```

### Conditional Logging
```nginx
map $status $loggable {
    ~^[23] 0;
    default 1;
}

access_log /var/log/nginx/access.log combined if=$loggable;
```

## Common Configurations

### WordPress
```nginx
location / {
    try_files $uri $uri/ /index.php?$args;
}

location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
}
```

### Node.js Application
```nginx
location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
}
```

### WebSocket
```nginx
location /ws {
    proxy_pass http://localhost:8080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;
}
```

## Useful Variables

| Variable | Description |
|----------|-------------|
| `$host` | Host name |
| `$uri` | Current URI |
| `$request_uri` | Full original request URI |
| `$remote_addr` | Client IP address |
| `$server_name` | Server name |
| `$request_method` | Request method (GET, POST, etc.) |
| `$scheme` | Request scheme (http or https) |
| `$status` | Response status code |

## Troubleshooting

### Check Logs
```bash
tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

### Test Configuration
```bash
nginx -t
```

### Common Issues
```bash
# Permission denied
sudo chown -R www-data:www-data /var/www/html

# Port already in use
sudo lsof -i :80
sudo netstat -tulpn | grep :80

# SELinux issues (CentOS/RHEL)
sudo setsebool -P httpd_can_network_connect 1
```

## Tips

1. **Always test** configuration before reloading
2. **Use reload** instead of restart when possible
3. **Enable gzip** compression for better performance
4. **Set up SSL** with Let's Encrypt
5. **Use caching** for static content
6. **Implement rate limiting** for APIs
7. **Monitor logs** regularly
8. **Keep Nginx updated** for security
9. **Use upstream** for load balancing
10. **Optimize worker_processes** based on CPU cores

## Resources

- Official Documentation: https://nginx.org/en/docs/
- Nginx Config Generator: https://www.digitalocean.com/community/tools/nginx
- SSL Test: https://www.ssllabs.com/ssltest/
