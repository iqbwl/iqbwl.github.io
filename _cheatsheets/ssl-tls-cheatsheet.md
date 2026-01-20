---
layout: cheatsheet
title: SSL/TLS & OpenSSL Cheatsheet
description: SSL (Secure Sockets Layer) and its successor, TLS (Transport Layer Security), are protocols for establishing authenticated and encrypted links between networked computers.
---


SSL (Secure Sockets Layer) and its successor, TLS (Transport Layer Security), are protocols for establishing authenticated and encrypted links between networked computers.


## Generate Private Keys

### RSA Keys
```bash
openssl genrsa -out private.key 2048
openssl genrsa -out private.key 4096
openssl genrsa -aes256 -out private.key 2048  # Encrypted
```

### EC Keys (Recommended)
```bash
openssl ecparam -genkey -name prime256v1 -out private.key
openssl ecparam -genkey -name secp384r1 -out private.key
```

## Generate CSR (Certificate Signing Request)

### From Private Key
```bash
openssl req -new -key private.key -out request.csr
openssl req -new -key private.key -out request.csr -subj "/C=US/ST=State/L=City/O=Org/CN=example.com"
```

### With SAN (Subject Alternative Names)
```bash
openssl req -new -key private.key -out request.csr -config <(
cat <<-EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = v3_req

[dn]
C=US
ST=State
L=City
O=Organization
CN=example.com

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = example.com
DNS.2 = www.example.com
DNS.3 = *.example.com
EOF
)
```

## Self-Signed Certificates

### Generate Self-Signed Certificate
```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
openssl req -x509 -key private.key -in request.csr -out certificate.crt -days 365
```

## View Certificates

### View Certificate
```bash
openssl x509 -in certificate.crt -text -noout
openssl x509 -in certificate.crt -noout -subject
openssl x509 -in certificate.crt -noout -issuer
openssl x509 -in certificate.crt -noout -dates
openssl x509 -in certificate.crt -noout -fingerprint
```

### View CSR
```bash
openssl req -in request.csr -text -noout
openssl req -in request.csr -noout -subject
```

### View Private Key
```bash
openssl rsa -in private.key -text -noout
openssl rsa -in private.key -check
```

## Verify Certificates

### Verify Certificate
```bash
openssl verify certificate.crt
openssl verify -CAfile ca.crt certificate.crt
```

### Check if Private Key Matches Certificate
```bash
openssl x509 -noout -modulus -in certificate.crt | openssl md5
openssl rsa -noout -modulus -in private.key | openssl md5
# If MD5 hashes match, they're a pair
```

### Check if CSR Matches Private Key
```bash
openssl req -noout -modulus -in request.csr | openssl md5
openssl rsa -noout -modulus -in private.key | openssl md5
```

## Convert Formats

### PEM to DER
```bash
openssl x509 -in cert.pem -outform der -out cert.der
```

### DER to PEM
```bash
openssl x509 -in cert.der -inform der -out cert.pem
```

### PEM to PKCS12
```bash
openssl pkcs12 -export -out certificate.pfx -inkey private.key -in certificate.crt -certfile ca.crt
```

### PKCS12 to PEM
```bash
openssl pkcs12 -in certificate.pfx -out certificate.pem -nodes
```

## Test SSL/TLS Connections

### Test HTTPS Connection
```bash
openssl s_client -connect example.com:443
openssl s_client -connect example.com:443 -servername example.com  # SNI
openssl s_client -connect example.com:443 -showcerts
openssl s_client -connect example.com:443 -tls1_2
openssl s_client -connect example.com:443 -tls1_3
```

### Test SMTP with STARTTLS
```bash
openssl s_client -connect smtp.example.com:587 -starttls smtp
```

### Test IMAP with STARTTLS
```bash
openssl s_client -connect imap.example.com:143 -starttls imap
```

## Certificate Authority (CA)

### Create CA
```bash
# Generate CA private key
openssl genrsa -aes256 -out ca.key 4096

# Generate CA certificate
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt
```

### Sign Certificate with CA
```bash
openssl x509 -req -in request.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out certificate.crt -days 365
```

## Let's Encrypt (Certbot)

### Install Certbot
```bash
sudo apt install certbot python3-certbot-nginx  # Nginx
sudo apt install certbot python3-certbot-apache # Apache
```

### Verification Methods (Obtain Certificate)

#### Webroot Method
Use this if you have a running web server and don't want to stop it. Certbot places a file in `.well-known/acme-challenge`.
```bash
sudo certbot certonly --webroot -w /var/www/html -d example.com -d www.example.com
```

#### Standalone Method
Use this if you don't have a web server running, or can temporarily stop it. Certbot spins up its own server on port 80.
```bash
sudo certbot certonly --standalone -d example.com
```

#### Nginx/Apache Plugins (Automated)
Automatically configures your web server (edits config files) and reloads it.
```bash
sudo certbot --nginx -d example.com
sudo certbot --apache -d example.com
```

#### DNS Method (Manual)
Useful for wildcard certificates (`*.example.com`) or if port 80 is blocked. Requires adding a confusing TXT record to your DNS.
```bash
sudo certbot certonly --manual --preferred-challenges dns -d example.com -d *.example.com
```

#### DNS Plugins (Automated)
If you use a supported DNS provider (Cloudflare, Route53, etc.), use a plugin to automate DNS challenges.

**Cloudflare Example**
1. Create `~/.secrets/certbot/cloudflare.ini` (chmod 600):
   ```ini
   # ~/.secrets/certbot/cloudflare.ini
   dns_cloudflare_api_token = 0123456789abcdef0123456789abcdef01234567
   ```
2. Run Certbot:
   ```bash
   sudo certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini -d example.com
   ```

**Route53 (AWS) Example**
1. Configure AWS credentials (standard AWS CLI setup):
   ```bash
   # ~/.aws/config
   [default]
   aws_access_key_id=AKIAIOSFODNN7EXAMPLE
   aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
   ```
2. Run Certbot (ensure the machine has IAM permissions):
   ```bash
   sudo certbot certonly --dns-route53 -d example.com
   ```

### Renew Certificates
```bash
sudo certbot renew
sudo certbot renew --dry-run  # Test renewal
```

### List Certificates
```bash
sudo certbot certificates
```

### Delete Certificate
```bash
sudo certbot delete --cert-name example.com
```

## Common Tasks

### Create Certificate Bundle
```bash
cat certificate.crt intermediate.crt root.crt > bundle.crt
```

### Extract Certificate from Server
```bash
echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -out certificate.crt
```

### Check Certificate Expiry
```bash
openssl x509 -in certificate.crt -noout -enddate
echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -enddate
```

### Generate Diffie-Hellman Parameters
```bash
openssl dhparam -out dhparam.pem 2048
openssl dhparam -out dhparam.pem 4096
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `openssl genrsa -out key.pem 2048` | Generate RSA key |
| `openssl req -new -key key.pem -out csr.pem` | Generate CSR |
| `openssl req -x509 -newkey rsa:2048 -out cert.pem` | Self-signed cert |
| `openssl x509 -in cert.pem -text -noout` | View certificate |
| `openssl verify cert.pem` | Verify certificate |
| `openssl s_client -connect host:443` | Test connection |
| `certbot --nginx -d example.com` | Let's Encrypt |

## Best Practices

1. **Use strong keys** (2048-bit RSA minimum, EC preferred)
2. **Use Let's Encrypt** for free certificates
3. **Enable HSTS** for security
4. **Use TLS 1.2+** only
5. **Disable weak ciphers**
6. **Monitor expiry dates**
7. **Automate renewal**
8. **Use certificate pinning** when appropriate
9. **Keep private keys secure**
10. **Test with SSL Labs**

## Resources

- OpenSSL Documentation: https://www.openssl.org/docs/
- Let's Encrypt: https://letsencrypt.org/
- SSL Labs Test: https://www.ssllabs.com/ssltest/
- Mozilla SSL Config: https://ssl-config.mozilla.org/
