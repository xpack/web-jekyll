---
title: The xPack CMake releases
permalink: /cmake/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2020-09-29 14:05:00 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "cmake" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
