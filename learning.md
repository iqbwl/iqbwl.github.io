---
layout: page
title: Learning
permalink: /learning
---

Notes on things I'm learning.

<div class="space-y-1 mt-4">
  {% for item in site.learning %}
  <article class="group relative flex flex-col items-start transition-all">
    <div class="w-full flex justify-between items-baseline">
        <h3 class="text-xl font-bold tracking-tight text-stone-900 dark:text-white font-heading group-hover:text-stone-600 dark:group-hover:text-stone-300 transition-colors">
            <a href="{{ item.url | relative_url }}" class="no-underline">
            <span class="absolute inset-0"></span>
            {{ item.title | escape }}
            </a>
        </h3>
    </div>
    {%- if item.description -%}
    <p class="mt-2 line-clamp-2 text-base leading-relaxed text-stone-600 dark:text-stone-400">
          {{ item.description | escape | truncatewords: 30 }}
    </p>
    {%- endif -%}
  </article>
  {% endfor %}
</div>
