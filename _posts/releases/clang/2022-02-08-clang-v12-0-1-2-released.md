---
title:  xPack LLVM clang v12.0.1-2 released
sidebar: clang

summary: "Version **12.0.1-2** is a maintenance release; it updates to the latest build scripts and adds support for Apple Silicon."

version: 12.0.1-2
npm_subversion: 2

download_url: https://github.com/xpack-dev-tools/clang-xpack/releases/tag/v12.0.1-2/

date: 2022-02-08 18:56:37 +0200

redirect_to: https://xpack-dev-tools.github.io/clang-xpack/blog/2022/02/08/clang-v12-0-1-2-released/

comments: true

categories:
  - releases
  - clang

tags:
  - releases
  - clang

---

The [xPack LLVM clang](https://xpack.github.io/dev-tools/clang/)
is a standalone cross-platform binary distribution of
[LLVM clang](https://clang.llvm.org).

There are separate binaries for **Windows** (x64),
**macOS** (x64, arm64)
and **GNU/Linux** (x64, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Prerequisites

- x64 GNU/Linux: any system with **GLIBC 2.27** or higher
  (like Ubuntu 18 or later, Debian 10 or later, RedHat 8 or later,
  Fedora 29 or later, etc)
- arm64/arm GNU/Linux: any system with **GLIBC 2.27** or higher
  (like Raspberry Pi OS, Ubuntu 18 or later, Debian 10 or later, RedHat 8 or later,
  Fedora 29 or later, etc)
- x64 Windows: Windows 7 with the Universal C Runtime
  ([UCRT](https://support.microsoft.com/en-us/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c)),
  Windows 8, Windows 10
- x64 macOS: 10.13 or later
- arm64 macOS: 11.6 or later

## Install

The full details of installing the **xPack LLVM clang** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/clang/install/) page.

### Easy install

The easiest way to install LLVM clang is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/clang`](https://www.npmjs.com/package/@xpack-dev-tools/clang)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/clang@latest

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/clang@{{ page.version }}.{{ page.npm_subversion }}
```

It is also possible to install LLVM clang globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/clang@latest --verbose
```

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/clang
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/clang
```

## Compliance

The xPack LLVM clang generally follows the official
[LLVM clang](https://clang.llvm.org) releases.

The current version is based on:

- LLVM clang version [12.0.1](https://releases.llvm.org/download.html#12.0.1), from July 8th, 2021.

## Changes

Compared to the upstream, there are no functional changes.

## Bug fixes

- none

## Enhancements

- none

## Known problems

- on GNU/Linux, support for the clang run-time and C++ libraries is basic,
  the libraries are available, but using them is tricky, since it requires
  the compiled binaries to take care of the path to them, otherwise it is
  very likely that the system libraries will be used; thus it is
  recommended to avoid such use cases.
- on macOS, the `/Library/Developer/CommandLineTools/usr/include/c++/v1`
  was added to the include path; unfortunately this may crash some builds;
  removed in 15.0.7-3
- when clang is invoked via a link from a different folder, the `InstalledDir`
  does not reflect the correct install folder, and the new clang system headers
  are either not found or the host system headers are used; fixed in 15.0.7-4

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

To save space and bandwidth, the original documentation is available
[online](https://clang.llvm.org/docs/UsersManual.html).

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/clang-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/clang-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/clang-xpack/builds/)

## Tests

The binaries were tested on a variety of platforms,
but mainly to check the integrity of the
build, not the compiler functionality.

## Checksums

The SHA-256 hashes for the files are:

```txt
8e01dfb53b5d28fab720ad33cf5eaa02b33cdb37dbda3153efb4870df696f694
xpack-clang-12.0.1-2-darwin-arm64.tar.gz

9ac47219037ecd28451ff381849ec81725f0ba7f917e11ef53b745f13b6a14dd
xpack-clang-12.0.1-2-darwin-x64.tar.gz

8829994535c4fe7acc1226501f298ede1c84fe1430dd56f8e68a655c1965a4a9
xpack-clang-12.0.1-2-linux-arm.tar.gz

61135802324fea5cd4db71f4881975826e8e31aa79ef1ada70fc9a991937eda1
xpack-clang-12.0.1-2-linux-arm64.tar.gz

8c4e4f84ff3df09a88030dc60be644b7738c2c4e2d3a4ec252357b4509c7f2b0
xpack-clang-12.0.1-2-linux-x64.tar.gz

681dc81f5ca4c817d0a015736a43bb8e334fa0b2757325e00c3092ef2eec1106
xpack-clang-12.0.1-2-win32-x64.zip

```

## Deprecation notices

### 32-bit support

Support for 32-bit x86 GNU/Linux and x86 Windows was
dropped in 2022. Support for 32-bit Arm GNU/Linux will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### GNU/Linux minimum requirements

Support for RedHat 7 was dropped in 2022 and the
minimum requirement was raised to GLIBC 2.27, available starting
with Ubuntu 18, Debian 10 and RedHat 8.

## Download analytics

- GitHub [xpack-dev-tools/clang-xpack](https://github.com/xpack-dev-tools/clang-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/clang-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/clang-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/clang-xpack/total.svg)](https://github.com/xpack-dev-tools/clang-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=clang-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/clang](https://www.npmjs.com/package/@xpack-dev-tools/clang)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/clang.svg)](https://www.npmjs.com/package/@xpack-dev-tools/clang/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/clang.svg)](https://www.npmjs.com/package/@xpack-dev-tools/clang/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
