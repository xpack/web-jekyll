---
title:  xPack GNU bison v3.8.2-1 released

summary: "Version **3.8.2-1** is the first release of GNU bison."

bison_version: "3.8.2"
bison_date: "2021-09-25"

version: "3.8.2-1"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/bison-xpack/releases/tag/v3.8.2-1/

comments: true

date:   2023-08-17 21:50:50 +0300

# For Jekyll releases selection.
categories:
  - releases
  - bison

# For navigation; use scripts/createtag.sh in Jekyll.
tags:
  - releases
  - bison

---

[The xPack GNU bison](https://xpack.github.io/bison/)
is a standalone cross-platform binary distribution of
[GNU bison](https://www.gnu.org/software/bison/).

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

The full details of installing the **xPack GNU bison** on various platforms
are presented in the separate
[Install]({{ site.baseurl }}/dev-tools/bison/install/) page.

### Easy install

The easiest way to install GNU bison is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/bison`](https://www.npmjs.com/package/@xpack-dev-tools/bison)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/bison@latest --verbose

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/bison@{{ page.version }}.{{ page.npm_subversion }} --verbose
```

It is also possible to install Meson Build globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/bison@latest --verbose
```

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/bison
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/bison
```

## Compliance

The xPack GNU bison generally follows the official
[GNU bison](https://www.gnu.org/software/bison/) releases.

The current version is based on:

- GNU bison version {{ page.bison_version }}
from {{ page.bison_date }}.

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
[online](https://www.gnu.org/software/bison/manual/).

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/bison-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/bison-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/bison-xpack/builds/)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:

```txt
e46dd1b8ae40125c7180470fccddde121ebf219e7cd27a3b7c118d2815247a3c
xpack-bison-3.8.2-1-darwin-arm64.tar.gz

d45064315fa2612817979399ac11532ffe68c4786fa664ed6655b233e8bc818b
xpack-bison-3.8.2-1-darwin-x64.tar.gz

b094cf6591d137ba5de81305f4e841c894ad5a2e2aa01447491e3bc82e1624c6
xpack-bison-3.8.2-1-linux-arm.tar.gz

907ff696b73a01d1224ac193c9e1a966bf53336eb3e7bc7dee459ea9e086284f
xpack-bison-3.8.2-1-linux-arm64.tar.gz

543bc8f31c05713c5506c1a7dfa4fe81e57dec3cc41c243a47a08e4defd6100d
xpack-bison-3.8.2-1-linux-x64.tar.gz

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

- GitHub [xpack-dev-tools/bison-xpack](https://github.com/xpack-dev-tools/bison-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/bison-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/bison-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/bison-xpack/total.svg)](https://github.com/xpack-dev-tools/bison-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=bison-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/bison](https://www.npmjs.com/package/@xpack-dev-tools/bison)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/bison.svg)](https://www.npmjs.com/package/@xpack-dev-tools/bison/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/bison.svg)](https://www.npmjs.com/package/@xpack-dev-tools/bison/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
