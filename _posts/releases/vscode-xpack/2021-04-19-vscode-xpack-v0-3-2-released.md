---
title:  VS Code xPack extension v0.3.2 released
sidebar: vscode

summary: "Version **0.3.2** is a new development release of **ilg-vscode.xpack**; it adds commands to create configurations & actions."

version: 0.3.2

date:   2021-04-19 23:40:00 +0300

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
code --install-extension ilg-vscode.xpack@0.3.2
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- commands to create configs & actions were added
- xpm install is available as a separate entry in the explorer, runnable


### Other changes

- none

### Known problems

- **npm** picks `package.json` from xPack dependencies, which is generally
  not useful; the workaround is to add a property to `settings.json`:

```json
"npm.exclude": "**/xpacks/**"
```

(fixed in 0.4.10)

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
