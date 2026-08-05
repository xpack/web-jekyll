---

title:  VS Code xPack extension v1.2.3 released
sidebar: vscode

summary: "Version **1.2.3** is a maintenance release of **ilg-vscode.xpack**; it fixes the activation bug when project package.json is not correct."

version: 1.2.3

date: 2026-08-05 14:05:00 +0300

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
code --install-extension ilg-vscode.xpack@{{ page.version }}
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- [[#55](https://github.com/xpack/vscode-xpack-extension-ts/issues/55)]: if one of the projects had an incorrect package.json, activation failed; fixed.

### Enhancements

- none

### Other changes

- none

### Known problems

- none

## Supported platforms

The **ilg-vscode.xpack** extension is fully portable and works on any
platform supported by VS Code; internally it relies on **xpm**, which
is also a portable application running on all platforms supported
by **npm**/**node**.

However, for projects using binary xpm packages, they are available mainly
on the modern platforms, like Windows/macOS/Linux.
