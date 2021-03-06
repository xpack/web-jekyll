---
title: The xPack CMake
permalink: /cmake/

summary: "A binary distribution of CMake."

comments: true
keywords: cmake

date: 2020-09-29 14:05:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack CMake, you can
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/cmake/install/)
- [Support]({{ site.baseurl }}/cmake/support/)
- [Releases]({{ site.baseurl }}/cmake/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/cmake-xpack)
- [How to build](https://github.com/xpack-dev-tools/cmake-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/cmake-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack CMake** is a cross-platform binary distribution of the
[CMake](https://cmake.org) build system,
an open source project hosted on
[GitLab](https://gitlab.kitware.com/cmake/cmake).

## Benefits

The main advantages of using the **xPack CMake** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure,
  the same procedure is used for all major
  platforms (Windows 64/32-bit, GNU/Linux 64/32-bit, macOS)
- a better integration with development environments
- a more convenient integration with CI environment

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack CMake** is fully compatible with the original **CMake**
distribution.

## Install

The details of installing the **xPack CMake** on various platforms are
presented in the separate
[Install]({{ site.baseurl }}/cmake/install/) page.

## Documentation

The current version specific CMake documentation is available in each packet:

- `doc/cmake-X.Y/html/index.html`

and online from:

- [https://cmake.org/documentation/](https://cmake.org/documentation/)

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/cmake/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/cmake-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/cmake-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`cmake-xpack.git/scripts`](https://github.com/xpack-dev-tools/cmake-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/cmake/releases/) pages.
