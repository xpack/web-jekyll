---
title: The xPack XBB Bootstrap releases
permalink: /dev-tools/xbb-bootstrap/releases/

search: exclude
github_editme: false

comments: false
toc: false

date: 2022-10-04 10:32:00 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "xbb-bootstrap" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
