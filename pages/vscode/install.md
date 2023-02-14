---
title: How to install the VS Code xPack Extension
permalink: /vscode/install/

keywords:
  - vscode
  - xpack
  - install

comments: true
toc: false

date: 2021-04-22 23:04:00 +0300

---

## Overview

The **VS Code xPack C/C++ Managed Build Extension** is
available as **ilg-vscode.xpack** from the
[Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack).

## Prerequisites

- a recent [Visual Studio Code](https://code.visualstudio.com)
- a recent [xpm](https://www.npmjs.com/package/xpm).

Briefly, to install xpm, the command is:

```sh
npm install --global xpm@latest
```

{% include tip.html content="Version 0.9.x or later is required." %}

If this command fails and requires `sudo`,
it means `npm` is not
installed correctly;
it is recommended to reinstall node/npm via `nvm`, the npm version manager,
as documented in the
[prerequisites]({{ site.baseurl }}/install/) page.

## Install the VS Code extension

The **ilg-vscode.xpack** extension can be installed directly from the
[Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack)

On the side bar, select the **Extensions** view and enter `xpack` in the
search field:

![Install VS code xPack]({{ site.baseurl }}/assets/images/2021/install-vscode-xpack.png)

Install as usual; the xPack extension should also bring in some dependencies:

![VS code xPack dependencies]({{ site.baseurl }}/assets/images/2021/vscode-xpack-dependencies.png)

For those who prefer a command line approach, the xPack extension can also
be installed in a terminal:

```sh
code --install-extension ilg-vscode.xpack
```

## Configuring the xPack extension

The extension has several configuration options.

TBD.
