---
title: The xPack XBB Bootstrap
permalink: /dev-tools/xbb-bootstrap/

summary: "A binary distribution of XBB Bootstrap."

comments: true
keywords: xbb-bootstrap

date: 2022-10-04 10:32:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack XBB Bootstrap, you can
directly skip to the desired pages.

User pages:

- [install]({{ site.baseurl }}/dev-tools/xbb-bootstrap/install/)
- [support]({{ site.baseurl }}/dev-tools/xbb-bootstrap/support/)
- [releases]({{ site.baseurl }}/dev-tools/xbb-bootstrap/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/)
- [How to build](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack XBB Bootstrap** a temporary solution intended to replace the
functionality provided by the XBB v3.4 Docker images until separate
packages will be available with all required tools.

## Benefits

The main advantages of using the **xPack XBB Bootstrap** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure
- a better integration with development environments
- a more convenient integration with CI environment

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack XBB Bootstrap** tools are generally fully compatible with the
original included projects.

## Install

The details of installing the **xPack XBB Bootstrap** on various platforms are
presented in the separate
[install]({{ site.baseurl }}/dev-tools/xbb-bootstrap/install/) page.

## Documentation

The documentation is available online from the respective projects.

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/dev-tools/xbb-bootstrap/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`xbb-bootstrap-xpack.git/scripts`](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/dev-tools/xbb-bootstrap/releases/) pages.
