---
title: The xPack xpm releases
permalink: /xpm/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2021-01-27 21:51:00 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "xpm" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}){% endif %}{% endif %}{% endfor %}
