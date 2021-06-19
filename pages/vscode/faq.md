---
title: FAQ
permalink: /vscode/faq/

toc: false
comments: true

date: 2021-04-22 23:09:00 +0300

---

### The VS Code xPack Frequently Asked Questions

{% capture question_30 %}
What is the *active* configuration?
{% endcapture %}

{% capture answer_30 %}
The C/C++ extension, which parses the `.vscode/c_cpp_properties.json` file,
has a way of selecting one of the configurations (like debug/release), for
IntelliSense to know which `compile_commands.json` to parse.

VS Code shows the active configuration name on the status bar,
and it can be changed from there.
{% endcapture %}

{% capture question_20 %}
Why IntelliSense does not kick in?
{% endcapture %}

{% capture answer_20 %}
For managed projects, IntelliSense needs a file called `compile_commands.json`
to know how to parse the project. One such file is expected in each build
folder, and the system build generator
(CMake/meson/etc) automatically creates these files when the
project is prepared, like during the first build.
{% endcapture %}

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
{% include faq-panel.html id="collapse-30" question=question_30 answer=answer_30 %}
{% include faq-panel.html id="collapse-20" question=question_20 answer=answer_20 %}
{% include faq-panel.html id="collapse-10" question=question_10 answer=answer_10 %}
{% include div-end.html %}
