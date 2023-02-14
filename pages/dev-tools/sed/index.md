---
title: The xPack GNU sed
permalink: /dev-tools/sed/

summary: "A binary distribution of GNU sed."

keywords: sed

comments: true

date: 2022-10-04 10:32:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack GNU sed, you can
directly skip to the desired pages.

User pages:

- [install]({{ site.baseurl }}/dev-tools/sed/install/)
- [support]({{ site.baseurl }}/dev-tools/sed/support/)
- [releases]({{ site.baseurl }}/dev-tools/sed/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/sed-xpack/)
- [How to build](https://github.com/xpack-dev-tools/sed-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/sed-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack GNU sed** is a cross-platform binary distribution of the
[GNU sed](https://www.gnu.org/software/sed/) project,
an open source project hosted on
[Savannah](https://git.savannah.gnu.org/gitweb/?p=sed.git).

## Benefits

The main advantages of using the **xPack GNU sed** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure
- a better integration with development environments
- a more convenient integration with CI environment

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack GNU sed** is fully compatible with the original **GNU sed**
distribution.

## Install

The details of installing the **xPack GNU sed** on various platforms are
presented in the separate
[install]({{ site.baseurl }}/dev-tools/sed/install/) page.

## Documentation

The current version specific GNU sed documentation is available online from:

- [https://www.gnu.org/software/sed/manual/](https://www.gnu.org/software/sed/manual/)
- [https://sed.sourceforge.io/#docs](https://sed.sourceforge.io/#docs)

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/dev-tools/sed/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/sed-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/sed-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the
[`sed-xpack.git/scripts`](https://github.com/xpack-dev-tools/sed-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/dev-tools/sed/releases/) pages.
