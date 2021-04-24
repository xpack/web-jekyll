---
title:  VS Code xPack extension v0.2.2 released

summary: "Version **0.2.2** is a new development release of **ilg-vscode.xpack**; it adds IntelliSense support."

version: 0.2.2

date:   2021-04-14 23:40:00 +0300

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
code --install-extension ilg-vscode.xpack@0.2.2
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- IntelliSense support was added via `c_cpp_properties.json`
(making use of the ms-vscode.cmake-tools configuration provider);
the new status bae entry is no longer needed and was disabled
- generic template support was added by performing Liquid substitution,
mainly to compute buildFolderRelativePath but also to show actions tooltips

### Other changes

- since the project grew, as recommended, webpack was used to pack all code into a single compact file

### Known problems

- **npm** picks `package.json` from xPack dependencies, which is generally
  not useful; the workaround is to add a property to `settings.json`:

```json
"npm.exclude": "**/xpacks/**"
```

## Supported platforms

The **ilg-vscode.xpack** extension is fully portable and works on any
platform supported by VS Code; internally it relies on **xpm**, which
is also a portable application running on all platforms supported
by **npm**/**node**.

However, for projects using binary xPacks, they are available mainly
on the modern platforms, like Windows/macOS/Linux.

## Final notes

{% include important.html content="The **ilg-vscode.xpack** extension
is currently an _early preview_ and should be used with caution." %}
