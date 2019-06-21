---
layout: page
title: The xPack OpenOCD releases
permalink: /dev-tools/openocd/releases/
sidebar: openocd_sidebar

author: Liviu Ionescu
date: 2015-09-10 09:08:00 +0300
search: exclude

---

{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "openocd" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
