---
title: FAQ
permalink: /vscode/faq/

toc: false
comments: true

date: 2021-04-22 23:09:00 +0300

---

### The VS Code xPack Frequently Asked Questions

{% capture question_10 %}
VS Code created a `.vscode/c_cpp_properties.json` in a folder which
is not a project folder. How can I get rid of it?
{% endcapture %}

{% capture answer_10 %}
VS Code does not know about project folders, it knows only about
workspace folders. If the goal is to work with multiple project folders,
create a workspace and add all project folders to it
([more info]({{ site.baseurl }}/vscode/intellisense/#use-separate-workspace-folders-for-projects)).
{% endcapture %}

{% include div-panel-group.html %}
{% include faq-panel.html id="collapse-10" question=question_10 answer=answer_10 %}
{% include div-end.html %}
