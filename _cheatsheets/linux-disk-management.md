---
layout: cheatsheet
title: Linux Disk Management Cheatsheet
description: Essential commands for managing disks, partitions, and filesystems in Linux, including resizing and LVM.
---



Essential commands for managing disks, partitions, and filesystems in Linux, including resizing and LVM.

## Information & Monitoring

### List Block Devices
```bash
lsblk                       # List all block devices
lsblk -f                    # List devices with filesystems
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,UUID  # Custom output
```

### Disk Usage
```bash
df -h                       # Disk free space (human-readable)
df -T                       # Show filesystem type
du -sh /path/to/dir         # Directory size summary
du -h --max-depth=1 /path   # Directory size with depth
ncdu /path                  # Interactive disk usage analyzer (if installed)
```

### Partition Information
```bash
sudo fdisk -l               # List all partitions
sudo gdisk -l /dev/sda      # List partitions (GPT)
sudo parted -l              # List partitions (all devices)
sudo blkid                  # Print block device attributes (UUIDs)
```

## Partition Management

### fdisk (MBR/GPT)
Interactive tool for managing partitions.
```bash
sudo fdisk /dev/sda
# Common commands inside fdisk:
# m - print help
# p - print partition table
# n - add a new partition
# d - delete a partition
# t - change partition type
# w - write table to disk and exit
# q - quit without saving
```

### gdisk (GPT)
GPT fdisk, similar to fdisk but for GPT specialized.
```bash
sudo gdisk /dev/sda
```

### parted (Scriptable)
```bash
sudo parted /dev/sda print
sudo parted /dev/sda mklabel gpt            # Create GPT label
sudo parted /dev/sda mkpart primary ext4 0% 100% # Create partition
sudo parted /dev/sda rm 1                   # Remove partition 1
```

## Resizing

### Growpart
Extend a partition in the partition table to fill available space.
```bash
# Syntax: growpart <device> <partition_number>
sudo growpart /dev/vda 1    # Resize partition 1 on /dev/vda
```

### Filesystem Resizing
After resizing the partition, you must resize the filesystem.

**ext4:**
```bash
sudo resize2fs /dev/vda1
```

**XFS:**
```bash
sudo xfs_growfs /mount/point  # Note: xfs_growfs takes the mount point, not device
```

## Filesystems

### Formatting
```bash
sudo mkfs.ext4 /dev/sdb1    # Format as ext4
sudo mkfs.xfs /dev/sdb1     # Format as XFS
sudo mkfs.vfat /dev/sdb1    # Format as FAT32
mkswap /dev/sdb1            # Initialize swap space
```

### Mounting
```bash
sudo mount /dev/sdb1 /mnt   # Mount partition
sudo umount /mnt            # Unmount
sudo mount -a               # Mount all from /etc/fstab
```

### Check & Repair
```bash
sudo fsck /dev/sdb1         # Check ext4 filesystem (unmounted)
sudo xfs_repair /dev/sdb1   # Repair XFS filesystem (unmounted)
```

## LVM (Logical Volume Manager)

### Physical Volumes (PV)
```bash
sudo pvcreate /dev/sdb1     # Initialize PV
sudo pvdisplay              # Show PVs
sudo pvs                    # Short PV listing
sudo pvremove /dev/sdb1     # Remove PV signature
```

### Volume Groups (VG)
```bash
sudo vgcreate my_vg /dev/sdb1      # Create VG
sudo vgextend my_vg /dev/sdc1      # Add PV to VG
sudo vgdisplay                     # Show VGs
sudo vgs                           # Short VG listing
```

### Logical Volumes (LV)
```bash
sudo lvcreate -n my_lv -L 10G my_vg   # Create 10G LV
sudo lvcreate -n my_lv -l 100%FREE my_vg # Create LV using all space
sudo lvextend -L +5G /dev/my_vg/my_lv  # Extend LV by 5G
sudo lvextend -l +100%FREE /dev/my_vg/my_lv # Extend to max
sudo lvremove /dev/my_vg/my_lv        # Remove LV
sudo lvdisplay                        # Show LVs
sudo lvs                              # Short LV listing
```

### Resizing LVM
To resize an LVM volume and filesystem online:
1. **Extend Physical Volume (if disk grew):**
   ```bash
   sudo pvresize /dev/sdb
   ```
2. **Extend Logical Volume:**
   ```bash
   sudo lvextend -l +100%FREE /dev/my_vg/my_lv
   ```
3. **Resize Filesystem:**
   ```bash
   sudo resize2fs /dev/my_vg/my_lv      # for ext4
   # OR
   sudo xfs_growfs /mount/point         # for xfs
   ```

## Swap

### Management
```bash
sudo mkswap /dev/sdb2       # Set up swap area
sudo swapon /dev/sdb2       # Enable swap
sudo swapoff /dev/sdb2      # Disable swap
free -h                     # Check swap usage
cat /proc/swaps             # List active swaps
```


