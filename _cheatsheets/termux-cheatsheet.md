---
layout: cheatsheet
title: Termux Android Cheatsheet
description: Termux is an Android terminal emulator and Linux environment app that works directly with no rooting or setup required.
---


Termux is an Android terminal emulator and Linux environment app that works directly with no rooting or setup required.


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

