---
title: The xPack Basic Project Builder
permalink: /xpbuild/

summary: A tool to build day to day projects without having to manually write make files, with an emphasis on C/C++ and embedded applications, inspired by Eclipse CDT managed builder (work in progress).
toc: false

date: 2019-07-04 17:02:00 +0300
last_updated: 2019-07-10 19:37:57 +0300

---

## Overview

This tool is still work in progress and is not yet public.

It was initially called `xmake`, but the name collided with the
_Lua xmake_, and it was re-branded.

The tool is mostly functional, at the moment it is able to build projects
using either `make` or `ninja`. Due to the uncertainty with the name,
promotion was postponed; then it was decided to also include an internal
builder,
using the code of xpninja, and to make it public when ready.

## xpbuild CLI commands

- [`xpbuild`]({{ site.baseurl }}/xpbuild/cli/)
- [`xpbuild init`]({{ site.baseurl }}/xpbuild/cli/init/)

## Configuring xpbuild

- [`xpbuild.json`]({{ site.baseurl }}/xpbuild/files/xpbuild-json/)

