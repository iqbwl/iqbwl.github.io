#!/bin/bash
echo "🔍 Previewing site in production mode (no drafts)..."
JEKYLL_ENV=production bundle exec jekyll serve --config _config.yml,_config_prod.yml