# iqbwl.web.id

Personal blog built with Jekyll.

## Tech Stack

- **Static Site Generator**: Jekyll
- **Styling**: Tailwind CSS (v4)
- **Deployment**: Netlify

## Development

Install dependencies:

```bash
bundle install
npm install
```

Run development server (Jekyll + Tailwind Watch):

```bash
npm run dev
```

- Deployment: Netlify (Primary), GitHub Pages (Backup)

## Usage

### Local Development

1.  **Install Dependencies**
    ```bash
    bundle install
    npm install
    ```

2.  **Run Development Server**
    Use the helper script to run Jekyll and Tailwind watcher concurrently:
    ```bash
    ./serve_dev.sh
    ```
    *This runs `npm run dev` behind the scenes.*

3.  **Test Production Build**
    To see how the site looks like in production (minified CSS, no drafts):
    ```bash
    ./serve_prod.sh
    ```
    *This runs `npm run build:css` then `jekyll serve`.*

## Deployment

### Netlify (Recommended)
This repo is configured with `netlify.toml`.
- **Build Command**: `npm install && npm run build:css && bundle install && JEKYLL_ENV=production bundle exec jekyll build --config _config.yml,_config_prod.yml`
- **Publish Directory**: `public`

### GitHub Actions
A workflow file `.github/workflows/jekyll.yml` is included to build and deploy to GitHub Pages.
- **Node.js**: Installed to compile TailwindCSS.
- **Ruby**: Installed to build Jekyll.
- **Artifact**: Uploads the `public` folder.

## License

Personal blog - All rights reserved.

## Author

**Iqbwl**
- Telegram: [@iqbwld](https://t.me/iqbwld)
