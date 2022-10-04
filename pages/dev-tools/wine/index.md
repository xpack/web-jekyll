---
title: The xPack WineHQ
permalink: /dev-tools/wine/

summary: "A binary distribution of WineHQ."

comments: true
keywords: wine

date: 2022-10-04 10:32:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack WineHQ, you can
directly skip to the desired pages.

User pages:

- [install]({{ site.baseurl }}/dev-tools/wine/install/)
- [support]({{ site.baseurl }}/dev-tools/wine/support/)
- [releases]({{ site.baseurl }}/dev-tools/wine/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/wine-xpack/)
- [How to build](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack WineHQ** is a cross-platform binary distribution of the
[WineHQ](https://www.winehq.org) build system,
an open source project hosted on
[GitLab](https://gitlab.winehq.org/).

## Benefits

The main advantages of using the **xPack WineHQ** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure
- a better integration with development environments
- a more convenient integration with CI environment

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack WineHQ** is fully compatible with the original **WineHQ**
distribution.

## Install

The details of installing the **xPack WineHQ** on various platforms are
presented in the separate
[install]({{ site.baseurl }}/dev-tools/wine/install/) page.

## Documentation

The current version specific WineHQ documentation is available online from:

- [https://www.winehq.org/](https://www.winehq.org/)

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/dev-tools/wine/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`wine-xpack.git/scripts`](https://github.com/xpack-dev-tools/wine-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/dev-tools/wine/releases/) pages.