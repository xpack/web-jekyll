---
title: The xPack GNU Compiler Collection (GCC)
permalink: /gcc/

summary: "A binary distribution of the GNU Compiler Collection."
comments: true
keywords:
  - gnu
  - gcc
  - c++

date: 2021-05-22 00:27:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack GNU Compiler Collection, you can
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/gcc/install/)
- [Support]({{ site.baseurl }}/gcc/support/)
- [Releases]({{ site.baseurl }}/gcc/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/gcc-xpack/)
- [How to build](https://github.com/xpack-dev-tools/gcc-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/gcc-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack GNU Compiler Collection**
is an cross-platform standalone binary distribution of the
[GNU Compiler Collection](https://gcc.gnu.org).

## Benefits

The main advantages of using the **xPack GNU Compiler Collection** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure,
  the same procedure is used for all major
  platforms (Windows 64/32-bit, GNU/Linux 64/32-bit, macOS)
- a convenient integration with Continuous Integration environments,
  like GitHub Actions
- a better integration with development environments
  like **Eclipse Embedded CDT**.

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack GNU Compiler Collection** is fully compatible with the
original GNU releases.

## Install

The details of installing the **xPack GNU Compiler Collection** on various
platforms are presented in the separate
[Install]({{ site.baseurl }}/gcc/install/) page.

## Documentation

To save space and bandwidth, the original documentation is available
[online](https://gcc.gnu.org/onlinedocs/).

## Predefined macros

The list of build-in macros is available in a
[separate page]({{ site.baseurl }}/gcc/predefined-macros/).

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/gcc/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/gcc-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/gcc-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`gcc-xpack.git/scripts`](https://github.com/xpack-dev-tools/gcc-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/gcc/releases/) pages.
