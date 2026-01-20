---
layout: cheatsheet
title: Windows CMD Cheatsheet
description: CMD (Command Prompt) is the default command-line interpreter for the Microsoft Windows operating system.
---


CMD (Command Prompt) is the default command-line interpreter for the Microsoft Windows operating system.


## File & Directory Management

### Navigation
```cmd
dir                :: List files and directories
dir /a:h           :: List hidden files
cd \path\to\dir    :: Change directory
cd ..              :: Go up one level
cd /d D:           :: Change drive and directory
f:                 :: Switch to F: drive
tree               :: Graphically display directory structure
```

### File Operations
```cmd
copy file.txt new.txt      :: Copy file
xcopy /s /e source dest    :: Copy directory tree (robust)
robocopy source dest /mir  :: Robust File Copy (Mirror) - Best for backups
move file.txt folder\      :: Move file
ren old.txt new.txt        :: Rename file
del file.txt               :: Delete file
del /q *                   :: Delete all files quietly
type file.txt              :: Display file content
attrib +h file.txt         :: Make file hidden
```

### Directory Operations
```cmd
md foldername              :: Make directory (mkdir)
rd foldername              :: Remove directory (rmdir)
rd /s /q foldername        :: Remove directory tree quietly
```

