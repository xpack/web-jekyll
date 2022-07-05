---
title:  VS Code xPack extension v0.4.10 released
sidebar: vscode

summary: "Version **0.4.10** is a new development release of **ilg-vscode.xpack**; it adds several enhancements."

version: 0.4.10

date:   2021-05-05 00:53:00 +0300

categories:
  - releases
  - vscode-xpack

tags:
  - releases
  - vscode
  - vscode-xpack
  - extension

---

## Install

The **VS Code xPack C/C++ Managed Build Extension** is
available as **ilg-vscode.xpack** from the
[Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack).

It can also be installed from a terminal:

```sh
code --install-extension ilg-vscode.xpack@0.4.10
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- [#16] - add right-click commands to remove actions
- [#15] - add right-click commands to create actions and configurations
- [#6] - add a command to create a new configurations by duplicating an
  existing one
- [#5] - add xpack.exclude to configuration
- [#2] - add code to automatically exclude `**/xpacks/**` from npm searches
- [#4] - add configuration variable for maxDepthLevel
- [#14] - add configuration variable for the log level

### Other changes

- none

### Known problems

- none

## Supported platforms

The **ilg-vscode.xpack** extension is fully portable and works on any
platform supported by VS Code; internally it relies on **xpm**, which
is also a portable application running on all platforms supported
by **npm**/**node**.

However, for projects using binary xPacks, they are available mainly
on the modern platforms, like Windows/macOS/Linux.

## Final notes

{% include important.html content="The **ilg-vscode.xpack** extension
is currently _work in progress_ and should be used with caution." %}
