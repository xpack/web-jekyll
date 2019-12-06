---
title: Tags
permalink: /tags/

comments: false
toc: false

date: 2019-07-30 20:06:00 +0300
last_updated: 2019-12-06 22:15:37 +0200

---

<br/>
Available tags:

{% for tag in site.tags %}
- [{{ tag | first }}]({{ site.baseurl }}/tags/{{ tag | first }}/)
{% endfor %}

