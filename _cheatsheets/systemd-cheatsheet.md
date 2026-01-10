---
layout: cheatsheet
title: Systemd Command Cheatsheet
description: Essential systemd commands for service management
---


A comprehensive reference for systemd service management.

## Service Management

### Basic Commands
```bash
systemctl start service              # Start service
systemctl stop service               # Stop service
systemctl restart service            # Restart service
systemctl reload service             # Reload config without restart
systemctl status service             # Show service status
systemctl enable service             # Enable at boot
systemctl disable service            # Disable at boot
systemctl is-active service          # Check if running
systemctl is-enabled service         # Check if enabled
```

### List Services
```bash
systemctl list-units                 # List all units
systemctl list-units --type=service  # List services only
systemctl list-units --state=running # List running units
systemctl list-units --failed        # List failed units
systemctl list-unit-files            # List all unit files
```

## Unit Files

### Service Unit File
```ini
# /etc/systemd/system/myapp.service
[Unit]
Description=My Application
After=network.target

[Service]
Type=simple
User=myuser
WorkingDirectory=/opt/myapp
ExecStart=/usr/bin/node /opt/myapp/server.js
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### Service Types
```ini
Type=simple                          # Default, main process
Type=forking                         # Forks and exits
Type=oneshot                         # Runs once and exits
Type=notify                          # Sends notification when ready
Type=idle                            # Delays until other jobs finish
```

### Restart Options
```ini
Restart=no                           # Don't restart
Restart=always                       # Always restart
Restart=on-failure                   # Restart on failure
Restart=on-abnormal                  # Restart on abnormal exit
RestartSec=5                         # Wait 5 seconds before restart
```

## Journalctl (Logs)

### View Logs
```bash
journalctl                           # All logs
journalctl -u service                # Service logs
journalctl -u service -f             # Follow logs
journalctl -u service --since today  # Today's logs
journalctl -u service --since "2024-01-01"  # Since date
journalctl -u service --since "1 hour ago"  # Last hour
journalctl -u service -n 50          # Last 50 lines
journalctl -u service -p err         # Error level only
journalctl -k                        # Kernel messages
journalctl -b                        # Current boot
journalctl -b -1                     # Previous boot
```

### Log Management
```bash
journalctl --disk-usage              # Show disk usage
journalctl --vacuum-size=100M        # Limit to 100MB
journalctl --vacuum-time=2weeks      # Keep 2 weeks
```

## Timers

### Timer Unit File
```ini
# /etc/systemd/system/backup.timer
[Unit]
Description=Daily Backup Timer

[Timer]
OnCalendar=daily
OnCalendar=*-*-* 02:00:00            # 2 AM daily
Persistent=true

[Install]
WantedBy=timers.target
```

### Timer Commands
```bash
systemctl list-timers                # List all timers
systemctl list-timers --all          # Include inactive
systemctl start timer                # Start timer
systemctl enable timer               # Enable timer
```

### Timer Syntax
```ini
OnCalendar=hourly                    # Every hour
OnCalendar=daily                     # Every day
OnCalendar=weekly                    # Every week
OnCalendar=monthly                   # Every month
OnCalendar=*-*-* 00:00:00           # Midnight
OnCalendar=Mon *-*-* 00:00:00       # Monday midnight
OnBootSec=15min                      # 15 min after boot
OnUnitActiveSec=1h                   # 1 hour after last activation
```

## System Control

### Power Management
```bash
systemctl poweroff                   # Shutdown
systemctl reboot                     # Reboot
systemctl suspend                    # Suspend
systemctl hibernate                  # Hibernate
```

### System State
```bash
systemctl get-default                # Show default target
systemctl set-default multi-user.target  # Set default target
systemctl isolate multi-user.target  # Switch to target
systemctl list-dependencies          # Show dependencies
```

## Targets

### Common Targets
```bash
systemctl isolate rescue.target      # Rescue mode
systemctl isolate multi-user.target  # Multi-user (no GUI)
systemctl isolate graphical.target   # Graphical mode
```

## Configuration

### Reload Systemd
```bash
systemctl daemon-reload              # Reload unit files
systemctl reset-failed               # Reset failed units
```

### Edit Unit Files
```bash
systemctl edit service               # Create override
systemctl edit --full service        # Edit full file
systemctl cat service                # Show unit file
```

### Override Example
```ini
# /etc/systemd/system/service.service.d/override.conf
[Service]
Environment="VAR=value"
```

## Environment Variables

### Set Environment
```ini
[Service]
Environment="VAR1=value1"
Environment="VAR2=value2"
EnvironmentFile=/etc/myapp/env
```

## Resource Limits

### Limit Resources
```ini
[Service]
MemoryLimit=512M
CPUQuota=50%
TasksMax=100
LimitNOFILE=65536
```

## Dependencies

### Unit Dependencies
```ini
[Unit]
Requires=network.target              # Hard dependency
Wants=network.target                 # Soft dependency
After=network.target                 # Start after
Before=network.target                # Start before
Conflicts=other.service              # Cannot run together
```

## Troubleshooting

### Debug Service
```bash
systemctl status service -l          # Full status
journalctl -u service -xe            # Extended logs
systemctl show service               # Show all properties
systemctl list-dependencies service  # Show dependencies
```

### Common Issues
```bash
# Permission denied
sudo systemctl status service

# Unit not found
systemctl daemon-reload

# Failed to start
journalctl -u service -n 50
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `systemctl start <service>` | Start service |
| `systemctl stop <service>` | Stop service |
| `systemctl restart <service>` | Restart service |
| `systemctl status <service>` | Service status |
| `systemctl enable <service>` | Enable at boot |
| `journalctl -u <service>` | View logs |
| `journalctl -f` | Follow logs |
| `systemctl daemon-reload` | Reload configs |

## Best Practices

1. **Use systemd for all services**
2. **Enable services** for auto-start
3. **Set restart policies** for reliability
4. **Use timers** instead of cron
5. **Monitor logs** with journalctl
6. **Set resource limits** to prevent abuse
7. **Use dependencies** correctly
8. **Test services** before enabling
9. **Document custom units**
10. **Keep logs manageable** with vacuum

## Resources

- Systemd Manual: https://www.freedesktop.org/software/systemd/man/
- ArchWiki Systemd: https://wiki.archlinux.org/title/Systemd
- Digital Ocean Guide: https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal
