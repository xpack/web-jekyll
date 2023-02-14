---
title: The xPack GNU AArch64 Embedded GCC releases
permalink: /dev-tools/aarch64-none-elf-gcc/releases/

search: exclude
github_editme: false

comments: false
toc: false

date: 2019-07-10 17:53:00 +0300

redirect_from:
  - /aarch64-none-elf-gcc/releases/

---

___
{% for post in site.posts %}{% if post.categories contains "releases" %}{% if post.categories contains "aarch64-none-elf-gcc" %}
* [{{ post.title }}]({{ site.baseurl }}{{ post.url }}) [(download)]({{ post.download_url }}){% endif %}{% endif %}{% endfor %}
