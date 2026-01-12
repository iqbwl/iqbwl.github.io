---
layout: post
author: iqbwl
title:  "Video Embed Test"
date:   2026-01-12 12:00:00 +0700
categories: [test]
tags: [video, demo]
---

Here is a test of embedding videos.

## Asciinema

User requested:
{% include asciinema.html id="642518" %}

## YouTube

Using the new include helper:

{% include youtube.html url="https://www.youtube.com/watch?v=T1itpPvFWHI" %}

### Another Example (Video ID only)

{% include youtube.html id="T1itpPvFWHI" %}
