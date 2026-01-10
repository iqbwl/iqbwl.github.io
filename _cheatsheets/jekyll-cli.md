---
layout: cheatsheet
title: Jekyll CLI Cheatsheet
description: Essential commands for Jekyll static site generator
---


Essential commands for Jekyll static site generator.

## Installation

```bash
# Install Ruby (prerequisite)
# Ubuntu/Debian
sudo apt-get install ruby-full build-essential zlib1g-dev

# macOS
brew install ruby

# Install Jekyll and Bundler
gem install jekyll bundler

# Check version
jekyll --version
```

## Project Setup

### Create New Site
```bash
# Create new Jekyll site
jekyll new my-site

# Create in current directory
jekyll new .

# Create with specific version
jekyll _4.3.2_ new my-site

# Create blank site (minimal)
jekyll new my-site --blank

# Skip bundle install
jekyll new my-site --skip-bundle
```

### Initialize Existing Project
```bash
# Install dependencies
bundle install

# Update dependencies
bundle update

# Install specific gem
bundle add jekyll-seo-tag
```

## Development Server

### Basic Server
```bash
# Start development server
jekyll serve

# Serve with live reload
jekyll serve --livereload

# Serve on specific port
jekyll serve --port 4001

# Serve on all interfaces
jekyll serve --host 0.0.0.0

# Serve with drafts
jekyll serve --drafts

# Serve with future posts
jekyll serve --future

# Serve with unpublished posts
jekyll serve --unpublished
```

### Advanced Server Options
```bash
# Incremental build
jekyll serve --incremental

# Force polling (for Docker/VM)
jekyll serve --force_polling

# Detach server
jekyll serve --detach

# Skip initial build
jekyll serve --skip-initial-build

# Show directory listing
jekyll serve --show-dir-listing

# Disable disk cache
jekyll serve --disable-disk-cache

# Enable verbose output
jekyll serve --verbose

# Quiet mode
jekyll serve --quiet
```

## Building

### Basic Build
```bash
# Build site
jekyll build

# Build to custom destination
jekyll build --destination /path/to/output

# Build with drafts
jekyll build --drafts

# Build with future posts
jekyll build --future

# Watch for changes
jekyll build --watch

# Incremental build
jekyll build --incremental
```

### Production Build
```bash
# Build for production
JEKYLL_ENV=production jekyll build

# Build with specific config
jekyll build --config _config.yml,_config_prod.yml

# Build with profile
jekyll build --profile

# Build with trace
jekyll build --trace
```

## Content Management

### Posts
```bash
# Create new post (manual)
touch _posts/$(date +%Y-%m-%d)-my-post.md

# Post filename format
_posts/YYYY-MM-DD-title.md
```

### Drafts
```bash
# Create draft
mkdir -p _drafts
touch _drafts/my-draft.md

# Preview drafts
jekyll serve --drafts

# Publish draft (move to _posts)
mv _drafts/my-draft.md _posts/$(date +%Y-%m-%d)-my-draft.md
```

### Pages
```bash
# Create page
touch about.md

# Create page in subdirectory
mkdir -p pages
touch pages/contact.md
```

### Collections
```bash
# Create collection directory
mkdir -p _my_collection

# Add to _config.yml
collections:
  my_collection:
    output: true
```

## Themes

### Install Theme
```bash
# Add theme to Gemfile
bundle add minima

# Or add to _config.yml
theme: minima

# Install theme
bundle install
```

### Remote Themes (GitHub Pages)
```bash
# Add to Gemfile
gem "jekyll-remote-theme"

# Add to _config.yml plugins
plugins:
  - jekyll-remote-theme

# Set remote theme
remote_theme: owner/repo

# Install
bundle install
```

### Theme Customization
```bash
# Show theme location
bundle info minima

# Copy theme files to override
cp -r $(bundle info minima --path)/_layouts .
cp -r $(bundle info minima --path)/_includes .
cp -r $(bundle info minima --path)/_sass .
```

## Plugins

### Install Plugins
```bash
# Add to Gemfile
gem "jekyll-sitemap"
gem "jekyll-seo-tag"
gem "jekyll-feed"

# Install
bundle install

# Add to _config.yml
plugins:
  - jekyll-sitemap
  - jekyll-seo-tag
  - jekyll-feed
```

### Common Plugins
```bash
# SEO
bundle add jekyll-seo-tag

# Sitemap
bundle add jekyll-sitemap

# RSS Feed
bundle add jekyll-feed

# Pagination
bundle add jekyll-paginate

# Archives
bundle add jekyll-archives

# GitHub Pages
bundle add github-pages
```

## Configuration

### Multiple Configs
```bash
# Use multiple config files
jekyll serve --config _config.yml,_config_dev.yml

# Production config
jekyll build --config _config.yml,_config_prod.yml
```

### Environment Variables
```bash
# Set environment
JEKYLL_ENV=production jekyll build

# Custom variables
MY_VAR=value jekyll build

# Use in templates
{{ site.environment }}
```

## Data Files

### Working with Data
```bash
# Create data directory
mkdir -p _data

# Add YAML data
touch _data/members.yml

# Add JSON data
touch _data/products.json

# Add CSV data
touch _data/items.csv

# Access in templates
{{ site.data.members }}
```

## Assets & Static Files

### Asset Pipeline
```bash
# Create assets directory
mkdir -p assets/{css,js,images}

# Using Sass
mkdir -p _sass
touch assets/css/main.scss
```

### Minification
```bash
# Install jekyll-minifier
bundle add jekyll-minifier

# Add to _config.yml
plugins:
  - jekyll-minifier
```

## Deployment

### GitHub Pages
```bash
# Add GitHub Pages gem
bundle add github-pages

# Build for GitHub Pages
JEKYLL_ENV=production bundle exec jekyll build

# Push to GitHub
git add .
git commit -m "Update site"
git push origin main
```

### Netlify
```bash
# Create netlify.toml
cat > netlify.toml << EOF
[build]
  command = "jekyll build"
  publish = "_site"

[build.environment]
  JEKYLL_ENV = "production"
EOF
```

### Custom Server
```bash
# Build site
JEKYLL_ENV=production jekyll build

# Copy to server
rsync -avz _site/ user@server:/var/www/html/

# Or use SCP
scp -r _site/* user@server:/var/www/html/
```

## Testing & Debugging

### HTML Proofer
```bash
# Install
bundle add html-proofer

# Test site
bundle exec htmlproofer ./_site

# Test with options
bundle exec htmlproofer ./_site --disable-external --allow-hash-href
```

### Debug Mode
```bash
# Verbose output
jekyll build --verbose

# Show full trace
jekyll build --trace

# Profile build time
jekyll build --profile

# Liquid profiler
jekyll build --profile --liquid-profile
```

## Maintenance

### Clean
```bash
# Clean generated files
jekyll clean

# Clean and build
jekyll clean && jekyll build
```

### Update
```bash
# Update all gems
bundle update

# Update Jekyll only
bundle update jekyll

# Update specific gem
bundle update jekyll-seo-tag

# Check outdated gems
bundle outdated
```

## Common Workflows

### New Blog Post
```bash
# Create post
touch _posts/$(date +%Y-%m-%d)-my-new-post.md

# Add frontmatter
cat > _posts/$(date +%Y-%m-%d)-my-new-post.md << EOF
---
layout: post
title: "My New Post"
date: $(date +%Y-%m-%d)
categories: blog
---

Content here...
EOF

# Preview
jekyll serve --drafts
```

### Local Development
```bash
# Start with live reload
bundle exec jekyll serve --livereload --drafts

# In another terminal, watch for changes
# (automatic with --livereload)
```

### Production Build
```bash
# Clean old files
jekyll clean

# Build for production
JEKYLL_ENV=production bundle exec jekyll build

# Test build
bundle exec htmlproofer ./_site --disable-external

# Deploy
# (copy _site/ to server)
```

## Troubleshooting

### Common Issues
```bash
# Dependency errors
bundle install
bundle update

# Permission errors
gem install jekyll --user-install

# Port already in use
jekyll serve --port 4001

# Regeneration not working
jekyll serve --force_polling

# Clear cache
jekyll clean
rm -rf .jekyll-cache
```

### Gemfile.lock Issues
```bash
# Remove lock file
rm Gemfile.lock

# Reinstall
bundle install
```

## Useful Aliases

```bash
# Add to .bashrc or .zshrc
alias jk='bundle exec jekyll'
alias jks='bundle exec jekyll serve --livereload'
alias jkb='JEKYLL_ENV=production bundle exec jekyll build'
alias jkc='bundle exec jekyll clean'
alias jkd='bundle exec jekyll serve --drafts --livereload'
```

## Configuration Examples

### Basic _config.yml
```yaml
title: My Site
description: Site description
baseurl: ""
url: "https://example.com"

markdown: kramdown
theme: minima

plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap

exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor
```

## Useful Resources

- **Jekyll Docs**: https://jekyllrb.com/docs/
- **Jekyll Themes**: https://jekyllthemes.io/
- **GitHub Pages**: https://pages.github.com/
- **Liquid Syntax**: https://shopify.github.io/liquid/
- **Jekyll Talk**: https://talk.jekyllrb.com/
