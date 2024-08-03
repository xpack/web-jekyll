---
title:  xPack XBB Bootstrap v4.0 released

summary: "Version **4.0** is a new release; it is intended to replace the functionality provided by the XBB v3.4 Docker images."

download_url: https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/releases/tag/v4.0/

date: 2022-10-03 21:05:43 +0300

comments: true

categories:
  - releases
  - xbb-bootstrap

tags:
  - releases
  - xbb

---

[The xPack XBB Bootstrap](https://xpack.github.io/dev-tools/xbb-bootstrap/)
is a temporary solution intended to replace the functionality
provided by the XBB v3.4 Docker images until separate packages will
be available with all required tools.

There are separate binaries for
**macOS** (Intel 64-bit, Apple Silicon 64-bit)
and **GNU/Linux** (Intel 64-bit, Arm 32/64-bit).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

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

The full details of installing the **xPack XBB Bootstrap** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/xbb-bootstrap/install/) page.

### Easy install

The easiest way to install XBB Bootstrap is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/xbb-bootstrap`](https://www.npmjs.com/package/@xpack-dev-tools/xbb-bootstrap)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/xbb-bootstrap@latest

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/xbb-bootstrap@4.0
```

For xPacks aware tools,
it is also possible to install XBB Bootstrap globally, in the user home folder.

```sh
xpm install --global @xpack-dev-tools/xbb-bootstrap@latest --verbose
```

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/xbb-bootstrap
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/xbb-bootstrap
```

## Compliance

The xPack XBB Bootstrap tools generally uses the official sources
of the tools, without changes.

The included tools are:

- bash 5.1.8
- bison 3.8.2
- coreutils 9.0
- curl 7.80.0
- diffutils 3.8
- dos2unix 7.4.2
- gawk 5.1.1
- gettext 0.21
- gnutls 3.7.2
- gnupg 2.3.3
- m4 1.4.19
- make 4.3
- makedepend 1.0.6
- openssl 1.1.1q
- p7zip 17.04
- patch 2.7.6
- patchelf 0.14.3
- perl 5.34
- pkg_config 0.29.2
- python3 3.9.9
- rhash 1.4.3
- re2c 2.2
- sed 4.8
- tar 1.34
- tcl 8.6.12
- texinfo 6.8
- wget 1.20.3
- xz 5.2.5

The versions match those in XBB v3.4, except p7zip and rhash, which were upgraded to simplify the build.

## Changes

There are no functional changes.

## Bug fixes

- none

## Enhancements

- none

## Known problems

- `bzcmp` is a link pointing to the absolute location where the package
  was built, and fails to start
- Perl scripts originally used absolute paths to invoke the interpreter,
  making them non-relocatable; the paths were replaced by simply `perl`,
  which is functional but requires the desired interpreter to be in the
  PATH; for xPacks this means the `xpacks/.bin` folder must be in the
  path, condition normally met when invoked via xpm actions.
- the Python associated scripts (`2to3-3.9`, `idle-3.9`,
  `pydoc3.9`, `python-3.9-config`) also were non-relocatable, and
  were adjusted to invoke `python3` directly, requiring it to be in the PATH.

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

The original documentation for the included components is available online.

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/xbb-bootstrap-xpack/builds/)

## Tests

The binaries were testes on Intel Ubuntu 18
LTS 64-bit and macOS 10.13 / 11.6.

## Checksums

The SHA-256 hashes for the files are:

```txt
ee1a9b3d5df6e6d9d5c6215d66bd1b80c81ea19724984b7386f05bd8a5fb9f45
xpack-xbb-bootstrap-4.0-darwin-arm64.tar.gz

13af2fc26d334321606cdbd4b7f8c97800a89f1461e60f701f2dadb40609979a
xpack-xbb-bootstrap-4.0-darwin-x64.tar.gz

cf533d08d3c92c335b99cddd7aeb15dfcef55d0d3980ec57039ec3d1f167f34b
xpack-xbb-bootstrap-4.0-linux-arm.tar.gz

94b7a734d0f75398279a2179f6046efa381a4665d3039e3d8bd6f6f25b33864d
xpack-xbb-bootstrap-4.0-linux-arm64.tar.gz

8c64e44b2b02c8d59ded9120d787c223c020a0ac0f45b633b1012cd99b302673
xpack-xbb-bootstrap-4.0-linux-x64.tar.gz

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

## Download analytics

- GitHub [xpack-dev-tools/xbb-bootstrap-xpack](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/xbb-bootstrap-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/xbb-bootstrap-xpack/total.svg)](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=xbb-bootstrap-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/xbb-bootstrap](https://www.npmjs.com/package/@xpack-dev-tools/xbb-bootstrap)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/xbb-bootstrap.svg)](https://www.npmjs.com/package/@xpack-dev-tools/xbb-bootstrap/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/xbb-bootstrap.svg)](https://www.npmjs.com/package/@xpack-dev-tools/xbb-bootstrap/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
