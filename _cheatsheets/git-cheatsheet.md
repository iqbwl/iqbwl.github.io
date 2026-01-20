---
layout: cheatsheet
title: Git Command Cheatsheet
description: Git is a free and open-source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.
---


Git is a free and open-source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.


## Configuration

### Setup
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global core.editor vim
git config --list                    # Show all settings
git config user.name                 # Show specific setting
```

## Repository Basics

### Initialize & Clone
```bash
git init                             # Initialize new repo
git clone <url>                      # Clone repository
git clone <url> <directory>          # Clone to specific directory
git clone --depth 1 <url>            # Shallow clone (last commit only)
```

## Basic Workflow

### Status & Changes
```bash
git status                           # Show working tree status
git status -s                        # Short status
git diff                             # Show unstaged changes
git diff --staged                    # Show staged changes
git diff HEAD                        # Show all changes since last commit
```

### Add & Commit
```bash
git add <file>                       # Stage specific file
git add .                            # Stage all changes
git add -A                           # Stage all (including deletions)
git add -p                           # Interactive staging

git commit -m "message"              # Commit with message
git commit -am "message"             # Stage and commit (tracked files)
git commit --amend                   # Amend last commit
git commit --amend --no-edit         # Amend without changing message
```

## Branching

### Branch Management
```bash
git branch                           # List local branches
git branch -a                        # List all branches (including remote)
git branch <name>                    # Create new branch
git branch -d <name>                 # Delete branch (safe)
git branch -D <name>                 # Force delete branch
git branch -m <old> <new>            # Rename branch
```

### Switching Branches
```bash
git checkout <branch>                # Switch to branch
git checkout -b <branch>             # Create and switch to branch
git switch <branch>                  # Switch to branch (newer)
git switch -c <branch>               # Create and switch (newer)
```

## Merging

### Merge Operations
```bash
git merge <branch>                   # Merge branch into current
git merge --no-ff <branch>           # Merge with merge commit
git merge --squash <branch>          # Squash merge
git merge --abort                    # Abort merge
```

## Rebasing

### Rebase Commands
```bash
git rebase <branch>                  # Rebase current branch
git rebase -i HEAD~3                 # Interactive rebase last 3 commits
git rebase --continue                # Continue after resolving conflicts
git rebase --abort                   # Abort rebase
git rebase --skip                    # Skip current commit
```

## Remote Operations

### Remote Management
```bash
git remote                           # List remotes
git remote -v                        # List remotes with URLs
git remote add <name> <url>          # Add remote
git remote remove <name>             # Remove remote
git remote rename <old> <new>        # Rename remote
git remote show <name>               # Show remote info
```

### Fetch & Pull
```bash
git fetch                            # Fetch from origin
git fetch <remote>                   # Fetch from specific remote
git fetch --all                      # Fetch from all remotes
git fetch --prune                    # Remove deleted remote branches

git pull                             # Fetch and merge
git pull --rebase                    # Fetch and rebase
git pull <remote> <branch>           # Pull from specific remote/branch
```

### Push
```bash
git push                             # Push to origin
git push <remote> <branch>           # Push to specific remote/branch
git push -u origin <branch>          # Push and set upstream
git push --all                       # Push all branches
git push --tags                      # Push all tags
git push --force                     # Force push (dangerous!)
git push --force-with-lease          # Safer force push
```

## Stashing

### Stash Operations
```bash
git stash                            # Stash changes
git stash save "message"             # Stash with message
git stash list                       # List stashes
git stash show                       # Show latest stash
git stash show -p                    # Show latest stash diff
git stash apply                      # Apply latest stash
git stash apply stash@{n}            # Apply specific stash
git stash pop                        # Apply and remove latest stash
git stash drop                       # Remove latest stash
git stash clear                      # Remove all stashes
```

## History

### Log & History
```bash
git log                              # Show commit history
git log --oneline                    # Compact log
git log --graph                      # Show branch graph
git log --all --graph --oneline      # Full graph
git log -n 5                         # Show last 5 commits
git log --author="name"              # Filter by author
git log --since="2 weeks ago"        # Filter by date
git log --grep="pattern"             # Search commit messages
git log -p                           # Show patches
git log --stat                       # Show stats
git log <file>                       # Show history for file
```

### Show & Diff
```bash
git show <commit>                    # Show commit details
git show <commit>:<file>             # Show file at commit
git diff <commit1> <commit2>         # Diff between commits
git diff <branch1>..<branch2>        # Diff between branches
```

## Undoing Changes

### Reset
```bash
git reset <file>                     # Unstage file
git reset                            # Unstage all
git reset --soft HEAD~1              # Undo commit, keep changes staged
git reset --mixed HEAD~1             # Undo commit, keep changes unstaged
git reset --hard HEAD~1              # Undo commit, discard changes
git reset --hard <commit>            # Reset to specific commit
```

### Revert
```bash
git revert <commit>                  # Create new commit that undoes changes
git revert HEAD                      # Revert last commit
git revert --no-commit <commit>      # Revert without committing
```

### Clean
```bash
git clean -n                         # Dry run (show what would be deleted)
git clean -f                         # Remove untracked files
git clean -fd                        # Remove untracked files and directories
git clean -fX                        # Remove ignored files
git clean -fx                        # Remove untracked and ignored files
```

## Tags

### Tag Management
```bash
git tag                              # List tags
git tag <name>                       # Create lightweight tag
git tag -a <name> -m "message"       # Create annotated tag
git tag -d <name>                    # Delete tag
git push origin <tag>                # Push tag
git push origin --tags               # Push all tags
git push origin :refs/tags/<tag>     # Delete remote tag
```

## Advanced

### Cherry Pick
```bash
git cherry-pick <commit>             # Apply commit to current branch
git cherry-pick <commit1> <commit2>  # Apply multiple commits
git cherry-pick --continue           # Continue after resolving conflicts
git cherry-pick --abort              # Abort cherry-pick
```

### Bisect
```bash
git bisect start                     # Start bisect
git bisect bad                       # Mark current as bad
git bisect good <commit>             # Mark commit as good
git bisect reset                     # End bisect
```

### Submodules
```bash
git submodule add <url> <path>       # Add submodule
git submodule init                   # Initialize submodules
git submodule update                 # Update submodules
git submodule update --remote        # Update to latest
git clone --recursive <url>          # Clone with submodules
```

## Useful Aliases

### Common Aliases
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.lg "log --graph --oneline --all"
```

## .gitignore

### Common Patterns
```gitignore
# Compiled files
*.class
*.pyc
*.o

# Packages
*.jar
*.war
*.egg

# Logs
*.log
logs/

# OS files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp

# Dependencies
node_modules/
vendor/

# Environment
.env
.env.local
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `git init` | Initialize repository |
| `git clone <url>` | Clone repository |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Commit changes |
| `git push` | Push to remote |
| `git pull` | Pull from remote |
| `git status` | Check status |
| `git log` | View history |
| `git branch` | List branches |
| `git checkout -b <name>` | Create branch |
| `git merge <branch>` | Merge branch |
| `git stash` | Stash changes |

## Common Workflows

### Feature Branch Workflow
```bash
git checkout -b feature/new-feature
# Make changes
git add .
git commit -m "Add new feature"
git push -u origin feature/new-feature
# Create pull request
```

### Hotfix Workflow
```bash
git checkout main
git checkout -b hotfix/bug-fix
# Fix bug
git add .
git commit -m "Fix critical bug"
git checkout main
git merge hotfix/bug-fix
git push
git branch -d hotfix/bug-fix
```

### Sync Fork
```bash
git remote add upstream <original-repo-url>
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Tips

1. **Commit often** with meaningful messages
2. **Pull before push** to avoid conflicts
3. **Use branches** for features and fixes
4. **Review changes** before committing
5. **Write good commit messages** (imperative mood)
6. **Don't commit secrets** or sensitive data
7. **Use .gitignore** properly
8. **Learn to rebase** for cleaner history
9. **Use tags** for releases
10. **Backup important work** before force operations

## Resources

- Official Documentation: https://git-scm.com/doc
- Pro Git Book: https://git-scm.com/book
- Git Cheat Sheet: https://training.github.com/
- Learn Git Branching: https://learngitbranching.js.org/
