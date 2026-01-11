---
layout: page
title: Documentation
permalink: /docs
---

Here is the documentation.

<div class="space-y-1 mt-4">
  {% for doc in site.docs %}
  <article class="group relative flex flex-col items-start transition-all">
    <div class="w-full flex justify-between items-baseline">
        <h3 class="text-xl font-bold tracking-tight text-stone-900 dark:text-white font-heading group-hover:text-stone-600 dark:group-hover:text-stone-300 transition-colors">
            <a href="{{ doc.url | relative_url }}" class="no-underline">
            <span class="absolute inset-0"></span>
            {{ doc.title | escape }}
            </a>
        </h3>
    </div>
    {%- if doc.description -%}
    <p class="mt-2 line-clamp-2 text-base leading-relaxed text-stone-600 dark:text-stone-400">
          {{ doc.description | escape | truncatewords: 30 }}
    </p>
    {%- endif -%}
  </article>
  {% endfor %}
</div>
