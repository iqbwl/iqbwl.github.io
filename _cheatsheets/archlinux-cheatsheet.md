---
layout: cheatsheet
title: Arch Linux Cheatsheet
description: Arch Linux is a lightweight and flexible Linux distribution that adheres to the KISS (Keep It Simple, Stupid) principle.
---


Arch Linux is a lightweight and flexible Linux distribution that adheres to the KISS (Keep It Simple, Stupid) principle.


## Pacman (Official Repositories)

### Operations
```bash
sudo pacman -Syu             # Sync refresh and upgrade system
sudo pacman -S package       # Install package
sudo pacman -S --needed pkg  # Install if not present
sudo pacman -R package       # Remove package
sudo pacman -Rs package      # Remove package and unused dependencies
sudo pacman -Rns package     # Remove package, dependencies, and config
sudo pacman -Si package      # Info about package
sudo pacman -Ss keyword      # Search for package
```

### Maintenance
```bash
sudo pacman -Sc              # Clear uninstalled package cache
sudo pacman -Scc             # Clear ALL package cache
sudo pacman -Qdt             # List orphans
sudo pacman -Rns $(pacman -Qdtq) # Remove all orphans
checkupdates                 # Check for updates (without syncing)
paccache -r                  # Clear cache (keep last 3 versions)
```

## AUR Helpers (Yay / Paru)

Common commands for popular AUR helpers.

### Install Yay (from AUR)
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Install Paru (from AUR)
```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### Yay
```bash
yay                          # Update system and AUR packages
yay -S package               # Install AUR package
yay -Rns package             # Remove package
yay -Ps                      # Print system stats
yay -Yc                      # Clean unused dependencies
yay -Scc                     # Clean cache
```

### Paru
```bash
paru                         # Update system and AUR packages
paru -S package              # Install AUR package
paru -Hua                    # Upgrade AUR packages only
paru -c                      # Clean cache
paru --clean                 # Remove unneeded dependencies
```

## Flatpak

### Management
```bash
flatpak install package      # Install package
flatpak list                 # List installed packages
flatpak update               # Update all packages
flatpak uninstall package    # Remove package
flatpak search keyword       # Search for package
flatpak run com.org.app      # Run application
```

### Maintenance
```bash
flatpak uninstall --unused   # Remove unused runtimes
flatpak repair               # Repair installation
flatpak remotes              # List remotes (repositories)
```

## System Maintenance

### Mirrors & Keys
```bash
# Update mirrors (requires reflector)
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Keyring management
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
```

### Logs & Info
```bash
lsblk                        # List block devices
uname -a                     # Kernel info
cat /etc/os-release          # OS info
journalctl -p 3 -xb          # Show errors from current boot
systemctl list-units --failed # Show failed services
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `pacman -Syu` | Full system upgrade |
| `pacman -S pkg` | Install package |
| `pacman -Rns pkg` | Remove package & deps |
| `yay -S pkg` | Install from AUR |
| `flatpak update` | Update Flatpaks |
| `lsblk` | List disks/partitions |
