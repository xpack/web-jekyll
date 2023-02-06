---
title: The xPack Windows Build Tools releases
permalink: /dev-tools/windows-build-tools/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2020-07-14 16:26:00 +0300

redirect_from:
  - /windows-build-tools/releases/

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "windows-build-tools" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
