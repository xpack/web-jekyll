---
title: Page Title
permalink: /test/

toc: false

date: 2019-06-20 23:11:00 +0300

---

## Header 2

Text **bold** text.

### Header 3

Text _italic_ text.

#### Header 4

Text `code` text.

A list:

- one

    indented continuation

        Indented Code line
- two

Another list:

1. one

    indented continuation

        Indented Code line

2. two

> note

***

More text.

```
Code line 1
Code line 2
```
More text.

    Code line 3
    Code line 4

## Header 2

Again.

## Alignment

Centred image:

<div style="text-align:center">
<img alt="Feed" src="{{ site.baseurl }}/assets/images/feed-20.png" />
</div>

Right aligned:

[![EF logo]({{ site.baseurl }}/assets/images/2020/ef-small.png){:class="right-align-image"}](https://projects.eclipse.org/projects/iot.embed-cdt/) Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at. Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at.

## Quote

> Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at.

## Special sections

{% include note.html content="Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at." %}

{% include tip.html content="Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at." %}

{% include warning.html content="Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at." %}

{% include important.html content="Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at." %}

{% include callout.html content="Lorem ipsum dolor sit amet, no quo doming labore doctus, eum commune rationibus at." %}

## Platform Menus

{% capture manual_install %}
## Manual install
{% endcapture %}

{% capture windows %}

{{ manual_install }}

Windows

{% endcapture %}

{% capture macos %}

{{ manual_install }}

macOS

{% endcapture %}

{% capture linux %}

{{ manual_install }}

linux

{% endcapture %}

{% include platform-tabs.html %}
