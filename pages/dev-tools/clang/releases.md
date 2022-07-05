---
title: The xPack LLVM clang releases
permalink: /clang/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2021-05-22 00:27:00 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "clang" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
