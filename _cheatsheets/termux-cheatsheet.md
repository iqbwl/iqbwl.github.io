---
layout: cheatsheet
title: Termux Android Cheatsheet
description: Essential commands for Termux environment on Android
---


A quick reference for Termux, a terminal emulator and Linux environment for Android.

## Package Management

Termux uses `pkg` (a wrapper around `apt`).

```bash
pkg update && pkg upgrade  # Update packages
pkg install git            # Install a package
pkg uninstall git          # Remove a package
pkg search python          # Search for packages
pkg show python            # Show package details
pkg list-installed         # List all installed packages
pkg clean                  # Clean cache
```

---

## Storage & File Access

Accessing Android internal storage requires setup.

```bash
termux-setup-storage       # Request storage permission & create symlink
```

This creates a `~/storage` folder with links to:
- `~/storage/dcim` -> Camera photos
- `~/storage/downloads` -> Downloads folder
- `~/storage/music` -> Music folder
- `~/storage/shared` -> Internal storage root (`/sdcard`)

### Open Files
```bash
termux-open file.pdf       # Open file with default Android app
termux-open https://google.com # Open URL in Android browser
```

---

## Termux API

Requires **Termux:API** app from Play Store/F-Droid and `pkg install termux-api`.

### System Info & Sensors
```bash
termux-battery-status      # Get battery info
termux-camera-info         # Get camera specs
termux-wifi-connectioninfo # WiFi connection details
termux-sensor -l           # List available sensors
termux-sensor -s "Light"   # Read light sensor
```

### Clipboard & Dialogs
```bash
termux-clipboard-get       # Get clipboard content
termux-clipboard-set "Hello" # Set clipboard content
termux-toast "Done!"       # Show Android toast message
termux-notification --title "Alert" --content "Work finished" # Show notification
```

### Hardware Access
```bash
termux-camera-photo -c 0 out.jpg # Take photo with back camera
termux-microphone-record -l 5 rec.mp3 # Record 5s of audio
termux-vibrate -d 1000     # Vibrate for 1000ms
termux-torch on            # Turn on flashlight
termux-torch off           # Turn off flashlight
```

---

## UI Customization

```bash
# Install properties editor
pkg install termux-tools

# Reload settings without restart
termux-reload-settings
```

### Font and Color
To change font/color manually, place files in `~/.termux/`:
- `~/.termux/font.ttf` (Terminal font)
- `~/.termux/colors.properties` (Color scheme)

Using **Termux-Styling** (Add-on app) is easier for switching themes `Long Press > More > Style`.

### Extra Keys Row
Edit `~/.termux/termux.properties` to customize the extra keys row.

```properties
extra-keys = [ \
 ['ESC','/','-','HOME','UP','END','PGUP'], \
 ['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN'] \
]
```

---

## System Access

### SSH Server (Access Termux from PC)
```bash
pkg install openssh
passwd                     # Set a password
sshd                       # Start SSH server (Port 8022 by default)
whoami                     # Check username (usually u0_aXXX)
ifconfig                   # Check IP address

# Connect from PC:
# ssh -p 8022 u0_aXXX@192.168.1.5
```

### Root Access
If your device is rooted:
```bash
pkg install tsu
tsu                        # Switch to root (Su wrapper for Termux)
```

Proot (Simulate root/distros for non-rooted devices):
```bash
pkg install proot-distro
proot-distro list          # List available distros (Ubuntu, Arch, etc.)
proot-distro install ubuntu # Install Ubuntu
proot-distro login ubuntu  # Login to Ubuntu
```
