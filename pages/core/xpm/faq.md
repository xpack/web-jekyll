---
title: FAQ
permalink: /xpm/faq/

toc: false
comments: true

date: 2019-06-28 11:03:00 +0300
last_updated: 2019-07-02 23:14:04 +0300

---

### The `xpm` Frequently Asked Questions

{% capture question_1 %}
`static async start () ... SyntaxError: Unexpected identifier`
{% endcapture %}

{% capture answer_1 %}
This problem occurs usually on GNU/Linux, and is caused by trying to use
the outdated version of Node available in the distribution, which
does not understand the `async` keyword.

Errors may look like:

```
$ xpm -v
/home/ilg/opt/npm/lib/node_modules/xpm/node_modules/@ilg/cli-start-options/lib/cli-application.js:150
  static async start () {
               ^^^^^
SyntaxError: Unexpected identifier
    at exports.runInThisContext (vm.js:53:16)
    at Module._compile (module.js:374:25)
    at Object.Module._extensions..js (module.js:417:10)
    at Module.load (module.js:344:32)
    at Function.Module._load (module.js:301:12)
    at Module.require (module.js:354:17)
    at require (internal/module.js:12:17)
    at Object.<anonymous> (/home/ilg/opt/npm/lib/node_modules/xpm/node_modules/@ilg/cli-start-options/index.js:55:24)
    at Module._compile (module.js:410:26)
    at Object.Module._extensions..js (module.js:417:10)
```

The solution is to install the most recent LTS version of Node, as 
described in the [prerequisites]({{ site.baseurl }}/install/) page.
{% endcapture %}

{% capture question_2 %}
`error: Cannot read property 'path' of null`
{% endcapture %}

{% capture answer_2 %}
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
{% include faq-panel.html id="collapse-2" question=question_2 answer=answer_2 %}
{% include div-end.html %}
