---
layout: cheatsheet
title: WSL Command Cheatsheet
description: Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment directly on Windows, unmodified, without the overhead of a traditional virtual machine or dual-boot setup.
---


Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment directly on Windows, unmodified, without the overhead of a traditional virtual machine or dual-boot setup.


## Installation & Setup

### Install WSL
```powershell
wsl --install              # Install WSL and default Ubuntu distro
wsl --install -d <Distro>  # Install a specific distribution
```

### List Distributions
```powershell
wsl --list --online        # List available distributions to install
wsl --list -v              # List installed distributions and their versions
wsl -l -v                  # Shorthand for list verbose
```

### Update WSL
```powershell
wsl --update               # Update the WSL kernel
wsl --update --web-download # Download update from web (if store fails)
wsl --status               # Check WSL status and version
wsl --version              # Display detailed version info
```

## Distribution Management

### Running Distros
```powershell
wsl                        # Launch the default distribution
wsl -d <Distro>            # Launch a specific distribution
wsl -u <User>              # Launch as a specific user
```

### Managing State
```powershell
wsl --shutdown             # Immediately terminate all running distributions
wsl --terminate <Distro>   # Terminate a specific distribution
wsl -t <Distro>            # Shorthand for terminate
wsl --unregister <Distro>  # Unregister (uninstall) a distribution
```

### Default Settings
```powershell
wsl --set-default <Distro> # Set default distribution
wsl -s <Distro>            # Shorthand for set default
wsl --set-default-version 2 # Set default WSL version (1 or 2)
wsl --set-version <Distro> 2 # Convert a distro to WSL 2
```

## File Interoperability

### Access Windows from Linux
Windows drives are mounted under `/mnt/`.
```bash
cd /mnt/c/Users/<Username>/Desktop  # Go to Windows Desktop
explorer.exe .                      # Open current Linux directory in Windows Explorer
code .                              # Open current directory in VS Code
notepad.exe file.txt                # Edit file using Windows Notepad
```

### Access Linux from Windows
Access Linux files using the network path `\\wsl$`.
```powershell
\\wsl$\Ubuntu\home\username         # Access Ubuntu home directory
\\wsl$\                             # List all running distros
```

### Run Windows Commands
You can run Windows binaries directly from the Linux shell.
```bash
ipconfig.exe               # Check Windows IP configuration
clip.exe < file.txt        # Copy file content to Windows clipboard
powershell.exe Get-Date    # Run a PowerShell command
```

## Backup & Restore

### Export (Backup)
Create a tarball of your distribution.
```powershell
# Syntax: wsl --export <Distro> <Path\FileName.tar>
wsl --export Ubuntu C:\backups\ubuntu-backup.tar
```

### Import (Restore)
Import a tarball as a new distribution.
```powershell
# Syntax: wsl --import <DistroName> <InstallLocation> <Path\FileName.tar>
wsl --import Ubuntu-Copy C:\WSL\Ubuntu-Copy C:\backups\ubuntu-backup.tar
wsl --import Ubuntu-Copy C:\WSL\Ubuntu-Copy C:\backups\ubuntu-backup.tar --version 2
```

## Configuration (.wslconfig)

Global settings for WSL 2 are stored in `%UserProfile%\.wslconfig` (Windows). create this file to limit resource usage.

```ini
[wsl2]
memory=4GB                  # Limit VM memory to 4GB
processors=2                # Limit to 2 virtual processors
swap=2GB                    # Limit swap space
localhostForwarding=true    # Allow accessing localhost ports
```
To apply changes, run `wsl --shutdown`.

## Networking

### Find IP Address
```bash
ip addr show eth0          # Get Linux IP
ip route show default      # Get Windows Host IP (Gateway)
```

### Port Forwarding (PowerShell)
If you need to access a WSL port from an external machine (not just localhost).
```powershell
netsh interface portproxy add v4tov4 listenport=3000 listenaddress=0.0.0.0 connectport=3000 connectaddress=<WSL_IP>
```

## Troubleshooting

### Restart WSL Service
If WSL is stuck, you can restart the service from PowerShell (Admin).
```powershell
Get-Service LxssManager | Restart-Service
```

### Reset Password
If you forgot your Linux password:
1. Open PowerShell.
2. Log in as root: `wsl -d <Distro> -u root`
3. Reset password: `passwd <username>`

## Quick Reference

| Command | Description |
|---------|-------------|
| `wsl --install` | Install WSL |
| `wsl -l -v` | List installed distros |
| `wsl --shutdown` | Stop all distros |
| `explorer.exe .` | Open in Windows File Explorer |
| `code .` | Open in VS Code |
| `\\wsl$` | Network path to Linux files |
