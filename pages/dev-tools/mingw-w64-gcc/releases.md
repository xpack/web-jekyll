---
title: The xPack MinGW-w64 GCC releases
permalink: /dev-tools/mingw-w64-gcc/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2022-10-04 11:43:00 +0300

redirect_from:
  - /mingw-w64-gcc/releases/

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "mingw-w64-gcc" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
