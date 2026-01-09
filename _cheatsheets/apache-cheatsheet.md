---
layout: cheatsheet
title: Apache Command Cheatsheet
description: Essential Apache commands and configuration for web servers
---
# Apache Command Cheatsheet

A comprehensive reference for Apache HTTP Server commands and configuration.

## Basic Commands

### Service Management
```bash
# SystemD (Ubuntu 16.04+, CentOS 7+)
sudo systemctl start apache2      # Ubuntu/Debian
sudo systemctl start httpd         # CentOS/RHEL
sudo systemctl stop apache2
sudo systemctl restart apache2
sudo systemctl reload apache2
sudo systemctl status apache2
sudo systemctl enable apache2

# SysVinit (older systems)
sudo service apache2 start
sudo service apache2 stop
sudo service apache2 restart
sudo service apache2 reload
```

### Configuration Testing
```bash
apachectl -t                # Test configuration
apachectl -S                # Show virtual hosts
apachectl -V                # Show version and settings
apachectl -M                # Show loaded modules
apache2ctl configtest       # Test config (Ubuntu/Debian)
```

### Module Management
```bash
# Ubuntu/Debian
sudo a2enmod rewrite        # Enable module
sudo a2dismod rewrite       # Disable module
sudo a2ensite example.com   # Enable site
sudo a2dissite example.com  # Disable site

# CentOS/RHEL (edit httpd.conf)
LoadModule rewrite_module modules/mod_rewrite.so
```

## Configuration Files

### Main Configuration
```apache
# Ubuntu/Debian: /etc/apache2/apache2.conf
# CentOS/RHEL: /etc/httpd/conf/httpd.conf

ServerRoot "/etc/apache2"
Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5

<IfModule mpm_prefork_module>
    StartServers 5
    MinSpareServers 5
    MaxSpareServers 10
    MaxRequestWorkers 150
    MaxConnectionsPerChild 0
</IfModule>

# Include virtual hosts
IncludeOptional sites-enabled/*.conf
```

## Virtual Hosts

### Basic HTTP Virtual Host
```apache
<VirtualHost *:80>
    ServerName example.com
    ServerAlias www.example.com
    ServerAdmin webmaster@example.com
    
    DocumentRoot /var/www/example.com
    
    <Directory /var/www/example.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/example.com-error.log
    CustomLog ${APACHE_LOG_DIR}/example.com-access.log combined
</VirtualHost>
```

### HTTPS Virtual Host with SSL
```apache
<VirtualHost *:443>
    ServerName example.com
    ServerAlias www.example.com
    
    DocumentRoot /var/www/example.com
    
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/example.com.crt
    SSLCertificateKeyFile /etc/ssl/private/example.com.key
    SSLCertificateChainFile /etc/ssl/certs/chain.crt
    
    <Directory /var/www/example.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/example.com-ssl-error.log
    CustomLog ${APACHE_LOG_DIR}/example.com-ssl-access.log combined
</VirtualHost>
```

### HTTP to HTTPS Redirect
```apache
<VirtualHost *:80>
    ServerName example.com
    ServerAlias www.example.com
    Redirect permanent / https://example.com/
</VirtualHost>
```

## .htaccess

### URL Rewriting
```apache
RewriteEngine On

# Force HTTPS
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Remove www
RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
RewriteRule ^(.*)$ https://%1/$1 [R=301,L]

# Clean URLs
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ index.php?url=$1 [QSA,L]
```

### Access Control
```apache
# Deny all
Require all denied

# Allow specific IP
Require ip 192.168.1.0/24

# Password protection
AuthType Basic
AuthName "Restricted Area"
AuthUserFile /etc/apache2/.htpasswd
Require valid-user

# Deny access to files
<FilesMatch "\.(htaccess|htpasswd|ini|log|sh|inc|bak)$">
    Require all denied
</FilesMatch>
```

### Performance
```apache
# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

# Browser caching
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>
```

## Reverse Proxy

### Basic Proxy Configuration
```apache
<VirtualHost *:80>
    ServerName example.com
    
    ProxyPreserveHost On
    ProxyPass / http://localhost:3000/
    ProxyPassReverse / http://localhost:3000/
    
    <Proxy *>
        Require all granted
    </Proxy>
</VirtualHost>
```

### Load Balancing
```apache
<Proxy balancer://mycluster>
    BalancerMember http://server1.example.com:8080
    BalancerMember http://server2.example.com:8080
    BalancerMember http://server3.example.com:8080
    ProxySet lbmethod=byrequests
</Proxy>

ProxyPass / balancer://mycluster/
ProxyPassReverse / balancer://mycluster/
```

## Security Headers

### Common Security Headers
```apache
Header always set X-Frame-Options "SAMEORIGIN"
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"
Header always set Referrer-Policy "no-referrer-when-downgrade"
Header always set Content-Security-Policy "default-src 'self'"
```

## Common Modules

### Enable Important Modules
```bash
# Rewrite (URL rewriting)
sudo a2enmod rewrite

# SSL (HTTPS)
sudo a2enmod ssl

# Headers (HTTP headers)
sudo a2enmod headers

# Proxy (reverse proxy)
sudo a2enmod proxy
sudo a2enmod proxy_http

# Deflate (compression)
sudo a2enmod deflate

# Expires (caching)
sudo a2enmod expires
```

## Directory Options

### Common Directory Directives
```apache
<Directory /var/www/html>
    # Options
    Options Indexes FollowSymLinks MultiViews
    
    # Allow .htaccess
    AllowOverride All
    
    # Access control
    Require all granted
    
    # Directory index
    DirectoryIndex index.html index.php
</Directory>
```

## Logging

### Custom Log Format
```apache
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common

CustomLog ${APACHE_LOG_DIR}/access.log combined
ErrorLog ${APACHE_LOG_DIR}/error.log
```

### Conditional Logging
```apache
SetEnvIf Request_URI "^/health" dontlog
CustomLog ${APACHE_LOG_DIR}/access.log combined env=!dontlog
```

## Common Configurations

### WordPress
```apache
<Directory /var/www/wordpress>
    Options FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

# In .htaccess
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
```

### PHP Configuration
```apache
<FilesMatch \.php$>
    SetHandler application/x-httpd-php
</FilesMatch>

<IfModule mod_php7.c>
    php_value upload_max_filesize 64M
    php_value post_max_size 64M
    php_value max_execution_time 300
    php_value max_input_time 300
</IfModule>
```

## Password Protection

### Create Password File
```bash
# Create password file
sudo htpasswd -c /etc/apache2/.htpasswd username

# Add more users
sudo htpasswd /etc/apache2/.htpasswd another_user
```

### Protect Directory
```apache
<Directory /var/www/admin>
    AuthType Basic
    AuthName "Admin Area"
    AuthUserFile /etc/apache2/.htpasswd
    Require valid-user
</Directory>
```

## Troubleshooting

### Check Logs
```bash
# Ubuntu/Debian
tail -f /var/log/apache2/error.log
tail -f /var/log/apache2/access.log

# CentOS/RHEL
tail -f /var/log/httpd/error_log
tail -f /var/log/httpd/access_log
```

### Common Issues
```bash
# Test configuration
apachectl configtest

# Check syntax
apache2ctl -t

# Port already in use
sudo lsof -i :80
sudo netstat -tulpn | grep :80

# Permission issues
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# SELinux issues (CentOS/RHEL)
sudo setsebool -P httpd_can_network_connect 1
sudo chcon -R -t httpd_sys_content_t /var/www/html
```

## Performance Tuning

### MPM Configuration
```apache
# Prefork MPM (compatibility)
<IfModule mpm_prefork_module>
    StartServers 5
    MinSpareServers 5
    MaxSpareServers 10
    MaxRequestWorkers 150
    MaxConnectionsPerChild 3000
</IfModule>

# Worker MPM (performance)
<IfModule mpm_worker_module>
    StartServers 2
    MinSpareThreads 25
    MaxSpareThreads 75
    ThreadLimit 64
    ThreadsPerChild 25
    MaxRequestWorkers 150
    MaxConnectionsPerChild 3000
</IfModule>
```

## Tips

1. **Always test** configuration before restarting
2. **Use reload** instead of restart when possible
3. **Enable mod_deflate** for compression
4. **Set up SSL** with Let's Encrypt
5. **Use .htaccess** carefully (performance impact)
6. **Monitor logs** regularly
7. **Keep Apache updated** for security
8. **Optimize MPM** settings for your workload
9. **Use caching** modules for better performance
10. **Implement security headers**

## Resources

- Official Documentation: https://httpd.apache.org/docs/
- Apache Config Generator: https://mozilla.github.io/server-side-tls/ssl-config-generator/
- htaccess tester: https://htaccess.madewithlove.com/
