---
title:  VS Code xPack extension v0.5.1 released
sidebar: vscode

summary: "Version **0.5.1** is a maintenance release of **ilg-vscode.xpack**; it fixes the automatic update for `c_cpp_properties.json`."

version: 0.5.1

date:   2023-06-20 11:23:00 +0300

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

- [#45] - when the project has sub-packages (like `tests`), the project
  `c_cpp_properties.json` did not include the configurations defined in
  the sub-packages; fixed.

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

However, for projects using binary xPacks, they are available mainly
on the modern platforms, like Windows/macOS/Linux.

## Final notes

{% include important.html content="The **ilg-vscode.xpack** extension
is currently _work in progress_ and should be used with caution." %}
