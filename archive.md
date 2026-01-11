---
layout: page
title: Archived
permalink: /archive
---

Here are the archived posts.

<div class="space-y-1 mt-4">
  {%- assign date_format = "%Y-%m-%d" -%}
  {% for post in site.archive reversed %}
  <article class="group relative flex flex-col items-start transition-all">
    <div class="w-full flex justify-between items-baseline mb-2">
        <h3 class="text-xl font-bold tracking-tight text-stone-900 dark:text-white font-heading group-hover:text-stone-600 dark:group-hover:text-stone-300 transition-colors">
            <a href="{{ post.url | relative_url }}" class="no-underline">
            <span class="absolute inset-0"></span>
            {{ post.title | escape }}
            </a>
        </h3>
        <time datetime="{{ post.date | date_to_xmlschema }}" class="text-sm text-stone-500 dark:text-stone-400 font-mono shrink-0 ml-4 hidden sm:block">{{ post.date | date: date_format }}</time>
    </div>
    
    <div class="sm:hidden mb-2">
        <time datetime="{{ post.date | date_to_xmlschema }}" class="text-sm text-stone-500 dark:text-stone-400 font-mono">{{ post.date | date: date_format }}</time>
    </div>
  </article>
  {% endfor %}
</div>
