---
layout: page
title: Archived
permalink: /archive
---

Here are the archived posts.

<ul class="post-list">
  {%- assign date_format = "%Y-%m-%d" -%}
  {% for post in site.archive reversed %}
    <li>
      <div class="post-header-flex">
        <h3>
          <a class="post-link" href="{{ post.url | relative_url }}">
            {{ post.title | escape }}
          </a>
        </h3>
        <span class="post-meta">{{ post.date | date: date_format }}</span>
      </div>
      {%- if post.description -%}
        {{ post.description | escape }}
      {%- endif -%}
    </li>
  {% endfor %}
</ul>
