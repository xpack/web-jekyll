---
title:  VS Code xPack extension v0.4.15 released
sidebar: vscode

summary: "Version **0.4.15** is a maintenance release of **ilg-vscode.xpack**; it fixes a bug affecting the display of the explorer."

version: 0.4.15

date:   2021-07-15 10:57:00 +0300

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
code --install-extension ilg-vscode.xpack@0.4.15
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- [#21] - in certain conditions, starting with VS Code 1.58,
  the content of the xPack explorer was incomplete;
  the problem was identified as a race condition in preparing the tree items;
  the fix was a simple code reorder.

### Enhancements

- none

### Other changes

- none

### Known problems

- [#22] - due to a bug in the logic to redraw the xPack Actions tree, after
  editing the `package.json`, attempts to perform any actions fail with
  an error (_Error running command xpack.runAction: Running the contributed
  command: 'xpack.runAction' failed. This is likely caused by the extension
  that contributes xpack.runAction._). Fixed in v0.4.16.

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
