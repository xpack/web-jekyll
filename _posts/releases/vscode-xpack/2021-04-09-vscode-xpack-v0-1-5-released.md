---
title:  VS Code xPack extension v0.1.5 released
sidebar: vscode

summary: "Version **0.1.5** is a new development release of **ilg-vscode.xpack**; it adds the actions explorer."

version: 0.1.5

date:   2021-04-09 23:40:00 +0300

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
code --install-extension ilg-vscode.xpack@0.1.5
```

## Changes

The {{ page.version }} release
is generally compatible with previous releases.

### Bug fixes

- none

### Enhancements

- an xPacks Actions explorer, implemented as a tree view, was added; it
provides a convenient way to navigate between multiple build configurations
and actions; to make it visible, open a `package.json` created via
`xpm init` and add the xpack property (for example from the above code)
- actions are integrated into the usual VS Code workflow by associating
internal tasks with each action; separate tasks are added for common
commands like `xpm install`.

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
