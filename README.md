# iqbwl.com

Personal blog built with Jekyll and a custom standalone theme.

[![Netlify Status](https://api.netlify.com/api/v1/badges/e233f5b2-1389-4ec7-b3e9-c4222922e0ef/deploy-status)](https://app.netlify.com/projects/iqbwl/deploys)

## About

A personal digital notebook featuring thoughts, notes, and technical writings. Built with Jekyll 4.4.1 and a custom standalone theme.

**Live Site**: [iqbwl.com](https://iqbwl.com)

## Tech Stack

- **Static Site Generator**: Jekyll 4.4.1
- **Hosting**: Netlify
- **Theme**: Custom standalone theme (Inter font, Glassmorphism header)

## Development

### Setup
```bash
bundle install
```

### Development Server
```bash
./serve_dev.sh
# Server runs at http://localhost:5000
```

### Deployment
```bash
./deploy.sh "commit message"
```

## Project Structure

```
iqbwl.com/
├── _config.yml           # Main configuration
├── _posts/               # Published posts
├── _layouts/             # Page layouts
├── _includes/            # Reusable components
├── _sass/                # Standalone theme SCSS
├── assets/css/           # CSS entry point
├── static/               # Static assets
└── netlify.toml          # Netlify configuration
```

## License

Personal blog - All rights reserved.

## Author

**Iqbwl**
- Email: iqbwl@silent.web.id
- Telegram: [@iqbwld](https://t.me/iqbwld)
