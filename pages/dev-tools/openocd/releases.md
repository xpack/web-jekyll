---
title: The xPack OpenOCD releases
permalink: /openocd/releases/

search: exclude
comments: false
toc: false
github_editme: false

date: 2015-09-10 09:08:00 +0300

---

---
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "openocd" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}