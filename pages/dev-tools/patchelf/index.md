---
title: The xPack NixOS PatchELF
permalink: /dev-tools/patchelf/

summary: "A binary distribution of NixOS PatchELF."

comments: true
keywords: patchelf

date: 2022-10-04 10:32:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack NixOS PatchELF, you can
directly skip to the desired pages.

User pages:

- [install]({{ site.baseurl }}/dev-tools/patchelf/install/)
- [support]({{ site.baseurl }}/dev-tools/patchelf/support/)
- [releases]({{ site.baseurl }}/dev-tools/patchelf/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/patchelf-xpack/)
- [How to build](https://github.com/xpack-dev-tools/patchelf-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/patchelf-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack NixOS PatchELF** is a cross-platform binary distribution of the
[NixOS PatchELF](https://github.com/NixOS/patchelf) project,
an open source project hosted on
[GitHub](https://github.com/NixOS/patchelf).

## Benefits

The main advantages of using the **xPack NixOS PatchELF** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure
- a better integration with development environments
- a more convenient integration with CI environment

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack NixOS PatchELF** is fully compatible with the original **NixOS PatchELF**
distribution.

## Install

The details of installing the **xPack NixOS PatchELF** on various platforms are
presented in the separate
[install]({{ site.baseurl }}/dev-tools/patchelf/install/) page.

## Documentation

The current version specific NixOS PatchELF documentation is available online from:

- [https://github.com/NixOS/patchelf/blob/master/README.md](https://github.com/NixOS/patchelf/blob/master/README.md)

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/dev-tools/patchelf/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/patchelf-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/patchelf-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`patchelf-xpack.git/scripts`](https://github.com/xpack-dev-tools/patchelf-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/dev-tools/patchelf/releases/) pages.
