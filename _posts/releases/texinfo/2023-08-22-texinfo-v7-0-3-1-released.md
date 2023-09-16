---
title:  xPack GNU texinfo v7.0.3-1 released

summary: "Version **7.0.3-1** is the first release of the **xPack GNU texinfo** package."

texinfo_version: "7.0.3"
texinfo_date: "2023-03-26"

version: "7.0.3-1"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/texinfo-xpack/releases/tag/v7.0.3-1/

comments: true

date:   2023-08-22 15:50:27 +0300

# For Jekyll releases selection.
categories:
  - releases
  - texinfo

# For navigation; use scripts/createtag.sh in Jekyll.
tags:
  - releases
  - texinfo

---

[The xPack GNU texinfo](https://xpack.github.io/texinfo/)
is a standalone cross-platform binary distribution of
[GNU texinfo](https://www.gnu.org/software/texinfo/).

There are separate binaries for
**macOS** (Intel 64-bit, Apple Silicon 64-bit)
and **GNU/Linux** (Intel 64-bit, Arm 32/64-bit).

{% include note.html content="The main targets for the Arm binaries
are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from GitHub [Releases]({{ page.download_url }}).

## Prerequisites

- GNU/Linux Intel 64-bit: any system with **GLIBC 2.27** or higher
  (like Ubuntu 18 or later, Debian 10 or later, RedHat 8 later,
  Fedora 29 or later, etc)
- GNU/Linux Arm 32/64-bit: any system with **GLIBC 2.27** or higher
  (like Raspberry Pi OS, Ubuntu 18 or later, Debian 10 or later, RedHat 8 later,
  Fedora 29 or later, etc)
- Intel macOS 64-bit: 10.13 or later
- Apple Silicon macOS 64-bit: 11.6 or later

## Install

The full details of installing the **xPack GNU texinfo** on various platforms
are presented in the separate
[Install]({{ site.baseurl }}/dev-tools/texinfo/install/) page.

### Easy install

The easiest way to install GNU texinfo is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/texinfo`](https://www.npmjs.com/package/@xpack-dev-tools/texinfo)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/texinfo@latest --verbose

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/texinfo@{{ page.version }}.{{ page.npm_subversion }} --verbose
```

It is also possible to install Meson Build globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/texinfo@latest --verbose
```

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/texinfo
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/texinfo
```

## Compliance

The xPack GNU texinfo generally follows the official
[GNU texinfo](https://www.gnu.org/software/texinfo/) releases.

The current version is based on:

- GNU texinfo version {{ page.texinfo_version }}
from {{ page.texinfo_date }}.

## Changes

Compared to the upstream version, there are no functional changes.

## Bug fixes

- none

## Enhancements

- none

## Known problems

- none

## Shared libraries

On all platforms the packages are standalone, and expect only the standard
runtime to be present on the host.

All dependencies that are build as shared libraries are copied locally
in the `libexec` folder (or in the same folder as the executable for Windows).

### `DT_RPATH` and `LD_LIBRARY_PATH`

On GNU/Linux the binaries are adjusted to use a relative path:

```console
$ readelf -d library.so | grep runpath
 0x000000000000001d (RPATH)            Library rpath: [$ORIGIN]
```

In the GNU ld.so search strategy, the `DT_RPATH` has
the highest priority, higher than `LD_LIBRARY_PATH`, so if this later one
is set in the environment, it should not interfere with the xPack binaries.

Please note that previous versions, up to mid-2020, used `DT_RUNPATH`, which
has a priority lower than `LD_LIBRARY_PATH`, and does not tolerate setting
it in the environment.

### `@rpath` and `@loader_path`

Similarly, on macOS, the binaries are adjusted with `install_name_tool` to use a
relative path.

## Documentation

The original documentation is available
[online](https://www.gnu.org/software/texinfo/manual/).

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/texinfo-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/texinfo-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/texinfo-xpack/builds/)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:

```txt
174af6609b6555f972ab9f54bc98b278fc2e692f1f333d9d5856c89fbd23504b
xpack-texinfo-7.0.3-1-darwin-arm64.tar.gz

66c1f31f96e7894082057f34d779c281fb32f5003c6921953e36085663412059
xpack-texinfo-7.0.3-1-darwin-x64.tar.gz

ceb08c01263f4b018103527fb49ff56dd55b654e528229528d7482f7cd2b7314
xpack-texinfo-7.0.3-1-linux-arm.tar.gz

5545066d35d0cdde35ac1fc340269046303c4a27e06184569a4d1b31e0514c2a
xpack-texinfo-7.0.3-1-linux-arm64.tar.gz

088585b714ca6fcd0097fc6bfb3b09ae751db8592727ebeeebcd3ab46ec13231
xpack-texinfo-7.0.3-1-linux-x64.tar.gz

```

## Deprecation notices

### 32-bit support

Support for 32-bit Intel Linux and Intel Windows was
dropped in 2022. Support for 32-bit Arm Linux (armv7l) will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### Linux minimum requirements

Support for RedHat 7 was dropped in 2022 and the
minimum requirement was raised to GLIBC 2.27, available starting
with Ubuntu 18, Debian 10 and RedHat 8.

## Pre-deprecation notice for Ubuntu 18.04

Ubuntu 18.04 LTS _Bionic Beaver_ reached the end of the standard five-year
maintenance window for Long-Term Support (LTS) release on 31 May 2023.

As a courtesy, the xPack GNU/Linux releases will continue to be based on
Ubuntu 18.04 for another year.

From mid-2024 onwards, the GNU/Linux binaries will be built on **Debian 10**,
(**GLIBC 2.28**), and are also expected to run on RedHat 8.

Users are urged to update their build and test infrastructure to
ensure a smooth transition to the next xPack releases.

## Download analytics

- GitHub [xpack-dev-tools/texinfo-xpack](https://github.com/xpack-dev-tools/texinfo-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/texinfo-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/texinfo-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/texinfo-xpack/total.svg)](https://github.com/xpack-dev-tools/texinfo-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=texinfo-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/texinfo](https://www.npmjs.com/package/@xpack-dev-tools/texinfo)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/texinfo.svg)](https://www.npmjs.com/package/@xpack-dev-tools/texinfo/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/texinfo.svg)](https://www.npmjs.com/package/@xpack-dev-tools/texinfo/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
