---
title:  xPack GNU flex v2.6.4-1 released

summary: "Version **2.6.4-1** is the first release of GNU flex."

flex_version: "2.6.4"
flex_date: "May 6, 2017"

version: "2.6.4-1"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/flex-xpack/releases/tag/v2.6.4-1/

comments: true

date: 2023-08-18 02:35:09 +0300

# For Jekyll releases selection.
categories:
  - releases
  - flex

# For navigation; use scripts/createtag.sh in Jekyll.
tags:
  - releases
  - flex

---

[The xPack GNU flex](https://xpack.github.io/flex/)
is a standalone cross-platform binary distribution of
[GNU flex](https://www.gnu.org/software/flex/).

There are separate binaries for
**macOS** (Intel 64-bit, Apple Silicon 64-bit)
and **GNU/Linux** (Intel 64-bit, Arm 32/64-bit).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
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

The full details of installing the **xPack GNU flex** on various platforms
are presented in the separate
[Install]({{ site.baseurl }}/dev-tools/flex/install/) page.

### Easy install

The easiest way to install GNU flex is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/flex`](https://www.npmjs.com/package/@xpack-dev-tools/flex)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/flex@latest --verbose

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/flex@{{ page.version }}.{{ page.npm_subversion }} --verbose
```

It is also possible to install Meson Build globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/flex@latest --verbose
```

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/flex
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/flex
```

## Compliance

The xPack GNU flex generally follows the official
[GNU flex](https://www.gnu.org/software/flex/) releases.

The current version is based on:

- GNU flex version {{ page.flex_version }}
from {{ page.flex_date }}.

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
[online](https://www.gnu.org/software/flex/manual/).

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/flex-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/flex-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/flex-xpack/builds/)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:

```txt
5b26784eee815f81decc3f77eb414019576e453154664433c2714817d43925cb
xpack-flex-2.6.4-1-darwin-arm64.tar.gz

3b6b672e30e6c91557b14f3aea523e2af42140e18905ef741cb88a3b8e5eb7ab
xpack-flex-2.6.4-1-darwin-x64.tar.gz

f58f75328b2adac7e7004460d68df5a0a900928d692481f814db0a61a0da1996
xpack-flex-2.6.4-1-linux-arm.tar.gz

356493f256c68a7fb371ff2dd7d0795d799b9becbc1c5cc3ca3e50efb7952ae9
xpack-flex-2.6.4-1-linux-arm64.tar.gz

131fcc0a59a0bdc56c15754d3e8d7d570e003b8cd28eeea391ec0fe20b4c8616
xpack-flex-2.6.4-1-linux-x64.tar.gz

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

From 2025 onwards, the GNU/Linux binaries will be built on **Debian 10**,
(**GLIBC 2.28**), and are also expected to run on RedHat 8.

Users are urged to update their build and test infrastructure to
ensure a smooth transition to the next xPack releases.

## Download analytics

- GitHub [xpack-dev-tools/flex-xpack](https://github.com/xpack-dev-tools/flex-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/flex-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/flex-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/flex-xpack/total.svg)](https://github.com/xpack-dev-tools/flex-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=flex-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/flex](https://www.npmjs.com/package/@xpack-dev-tools/flex)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/flex.svg)](https://www.npmjs.com/package/@xpack-dev-tools/flex/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/flex.svg)](https://www.npmjs.com/package/@xpack-dev-tools/flex/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
