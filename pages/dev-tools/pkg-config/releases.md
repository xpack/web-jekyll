---
title: The xPack pkg-config releases
permalink: /dev-tools/pkg-config/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2022-10-04 10:32:00 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "pkg-config" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
