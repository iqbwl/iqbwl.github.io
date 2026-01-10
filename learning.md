---
layout: page
title: Learning
permalink: /learning
---

Notes on things I'm learning.

<ul class="post-list">
  {% for item in site.learning %}
    <li>
      <div class="post-header-flex">
        <h3>
          <a class="post-link" href="{{ item.url | relative_url }}">
            {{ item.title | escape }}
          </a>
        </h3>
      </div>
      {%- if item.description -%}
        {{ item.description | escape }}
      {%- endif -%}
    </li>
  {% endfor %}
</ul>
