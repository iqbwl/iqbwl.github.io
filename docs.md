---
layout: page
title: Documentation
permalink: /docs
---

Here is the documentation.

<ul class="post-list">
  {% for doc in site.docs %}
    <li>
      <div class="post-header-flex">
        <h3>
          <a class="post-link" href="{{ doc.url | relative_url }}">
            {{ doc.title | escape }}
          </a>
        </h3>
      </div>
      {%- if doc.description -%}
        {{ doc.description | escape }}
      {%- endif -%}
    </li>
  {% endfor %}
</ul>
