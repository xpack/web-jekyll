---
title: The xPack Ninja Build
permalink: /ninja-build/

summary: "A binary distribution of Ninja Build."

comments: true
keywords: ninja-build

date: 2020-09-28 17:49:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack Ninja Build, you can
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/ninja-build/install/)
- [Support]({{ site.baseurl }}/ninja-build/support/)
- [Releases]({{ site.baseurl }}/ninja-build/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/ninja-build-xpack)
- [How to build](https://github.com/xpack-dev-tools/ninja-build-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/ninja-build-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack Ninja Build** is a cross-platform binary distribution of the
[Ninja](https://ninja-build.org) build system,
an open source project hosted on
[GitHub](https://github.com/ninja-build/ninja/).

## Benefits

The main advantages of using the **xPack Ninja Build** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure,
  the same procedure is used for all major
  platforms (Windows 64/32-bit, GNU/Linux 64/32-bit, macOS)
- a better integration with development environments
- a more convenient integration with CI environment

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack Ninja Build** is fully compatible with the original **Ninja**
distribution.

## Install

The details of installing the **xPack Ninja Build** on various platforms are
presented in the separate
[Install]({{ site.baseurl }}/ninja-build/install/) page.

## Documentation

The original Ninja documentation is available in the installed folders:

- https://ninja-build.org/manual.html

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/ninja-build/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/ninja-build-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/ninja-build-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`ninja-build-xpack.git/scripts`](https://github.com/xpack-dev-tools/ninja-build-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/ninja-build/releases/) pages.
