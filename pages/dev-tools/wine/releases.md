---
title: The xPack WineHQ releases
permalink: /wine/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2022-10-04 10:32:00 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "wine" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
