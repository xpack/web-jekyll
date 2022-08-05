---
title: The xPack Project Manager
permalink: /xpm/

summary: A tool to manage dependencies for language neutral multi-version source and binary packages, inspired by npm.
keywords:
  - xPack
  - package
  - manager
comments: true
toc: false

date: 2017-10-09 14:14:00 +0300

---

## Quicklinks

If you already know the general facts about **xpm**, you can
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/xpm/install/)
- [Support]({{ site.baseurl }}/xpm/support/)
- [Releases]({{ site.baseurl }}/xpm/releases/)
- [npmjs.com](https://www.npmjs.com/package/xpm) (published [versions](https://www.npmjs.com/package/xpm?activeTab=versions))

Developer & maintainer pages:

- [GitHub](https://github.com/xpack/xpm-js)
- [MAINTAINER](https://github.com/xpack/xpm-js/blob/master/README-MAINTAINER.md)

## Overview

**xpm** stands for **x**Pack **p**roject **m**anager and is a
[Node.js](https://nodejs.org/en/) CLI
application to manage xPack projects; it can:

- install source and binary packages
- manage multiple build configurations
- execute (multi-)command line actions
- manage properties and perform complex substitutions, using the
  [LiquidJS](https://liquidjs.com) engine

**xpm** is an extension to **npm** and shares the same public
packages repository ([npmjs.com](https://www.npmjs.com)).

The open source project is hosted on GitHub as
[`xpack/xpm-js`](https://github.com/xpack/xpm-js.git).

An example of a representative project using **xpm** to manage multi-platform
test is
[@micro-os-plus/utils-lists](https://github.com/micro-os-plus/utils-lists-xpack);
please check the
[package.json](https://github.com/micro-os-plus/utils-lists-xpack/blob/xpack/package.json)
file.

## xPacks overview

xPacks are general purpose multi-version software packages, built on top
of the highly successful npm packages in the Node.js JavaScript ecosystem.

Please read the [xPacks Overview]({{ site.baseurl }}/) and
[xPack 101]({{ site.baseurl }}/intro/) pages.

## Purpose

The main purpose of the `xpm` CLI tool is to install xPacks, including all
dependent xPacks, and to easily update them when new versions are released.

For developers, the xPack tools provide a very convenient way of publishing the
software packages, using the same central repository as **npm**.

## xpm CLI commands

- [`xpm`]({{ site.baseurl }}/xpm/cli/)
- [`xpm init`]({{ site.baseurl }}/xpm/cli/init/)
- [`xpm install`]({{ site.baseurl }}/xpm/cli/install/)
- [`xpm link`]({{ site.baseurl }}/xpm/cli/link/)
- [`xpm list`]({{ site.baseurl }}/xpm/cli/list/)
- [`xpm run`]({{ site.baseurl }}/xpm/cli/run/)
- [`xpm uninstall`]({{ site.baseurl }}/xpm/cli/uninstall/)

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

The **xpm** tool is currently _work in
progress_ and should be used with caution.
