---
title: FAQ
permalink: /xpm/faq/

toc: false
comments: true

date: 2019-06-28 11:03:00 +0300
last_updated: 2019-07-02 23:14:04 +0300

---

### The xpm Frequently Asked Questions

{% capture question_1 %}
`error: Cannot read property 'path' of null`
{% endcapture %}

{% capture answer_1 %}
This problem is specific to Windows and is caused by aggressive antivirus programs.

On Windows, binary xPacks are .zip archives containing .exe files; 
some aggressive antivirus programs may quarantine those files, or 
even modify the content of the archives, affecting the checksum and 
thus preventing the packages to be installed.

Errors may look like:

```
Downloading https://github.com/gnu-mcu-eclipse/qemu/releases/download/v2.8.0-4-20190211/gnu-mcu-eclipse-qemu-2.8.0-4-20190211-0633-win64.zip...
{ Error: sha256-p3CgzXJt4zi5g0kxQXlOpss3Xu5Yy+Zv8HXWXkUdg6g= integrity checksum failed when using sha256: wanted sha256-p3CgzXJt4zi5g0kxQXlOpss3Xu5Yy+Zv8HXWXkUdg6g= but got sha512-k1s9UW6Zb20llIuopUwbf3D38OP1F+Nkgf3wGWwsXPwoQfhuiR89+VF3Rrf7YF20fN3tG4/3jZSC3apiHbQ6NA== sha256-ABnfxLMtY8E5KqJkrtIlPB4ML7CSFvjizCabv7i7SbU=. (9 bytes)
...
Extracting 'gnu-mcu-eclipse-qemu-2.8.0-4-20190211-0633-win64.zip'...
error: Cannot read property 'path' of null
```

The solution is to configure the antivirus program to be less aggressive, 
at least for files in the 
`AppData\Roaming\xPacks` and `AppData\Local\Caches\xPacks` folders.

If this is not possible, temporarily disable the antivirus program.
{% endcapture %}

{% include div-panel-group.html %}
{% include faq-panel.html id="collapse-1" question=question_1 answer=answer_1 %}
{% include div-end.html %}
