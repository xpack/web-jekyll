---
title:  VS Code xPack extension v0.4.12 released
sidebar: vscode

summary: "Version **0.4.12** is a new development release of **ilg-vscode.xpack**; it does some clean-ups."

version: 0.4.12

date:   2021-05-05 19:47:00 +0300

redirect_from:
  - /blog/2021/05/05/vscode-xpack-v0-4-11-released/

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
code --install-extension ilg-vscode.xpack@0.4.12
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- none

### Other changes

- [#12] - the local configuration provider is not implemented, and, to avoid
  possible issues, do not register it yet
- [#3] - the HoverProvider is in early development stage, and is not registered

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
