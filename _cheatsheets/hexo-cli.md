---
layout: cheatsheet
title: Hexo CLI Cheatsheet
description: Hexo is a fast, simple, and powerful blog framework powered by Node.js.
---


Hexo is a fast, simple, and powerful blog framework powered by Node.js.


## Installation

```bash
# Install Hexo CLI globally
npm install -g hexo-cli

# Check version
hexo version
```

## Project Setup

```bash
# Create new blog
hexo init my-blog
cd my-blog
npm install

# Initialize in current directory
hexo init

# Install with specific version
npm install hexo@latest
```

## Development Server

```bash
# Start server
hexo server

# Short form
hexo s

# Serve on custom port
hexo server -p 5000

# Serve drafts
hexo server --draft

# Enable debug mode
hexo server --debug

# Disable opening browser
hexo server --no-open
```

## Content Creation

```bash
# Create new post
hexo new "Post Title"
hexo n "Post Title"

# Create new page
hexo new page "about"

# Create draft
hexo new draft "Draft Title"

# Create with layout
hexo new photo "Photo Post"

# Publish draft
hexo publish draft "Draft Title"
```

## Building

```bash
# Generate static files
hexo generate
hexo g

# Watch for changes
hexo generate --watch
hexo g -w

# Deploy after generation
hexo generate --deploy
hexo g -d

# Force regenerate
hexo generate --force
```

## Deployment

```bash
# Deploy site
hexo deploy
hexo d

# Generate and deploy
hexo deploy --generate
hexo d -g

# Clean and deploy
hexo clean && hexo deploy --generate
```

## Cleaning

```bash
# Clean cache and generated files
hexo clean

# Clean database only
hexo clean --db

# Clean public folder only
hexo clean --public
```

## Themes

```bash
# Install theme
git clone https://github.com/theme/repo themes/theme-name

# Set theme in _config.yml
theme: theme-name

# Update theme
cd themes/theme-name
git pull
```

## Plugins

```bash
# Install plugin
npm install hexo-plugin-name --save

# Common plugins
npm install hexo-generator-sitemap --save
npm install hexo-generator-feed --save
npm install hexo-deployer-git --save
npm install hexo-renderer-pug --save
npm install hexo-renderer-sass --save
```

## Database

```bash
# List all routes
hexo list route

# List all pages
hexo list page

# List all posts
hexo list post

# List all tags
hexo list tag

# List all categories
hexo list category
```

## Migration

```bash
# Migrate from Jekyll
hexo migrate jekyll /path/to/jekyll

# Migrate from Octopress
hexo migrate octopress /path/to/octopress

# Migrate from WordPress
hexo migrate wordpress /path/to/wordpress.xml

# Migrate from RSS
hexo migrate rss /path/to/rss.xml
```

## Configuration

```yaml
# _config.yml basics
title: My Blog
subtitle: Subtitle
description: Description
author: Your Name
language: en
timezone: Asia/Jakarta

# URL
url: https://example.com
root: /
permalink: :year/:month/:day/:title/

# Directory
source_dir: source
public_dir: public
tag_dir: tags
archive_dir: archives
category_dir: categories

# Writing
new_post_name: :title.md
default_layout: post
auto_spacing: true
titlecase: false

# Deployment
deploy:
  type: git
  repo: https://github.com/user/repo.git
  branch: gh-pages
```

## Common Workflows

```bash
# Create and preview post
hexo new "My Post"
hexo server --draft

# Build and deploy
hexo clean
hexo generate --deploy

# Local development
hexo server --draft --debug
```

## Useful Resources

- **Hexo Docs**: https://hexo.io/docs/
- **Hexo Themes**: https://hexo.io/themes/
- **Hexo Plugins**: https://hexo.io/plugins/
