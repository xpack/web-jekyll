---
title:  VS Code xPack extension v0.4.14 released
sidebar: vscode

summary: "Version **0.4.14** is a new development release of **ilg-vscode.xpack**; it uses a new version of the liquid engine."

version: 0.4.14

date:   2021-06-20 12:44:00 +0300

comments: true

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
code --install-extension ilg-vscode.xpack@0.4.14
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- none

### Other changes

- [#17] - no longer use `"configurationProvider": "ms-vscode.cmake-tools"` in `c_cpp_properties.json`
- dependency on `ms-vscode.cmake-tools` removed

### Known problems

- starting with VS Code 1.58, in certain conditions the
  content of the xPack explorer was incomplete;
  the problem was fixed in the next release (0.4.15).

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
