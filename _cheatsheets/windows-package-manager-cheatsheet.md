---
layout: cheatsheet
title: Windows Package Manager Cheatsheet
description: Essential commands for Winget and Chocolatey
---


A quick reference for managing software on Windows using Winget and Chocolatey.

## Winget (Windows Package Manager)

### Install & Uninstall
```powershell
winget install <id>              # Install package
winget install <id> --silent     # Silent install
winget install <id> -v <version> # Install specific version
winget uninstall <id>            # Uninstall package
```

### Search & List
```powershell
winget search <query>            # Search for packages
winget list                      # List installed packages
winget show <id>                 # Show package details
```

### Updates
```powershell
winget upgrade                   # List available upgrades
winget upgrade <id>              # Upgrade specific package
winget upgrade --all             # Upgrade all packages
```

### Sources & Settings
```powershell
winget source list               # List sources
winget source update             # Update sources
winget settings                  # Open settings (JSON)
winget export -o list.json       # Export installed packages
winget import -i list.json       # Install from export
```

## Chocolatey (Choco)

### Install & Uninstall
```powershell
choco install <pkg>              # Install package
choco install <pkg> -y           # Install without confirmation
choco install <pkg> --version 1.0 # Install version
choco uninstall <pkg>            # Uninstall package
```

### Search & List
```powershell
choco search <query>             # Search packages
choco list --local-only          # List installed packages
choco info <pkg>                 # Show package info
```

### Updates
```powershell
choco outdated                   # Check for updates
choco upgrade <pkg>              # Upgrade package
choco upgrade all -y             # Upgrade all packages
```

### Advanced
```powershell
choco pin add -n=<pkg>           # Pin package (skip updates)
choco pin list                   # List pinned packages
choco feature list               # List config features
choco clean                      # Clean cache
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `winget install <id>` | Install App (Winget) |
| `winget upgrade --all` | Update All (Winget) |
| `choco install <pkg> -y` | Install App (Choco) |
| `choco upgrade all -y` | Update All (Choco) |
