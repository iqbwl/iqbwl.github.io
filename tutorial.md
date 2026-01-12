# Tutorial: Creating Posts and Pages in Jekyll

This document provides a guide on how to create new content and use the video embed features.

## 1. Creating a New Post

Posts are blog articles that appear on the homepage or in the archive.

1.  Create a new file in the `_posts` folder.
2.  File naming convention is **MANDATORY**: `YEAR-MONTH-DAY-post-title.md`
    *   Example: `2025-01-13-learning-jekyll.md`
3.  Fill the file with the standard **Frontmatter** at the very top:

```yaml
---
layout: post
title: "Your Post Title"
author: iqbwl
date: '2025-08-10 19:19:00 +0700'
categories:
- category1
- category2
---
```

*   **layout**: Always use `post`.
*   **author**: Always use `iqbwl`.
*   **date**: Format `YYYY-MM-DD HH:MM:SS +0700`.
*   **categories**: Use a list (`- category_name`). Do not leave it empty (`- ''`).

## 2. Creating a New Page

Pages are static content like "About", "Contact", etc.

1.  Create a new `.md` file in the root directory (or in a specific folder for nested URLs).
2.  Example filename: `contact.md`.
3.  Frontmatter:

```yaml
---
layout: page
title: Contact
permalink: /contact/
---
```

## 3. Inserting Images

Use the standard Markdown format:

```markdown
![Alt Text](/path/to/image.jpg "Image Title")
```
*   Ensure the image is uploaded to the assets folder (e.g., `/static/img/`).

## 4. Embedding Videos

We have added special features to embed YouTube and Asciinema videos easily and neatly.

### YouTube

Use the following code (supports full URL or just the ID):

**Option 1 (Full URL):**
```liquid
{% include youtube.html url="https://www.youtube.com/watch?v=VIDEO_ID" %}
```

**Option 2 (Video ID):**
```liquid
{% include youtube.html id="VIDEO_ID" %}
```

### Asciinema

For recording terminal sessions. Use the ID from the Asciinema cast:

```liquid
{% include asciinema.html id="CAST_ID" %}
```
*   Replace `CAST_ID` with the numeric ID from the Asciinema URL (e.g., `642518` from `asciinema.org/a/642518`).

***

*This tutorial file will not be published to the website because it is excluded in `_config.yml`.*
