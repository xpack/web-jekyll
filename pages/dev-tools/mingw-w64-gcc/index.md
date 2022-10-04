---
title: The xPack MinGW-w64 GCC
permalink: /mingw-w64-gcc/

summary: "A binary distribution of MinGW-w64 GCC."
comments: true
keywords:
  - mingw-w64-gcc
  - mingw-w64
  - mingw
  - gcc

date: 2022-10-04 11:43:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack MinGW-w64 GCC, you can
directly skip to the desired pages.

User pages:

- [install]({{ site.baseurl }}/mingw-w64-gcc/install/)
- [support]({{ site.baseurl }}/mingw-w64-gcc/support/)
- [releases]({{ site.baseurl }}/mingw-w64-gcc/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/mingw-w64-gcc-xpack/)
- [How to build](https://github.com/xpack-dev-tools/mingw-w64-gcc-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/mingw-w64-gcc-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack MinGW-w64 GCC**
is an cross-platform standalone binary distribution of the
[GNU Compiler Collection](https://gcc.gnu.org) on top of the
[Mingw-w64](https://www.mingw-w64.org) runtime environment.

## Benefits

The main advantages of using the **xPack MinGW-w64 GCC** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure,
  the same procedure is used for all major
  platforms (Intel Windows 64-bit, Intel GNU/Linux 64-bit, Arm GNU/Linux
  64/32-bit, Intel macOS 64-bit, Apple Silicon macOS 64-bit)
- a convenient integration with Continuous Integration environments,
  like GitHub Actions
- a better integration with development environments
  like **Eclipse Embedded CDT**.

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack MinGW-w64 GCC** is fully compatible with the
original GNU Compiler Collection (GCC) and generates Windows binaries.

## Install

The details of installing the **xPack MinGW-w64 GCC** on various
platforms are presented in the separate
[install]({{ site.baseurl }}/mingw-w64-gcc/install/) page.

## Documentation

The original GNU GCC documentation is available online:

- [GCC](https://gcc.gnu.org/onlinedocs/)
- [MinGW-w64](https://www.mingw-w64.org/docs/overview/)

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/mingw-w64-gcc/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/mingw-w64-gcc-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/mingw-w64-gcc-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the 
[`mingw-w64-gcc-xpack.git/scripts`](https://github.com/xpack-dev-tools/mingw-w64-gcc-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/mingw-w64-gcc/releases/) pages.