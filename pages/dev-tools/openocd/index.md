---
title: The xPack OpenOCD
permalink: /openocd/

summary: "A binary distribution of OpenOCD."

comments: true
keywords: openocd

date: 2015-09-04 17:02:00 +0300

---

## Quicklinks

If you already know the general facts about the xPack OpenOCD, you can
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/openocd/install/)
- [Support]({{ site.baseurl }}/openocd/support/)
- [Releases]({{ site.baseurl }}/openocd/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/openocd-xpack)
- [How to build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md)
- [How to publish](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-RELEASE.md)

## Overview

The **xPack OpenOCD** is a cross-platform binary distribution of
[OpenOCD](http://openocd.org), the **Open On-Chip Debugger**,
an open source project hosted on 
[SourceForge](https://sourceforge.net/projects/openocd/).

The OpenOCD project maintainers recommend that end-users
compile it using the latest version of the source code available from
the repository. OpenOCD is a rolling distribution, and currently
there are no special stable branches or tags
and there are no clear release dates for future versions.

If for GNU/Linux users compiling projects is common, Windows users do not
have an easy way of building OpenCOD from sources, and elaborate build
environments must be installed, making the whole process impractical.

If you are not interested in building from sources, and appreciate a
better integration with the environments like Eclipse, please feel free to use
the xPack OpenOCD binaries, and preferably install them in the default
locations.

{% include note.html content="OpenOCD is a very complex project, able
to work with many JTAG probes, but support for them must be enabled
at build time, so be sure that support for your JTAG probe was
enabled in the binaries you plan to use. The xPack OpenOCD includes
support for most existing probes, but does not guarantee that all are
included." %}

## Benefits

The main advantages of using the **xPack OpenOCD** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure,
  the same procedure is used for all major
  platforms (Windows 64/32-bit, GNU/Linux 64/32-bit, macOS)
- a better integration with development environments
  like **Eclipse Embedded CDT**.

All binaries are self-contained, they include all required libraries,
and can be installed in any location.

## Compatibility

The **xPack OpenOCD** is fully compatible with the original **OpenOCD**
distribution.

## Install

The details of installing the **xPack OpenOCD** on various platforms are
presented in the separate
[Install]({{ site.baseurl }}/openocd/install/) page.

## Documentation

The original OpenOCD documentation is available in the installed folders:

- `share/doc/pdf/openocd.pdf`

## Support

For the various support options, please read the separate
[support]({{ site.baseurl }}/openocd/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the
[How to build](https://github.com/xpack-dev-tools/openocd-xpack/blob/xpack/README-BUILD.md)
page.
However, the ultimate source for details are the build scripts themselves,
all available from the 
[`openocd-xpack.git/scripts`](https://github.com/xpack-dev-tools/openocd-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [releases]({{ site.baseurl }}/openocd/releases/) pages.
