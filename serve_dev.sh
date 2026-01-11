#!/bin/bash
echo "🚧 Starting Jekyll + Tailwind in development mode..."
npx concurrently "npm run watch:css" "bundle exec jekyll serve --livereload --config _config.yml,_config_dev.yml"