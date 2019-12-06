---
title: The xPack Package Manager
permalink: /xpm/

summary: A tool to manage dependencies for generic multi-version source and binary packages, inspired by npm.
keywords:
  - xPack
  - package
  - manager
comments: true
toc: false

date: 2017-10-09 14:14:00 +0300
last_updated: 2019-07-15 15:25:45 +0300

---

## Quicklinks

If you already know the general facts about **xpm**, you can
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/xpm/install/)
- [Support]({{ site.baseurl }}/xpm/support/)
- [npmjs.com](https://www.npmjs.com/package/xpm)
- [Published versions](https://www.npmjs.com/package/xpm?activeTab=versions)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack/xpm-js)
- How to build? (TBD)
- How to publish? (TBD)

## Overview

`xpm` stands for **x**Pack **p**ackage **m**anager and is a Node.js CLI
application to manage xPacks; it can install both source and binary xPacks.

xpm is an extension to npm and shares the same public repository.

The open source project is hosted on GitHub as
[`xpack/xpm-js`](https://github.com/xpack/xpm-js.git).

## xPacks overview

xPacks are general purpose multi-version software packages, much the same
as the highly successful npm modules in the Node.js JavaScript ecosystem.

Please read the [xPacks Overview]({{ site.baseurl }}/) and
[xPack 101]({{ site.baseurl }}/intro/) pages.

## Purpose

The main purpose of the xpm tool is to install xPacks, including all
dependent xPacks, and to easily update them when new versions are released.

For developers, xpm provides a very convenient way of publishing the
software packages, using the same central repository as npm.

## xpm CLI commands

- [`xpm`]({{ site.baseurl }}/xpm/cli/)
- [`xpm init`]({{ site.baseurl }}/xpm/cli/init/)
- [`xpm install`]({{ site.baseurl }}/xpm/cli/install/)
- [`xpm run-script`]({{ site.baseurl }}/xpm/cli/run-script/)

## Configuring xpm

- [folders]({{ site.baseurl }}/xpm/folders/) - folder structures used by xpm
- files
  - [`package.json`]({{ site.baseurl }}/xpm/files/package.json/)

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT), with all rights reserved to
[Liviu Ionescu](https://github.com/ilg-ul).

The design is heavily influenced by the npm application,
**Copyright (c) npm, Inc. and Contributors**, Licensed on the terms of
**The Artistic License 2.0**.

## Note

The xpm tool is currently experimental and should not be used in production environments.
