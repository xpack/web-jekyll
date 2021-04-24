---
title:  VS Code xPack extension v0.4.4 released

summary: "Version **0.4.4** is a new development release of **ilg-vscode.xpack**; it adds commands to create simple projects from templates."

version: 0.4.4

date:   2021-04-22 23:40:00 +0300

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
code --install-extension ilg-vscode.xpack@0.4.4
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- support to create new projects from templates was added
- internal watchers to automate refresh on package.json changes was added

### Other changes

- dependencies to **ms-vscode.cpptools** & **ms-vscode.cmake-tools**

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
is currently _work in progress_ and should be used with caution." %}
