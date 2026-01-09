---
layout: page
title: Cheatsheets
permalink: /cheatsheets
---

Here are some cheatsheets for quick reference.

<ul class="post-list">
  {% for cheat in site.cheatsheets %}
    <li>
      <div class="post-header-flex">
        <h3>
          <a class="post-link" href="{{ cheat.url | relative_url }}">
            {{ cheat.title | escape }}
          </a>
        </h3>
      </div>
      {%- if cheat.description -%}
        {{ cheat.description | escape }}
      {%- endif -%}
    </li>
  {% endfor %}
</ul>
