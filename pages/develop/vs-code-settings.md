---
title: VS Code Settings
permalink: /develop/vs-code-settings/

summary: Custom settings to silence some VS Code extensions.
comments: true

date: 2022-08-07 09:51:00 +0300

---

## Overview

VS Code has many extensions, and many settings to customise them.

Below are some settings that were useful in xPack projects.

### Silence annoying questions

Some VS Code extensions assume that all projects use them, and are trying to
automate some things even when this is not necessary.

Some of these annoying behaviours can be disabled, for example:

```json
  "cmake.ignoreCMakeListsMissing": true,
  "cmake.configureOnOpen": false,
  "makefile.configureOnOpen": false
```

### Editor settings

```json
  "editor.rulers": [
    80
  ],
  "editor.wordWrap": "on"
```
