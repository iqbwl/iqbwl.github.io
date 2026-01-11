#!/bin/bash
echo "🔍 Building CSS and Previewing site in production mode..."
npm run build:css
JEKYLL_ENV=production bundle exec jekyll serve --config _config.yml,_config_prod.yml