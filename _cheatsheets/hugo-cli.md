---
layout: cheatsheet
title: Hugo CLI Cheatsheet
description: Essential commands for Hugo static site generator
---

{% raw %}

# Hugo CLI Cheatsheet

Essential commands for Hugo static site generator - the world's fastest framework for building websites.

## Installation

```bash
# macOS
brew install hugo

# Ubuntu/Debian
sudo apt-get install hugo

# Arch Linux
sudo pacman -S hugo

# Windows (Chocolatey)
choco install hugo

# From source
go install github.com/gohugoio/hugo@latest

# Check version
hugo version
```

## Project Setup

### Create New Site
```bash
# Create new site
hugo new site my-site

# Create with specific format
hugo new site my-site --format yaml
hugo new site my-site --format toml
hugo new site my-site --format json

# Force creation in non-empty directory
hugo new site my-site --force
```

### Initialize Git
```bash
cd my-site
git init
```

## Development Server

### Basic Server
```bash
# Start development server
hugo server

# Short form
hugo serve

# Serve with drafts
hugo server -D

# Serve with future posts
hugo server -F

# Serve with expired posts
hugo server -E

# Serve all content (drafts, future, expired)
hugo server -DFE
```

### Advanced Server Options
```bash
# Serve on specific port
hugo server --port 1314

# Serve on specific bind address
hugo server --bind 0.0.0.0

# Serve with live reload disabled
hugo server --disableLiveReload

# Fast render mode (only rebuild changed pages)
hugo server --disableFastRender

# Navigate to changed content
hugo server --navigateToChanged

# Render to memory (faster)
hugo server --renderToMemory

# Enable verbose logging
hugo server --verbose

# Enable debug logging
hugo server --debug
```

## Building

### Basic Build
```bash
# Build site
hugo

# Build with drafts
hugo -D

# Build with future posts
hugo -F

# Build with expired posts
hugo -E

# Build all content
hugo -DFE
```

### Production Build
```bash
# Build for production (minify)
hugo --minify

# Build to custom destination
hugo --destination /path/to/output

# Build with specific base URL
hugo --baseURL https://example.com

# Build with environment
hugo --environment production

# Clean before build
hugo --cleanDestinationDir
```

### Build Options
```bash
# Enable garbage collection
hugo --gc

# Show build stats
hugo --templateMetrics

# Profile build
hugo --profile

# Verbose output
hugo --verbose

# Quiet mode
hugo --quiet
```

## Content Management

### Create Content
```bash
# Create new post
hugo new posts/my-post.md

# Create new page
hugo new about.md

# Create in section
hugo new blog/my-article.md

# Create with archetype
hugo new posts/my-post.md --kind post

# Create from specific archetype
hugo new --kind tutorial tutorials/my-tutorial.md
```

### List Content
```bash
# List all content
hugo list all

# List drafts
hugo list drafts

# List future posts
hugo list future

# List expired posts
hugo list expired
```

## Themes

### Install Theme
```bash
# Add theme as git submodule
git submodule add https://github.com/user/theme.git themes/theme-name

# Or clone directly
git clone https://github.com/user/theme.git themes/theme-name

# Set theme in config
echo 'theme = "theme-name"' >> config.toml
```

### Use Theme
```bash
# Serve with specific theme
hugo server --theme theme-name

# Build with specific theme
hugo --theme theme-name
```

### Update Theme
```bash
# Update all submodules
git submodule update --remote --merge

# Update specific theme
git submodule update --remote themes/theme-name
```

## Modules

### Initialize Module
```bash
# Initialize Hugo module
hugo mod init github.com/user/repo

# Add module dependency
hugo mod get github.com/user/theme

# Update modules
hugo mod get -u

# Tidy modules
hugo mod tidy

# Verify modules
hugo mod verify

# Clean module cache
hugo mod clean
```

### Module Commands
```bash
# Show module graph
hugo mod graph

# Show module vendor
hugo mod vendor

# Get specific version
hugo mod get github.com/user/theme@v1.2.3
```

## Configuration

### Config Commands
```bash
# Show config
hugo config

# Show config in JSON
hugo config --format json

# Show config in YAML
hugo config --format yaml

# Mount config
hugo config mounts
```

### Environment
```bash
# Set environment
hugo --environment production
hugo --environment staging

# Use environment-specific config
# config/production/config.toml
# config/staging/config.toml
```

## Data & Content

### Import Data
```bash
# Import from Jekyll
hugo import jekyll /path/to/jekyll /path/to/hugo

# Convert content
hugo convert toYAML
hugo convert toTOML
hugo convert toJSON
```

## Deployment

### Build for Deployment
```bash
# Production build
hugo --minify --cleanDestinationDir

# Build with specific base URL
hugo --baseURL https://example.com --minify

# Build and show stats
hugo --minify --templateMetrics
```

## Optimization

### Performance
```bash
# Minify output
hugo --minify

# Enable garbage collection
hugo --gc

# Cache directory
hugo --cacheDir /tmp/hugo_cache

# Ignore cache
hugo --ignoreCache
```

## Debugging

### Debug Commands
```bash
# Verbose output
hugo --verbose

# Debug mode
hugo --debug

# Show template metrics
hugo --templateMetrics

# Log level
hugo --logLevel info
hugo --logLevel debug

# Print path warnings
hugo --printPathWarnings

# Print unused templates
hugo --printUnusedTemplates
```

## Maintenance

### Clean
```bash
# Clean generated files
hugo --cleanDestinationDir

# Clean cache
hugo mod clean

# Remove public directory
rm -rf public
```

### Update
```bash
# Update Hugo
brew upgrade hugo  # macOS
sudo apt-get update && sudo apt-get upgrade hugo  # Ubuntu

# Update modules
hugo mod get -u
hugo mod tidy
```

## Common Workflows

### New Blog Post
```bash
# Create post
hugo new posts/$(date +%Y-%m-%d)-my-post.md

# Edit post
$EDITOR content/posts/$(date +%Y-%m-%d)-my-post.md

# Preview with drafts
hugo server -D

# Build when ready
hugo --minify
```

### Local Development
```bash
# Start server with all content
hugo server -DFE --disableFastRender

# In watch mode (automatic)
hugo server --watch
```

### Production Deployment
```bash
# Clean and build
rm -rf public
hugo --minify --cleanDestinationDir

# Deploy to server
rsync -avz --delete public/ user@server:/var/www/html/
```

## Shortcodes

### Built-in Shortcodes
```markdown
<!-- Figure -->
{{< figure src="/img/photo.jpg" title="Title" >}}

<!-- YouTube -->
{{< youtube VIDEO_ID >}}

<!-- Vimeo -->
{{< vimeo VIDEO_ID >}}

<!-- Tweet -->
{{< tweet TWEET_ID >}}

<!-- Instagram -->
{{< instagram POST_ID >}}

<!-- Gist -->
{{< gist USERNAME GIST_ID >}}

<!-- Highlight -->
{{< highlight go >}}
code here
{{< /highlight >}}

<!-- Ref -->
{{< ref "page.md" >}}

<!-- Relref -->
{{< relref "page.md" >}}
```

## Useful Aliases

```bash
# Add to .bashrc or .zshrc
alias hs='hugo server -D'
alias hb='hugo --minify'
alias hn='hugo new'
alias hc='hugo --cleanDestinationDir'
```

## Configuration Examples

### config.toml
```toml
baseURL = "https://example.com"
languageCode = "en-us"
title = "My Hugo Site"
theme = "my-theme"

[params]
  description = "Site description"
  author = "Author Name"

[menu]
  [[menu.main]]
    name = "Home"
    url = "/"
    weight = 1
  [[menu.main]]
    name = "Blog"
    url = "/blog/"
    weight = 2

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true
```

## Useful Resources

- **Hugo Docs**: https://gohugo.io/documentation/
- **Hugo Themes**: https://themes.gohugo.io/
- **Hugo Discourse**: https://discourse.gohugo.io/
- **Hugo GitHub**: https://github.com/gohugoio/hugo
- **Hugo Modules**: https://gohugo.io/hugo-modules/
{% endraw %}
