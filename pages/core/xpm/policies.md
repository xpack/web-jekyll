---
title: xpm Policies
permalink: /xpm/policies/

summary: Compatibility policies.
keywords:
  - xPack
  - package
  - manager
  - compatibility
  - policy
comments: true
toc: false

date: 2022-08-15 10:38:00 +0300

---

## Overview

Similarly to CMake, xpm has a mechanism to preserve some deprecated
functionality, to allow the projects to update their configurations.

Newer **xpm** versions are able to adjust some
functionality to match that of the required version, based on the
value of the `xpack.minimumXpmRequired` property in `package.json`.

## Policies introduced by xpm 0.14

- [0001]({{ site.baseurl }}/xpm/policies/0001-share-npm-dependencies/) -
  share npm dependencies

