---
layout: cheatsheet
title: SSH Command Cheatsheet
description: Essential SSH commands and configuration
---

# SSH Command Cheatsheet

A comprehensive reference for SSH (Secure Shell) commands.

## Basic Connection

### Connect to Server
```bash
ssh user@hostname                    # Basic connection
ssh user@192.168.1.100              # Connect by IP
ssh -p 2222 user@hostname           # Custom port
ssh user@hostname command           # Run command and exit
```

## SSH Keys

### Generate Keys
```bash
ssh-keygen                          # Generate RSA key (default)
ssh-keygen -t ed25519               # Generate Ed25519 key (recommended)
ssh-keygen -t rsa -b 4096           # Generate 4096-bit RSA key
ssh-keygen -t ed25519 -C "email@example.com"  # With comment
ssh-keygen -f ~/.ssh/custom_key     # Custom filename
```

### Copy Public Key
```bash
ssh-copy-id user@hostname           # Copy key to server
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@hostname  # Specific key
cat ~/.ssh/id_ed25519.pub | ssh user@hostname "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"  # Manual copy
```

### Key Management
```bash
ssh-add ~/.ssh/id_ed25519           # Add key to agent
ssh-add -l                          # List loaded keys
ssh-add -D                          # Remove all keys
ssh-add -d ~/.ssh/id_ed25519        # Remove specific key
eval "$(ssh-agent -s)"              # Start SSH agent
```

## Port Forwarding

### Local Port Forwarding
```bash
ssh -L 8080:localhost:80 user@hostname  # Forward local 8080 to remote 80
ssh -L 3306:db.example.com:3306 user@gateway  # Access DB through gateway
```

### Remote Port Forwarding
```bash
ssh -R 8080:localhost:80 user@hostname  # Forward remote 8080 to local 80
```

### Dynamic Port Forwarding (SOCKS Proxy)
```bash
ssh -D 1080 user@hostname           # Create SOCKS proxy on port 1080
```

## Tunneling

### SSH Tunnel
```bash
ssh -N -L 8080:localhost:80 user@hostname  # -N: no command execution
ssh -f -N -L 8080:localhost:80 user@hostname  # -f: background
```

### Jump Host (ProxyJump)
```bash
ssh -J jumphost user@target         # Connect through jump host
ssh -J user1@jump1,user2@jump2 user@target  # Multiple jumps
```

## File Transfer

### SCP (Secure Copy)
```bash
scp file.txt user@hostname:/path/   # Copy file to remote
scp user@hostname:/path/file.txt .  # Copy file from remote
scp -r directory user@hostname:/path/  # Copy directory
scp -P 2222 file.txt user@hostname:/path/  # Custom port
```

### SFTP
```bash
sftp user@hostname                  # Start SFTP session
# SFTP commands:
get remote_file                     # Download file
put local_file                      # Upload file
ls                                  # List remote files
lls                                 # List local files
cd /path                            # Change remote directory
lcd /path                           # Change local directory
```

## SSH Config

### ~/.ssh/config
```ssh
# Basic host
Host myserver
    HostName 192.168.1.100
    User john
    Port 2222

# With key
Host github
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_key

# Jump host
Host target
    HostName target.example.com
    User admin
    ProxyJump jumphost

# Wildcard
Host *.example.com
    User admin
    IdentityFile ~/.ssh/company_key
```

### Common Config Options
```ssh
Host *
    ServerAliveInterval 60          # Keep connection alive
    ServerAliveCountMax 3
    Compression yes                 # Enable compression
    ForwardAgent yes                # Forward SSH agent
    StrictHostKeyChecking no        # Skip host key check (insecure!)
    UserKnownHostsFile /dev/null    # Don't save host keys
```

## Security

### Disable Password Authentication
```bash
# /etc/ssh/sshd_config
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
```

### Change SSH Port
```bash
# /etc/ssh/sshd_config
Port 2222
```

### Restart SSH Service
```bash
sudo systemctl restart sshd         # SystemD
sudo service ssh restart            # SysVinit
```

## Troubleshooting

### Debug Connection
```bash
ssh -v user@hostname                # Verbose
ssh -vv user@hostname               # More verbose
ssh -vvv user@hostname              # Maximum verbosity
```

### Test Configuration
```bash
sshd -t                             # Test sshd config
ssh -G user@hostname                # Show effective config
```

### Fix Permissions
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/config
```

## Advanced

### X11 Forwarding
```bash
ssh -X user@hostname                # Enable X11 forwarding
ssh -Y user@hostname                # Trusted X11 forwarding
```

### Keep Connection Alive
```bash
ssh -o ServerAliveInterval=60 user@hostname
```

### Escape Sequences
```
~.                                  # Disconnect
~^Z                                 # Suspend SSH
~#                                  # List forwarded connections
~?                                  # Help
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `ssh user@host` | Connect to server |
| `ssh-keygen` | Generate SSH key |
| `ssh-copy-id user@host` | Copy public key |
| `scp file user@host:/path` | Copy file |
| `ssh -L 8080:localhost:80 user@host` | Local forward |
| `ssh -D 1080 user@host` | SOCKS proxy |
| `ssh -J jump user@target` | Jump host |
| `ssh -v user@host` | Verbose mode |

## Best Practices

1. **Use Ed25519 keys** instead of RSA
2. **Disable password authentication**
3. **Use SSH config** for convenience
4. **Change default port** for security
5. **Use strong passphrases** for keys
6. **Keep private keys secure** (600 permissions)
7. **Use SSH agent** for key management
8. **Enable two-factor authentication**
9. **Monitor SSH logs** regularly
10. **Keep SSH updated**

## Resources

- OpenSSH Manual: https://www.openssh.com/manual.html
- SSH Academy: https://www.ssh.com/academy/ssh
- SSH Config: https://www.ssh.com/academy/ssh/config
