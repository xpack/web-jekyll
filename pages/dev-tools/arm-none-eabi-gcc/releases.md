---
title: The xPack GNU Arm Embedded GCC releases
permalink: /arm-none-eabi-gcc/releases/

search: exclude
toc: false
comments: false
github_editme: false

date: 2019-07-10 17:53:00 +0300
last_updated: 2019-10-11 15:52:59 +0300

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "arm-none-eabi-gcc" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
