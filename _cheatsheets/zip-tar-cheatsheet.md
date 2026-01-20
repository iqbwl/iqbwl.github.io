---
layout: cheatsheet
title: Zip & Tar Command Cheatsheet
description: zip and tar are common file archiving and compression utilities.
---

zip and tar are common file archiving and compression utilities.


## Zip (Compress & Extract)

### Compression
```bash
zip archive.zip file.txt               # Compress a single file
zip -r archive.zip directory/          # Compress a directory recursively
zip -r archive.zip dir1 dir2 file.txt  # Compress multiple files/directories
zip -e archive.zip file.txt            # Password protect zip file
zip -0 archive.zip file.txt            # Store only (no compression)
zip -9 archive.zip file.txt            # Best compression
```

### Extraction
```bash
unzip archive.zip                      # Extract to current directory
unzip archive.zip -d /path/to/dest     # Extract to specific directory
unzip -l archive.zip                   # List contents without extracting
unzip -t archive.zip                   # Test archive integrity
```

## Tar (Tape Archive)

### General Options
- `-c`: Create an archive
- `-x`: Extract an archive
- `-v`: Verbose (show progress)
- `-f`: Filename (must be last)
- `-z`: Gzip compression (`.tar.gz`)
- `-j`: Bzip2 compression (`.tar.bz2`)
- `-J`: Xz compression (`.tar.xz`)

### Create Archive
```bash
tar -cvf archive.tar directory/        # Create uncompressed tar
tar -czvf archive.tar.gz directory/    # Create .tar.gz (Gzip)
tar -cjvf archive.tar.bz2 directory/   # Create .tar.bz2 (Bzip2)
tar -cJvf archive.tar.xz directory/    # Create .tar.xz (Xz)
```

### Extract Archive
```bash
tar -xvf archive.tar                   # Extract .tar
tar -xzvf archive.tar.gz               # Extract .tar.gz
tar -xjvf archive.tar.bz2              # Extract .tar.bz2
tar -xJvf archive.tar.xz               # Extract .tar.xz
tar -xvf archive.tar -C /path/to/dest  # Extract to specific directory
```

### List & View
```bash
tar -tvf archive.tar                   # List contents of .tar
tar -tzvf archive.tar.gz               # List contents of .tar.gz
```

## Other Common Commands

### Gzip
```bash
gzip file.txt                          # Compress file (replaces original)
gunzip file.txt.gz                     # Decompress file
gzip -d file.txt.gz                    # Same as gunzip
```
