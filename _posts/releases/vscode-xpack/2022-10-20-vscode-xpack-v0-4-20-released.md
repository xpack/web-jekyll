---
title:  VS Code xPack extension v0.4.20 released
sidebar: vscode

summary: "Version **0.4.20** is a new maintenance of **ilg-vscode.xpack**; it allows to override the install command with an action."

version: 0.4.20

date:   2022-10-20 10:48:00 +0300

comments: true

categories:
  - releases
  - vscode-xpack

tags:
  - releases
  - vscode
  - vscode-xpack
  - extension
  - c++

---

## Install

The **VS Code xPack C/C++ Managed Build Extension** is
available as **ilg-vscode.xpack** from the
[Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack).

It can also be installed from a terminal:

```sh
code --install-extension ilg-vscode.xpack
```

This specific version can be installed with the following command,
although generally it is recommended to use the latest version:

```sh
code --install-extension ilg-vscode.xpack@0.4.20
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- [#36] - if there is an action named `install`, the default command
with the same name is no longer shown.

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
