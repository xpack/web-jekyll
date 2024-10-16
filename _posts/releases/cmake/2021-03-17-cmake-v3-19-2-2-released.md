---
title:  xPack CMake v3.19.2-2 released
sidebar: cmake

summary: "Version **3.19.2-2** is a maintenance release of the **xPack CMake** package, fixing the spawning of cmd.exe scripts on Windows."

version: 3.19.2-2
npm_subversion: 1

download_url: https://github.com/xpack-dev-tools/cmake-xpack/releases/tag/v3.19.2-2/

date: 2021-03-16 23:30:00 +0200

redirect_to: https://xpack-dev-tools.github.io/cmake-xpack/blog/2021/03/17/cmake-v3-19-2-2-released/

comments: true

categories:
  - releases
  - cmake

tags:
  - releases
  - cmake
  - build

---

The [xPack CMake](https://xpack.github.io/dev-tools/cmake/)
is the **xPack** distribution of the
[CMake](https://cmake.org) build system.

There are separate binaries for **Windows** (x64 and x86),
**macOS** (x64) and **GNU/Linux** (x64 and x86, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

{% include note.html content="For consistency with the Node.js naming conventions, the names of the 32-bit x86 images are now suffixed with `-ia32`." %}

## Install

The full details of installing the **xPack CMake** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/cmake/install/) page.

### Easy install

The easiest way to install CMake is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/cmake`](https://www.npmjs.com/package/@xpack-dev-tools/cmake)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```sh
xpm install --global @xpack-dev-tools/cmake@latest --verbose
```

To install this specific version, use:

```sh
xpm install --global @xpack-dev-tools/cmake@{{ page.version }}.{{ page.npm_subversion }}
```

## Compliance

The **xPack CMake** is based on the official
[CMake](https://cmake.org).

The current version is based on:

- CMake release
[3.19.2](https://github.com/Kitware/CMake/releases/tag/v3.19.2/)
from Dec 16th, 2020.

## Changes

Compared to the upstream version, the Windows version also supports
spawning scripts via `cmd.exe /c`. These scripts are used by **npm**/**xpm**
to redirect invocations to the global xPacks store.

## Bug fixes

- none

## Enhancements

- none

## Known problems

- none

## Shared libraries

On all platforms the packages are standalone, and expect only the standard
runtime to be present on the host.

All dependencies that are build as shared libraries are copied locally in the
same folder as the executable.

### `DT_RPATH` and `LD_LIBRARY_PATH`

On GNU/Linux the binaries are adjusted to use a relative path:

```console
$ readelf -d library.so | grep runpath
 0x000000000000001d (RPATH)            Library rpath: [$ORIGIN]
```

In the GNU ld.so search strategy, the `DT_RPATH` has
the highest priority, higher than `LD_LIBRARY_PATH`, so if this later one
is set in the environment, it should not interfere with the xPack binaries.

### `@executable_path`

Similarly, on macOS, the binaries are adjusted with `otool` to use a
relative path.

## Documentation

The current version specific CMake documentation is available in each packet:

- `doc/cmake-X.Y/html/index.html`

and online from:

- [https://cmake.org/documentation/](https://cmake.org/documentation/)

## Supported platforms

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

The binaries were built using the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

- x86/x64 GNU/Linux: all binaries were built with GCC 9.3, running in an
  Ubuntu 12 Docker container
- arm64/arm GNU/Linux: all binaries were built with GCC 9.3, running in an
  Ubuntu 16 Docker container (added in mid-2020)
- x86/x64 Windows: all binaries were built with mingw-w64 GCC 9.3, running in an
  Ubuntu 12 Docker container
- x64 macOS: all binaries were built with GCC 9.3, running in a separate
  folder on macOS 10.10.5.

## Build

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/cmake-xpack/blob/xpack/README-MAINTAINER.md) page.

## Travis tests

The first set of tests were performed on Travis, by running
a simple script to check if the binaries start on a wide range of
platforms and distributions:

- [test xPack CMake on stable platforms](https://travis-ci.com/github/xpack-dev-tools/cmake-xpack/builds/220317746)
- [test xPack CMake on latest platforms](https://travis-ci.com/github/xpack-dev-tools/cmake-xpack/builds/220317753)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:

```txt
1327ee08eec7e09e79e5f7a5f5a29f3bfb8639987bb147887f52627d510943b4
xpack-cmake-3.19.2-2-darwin-x64.tar.gz

1fcb3c2733a955cca4ea45cc32fadabb4f74b02acbb2e6150d97d9aa00e4e307
xpack-cmake-3.19.2-2-linux-arm64.tar.gz

12bb352b4222a4c93b7085159de46415bd09853ffdc5089113687e10a37fa48e
xpack-cmake-3.19.2-2-linux-arm.tar.gz

149cc2b100fd84ec556ee26ed7ec0810540f75eea0595eeae518721e449c896d
xpack-cmake-3.19.2-2-linux-ia32.tar.gz

056809b71f26ed1b9261a0a09d4d6348d2328d0af8be2e23ee00eb34fc012e23
xpack-cmake-3.19.2-2-linux-x64.tar.gz

e363cbb04577864ab69260ec7cc5af8ac08f38640d60a90d8419bacb2a2d6e70
xpack-cmake-3.19.2-2-win32-ia32.zip

27a6e0e40be3b4beb354f1d1901ad02e433442955eafef273755929287b94569
xpack-cmake-3.19.2-2-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/cmake-xpack](https://github.com/xpack-dev-tools/cmake-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/cmake-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/cmake-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/cmake-xpack/total.svg)](https://github.com/xpack-dev-tools/cmake-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=cmake-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/cmake](https://www.npmjs.com/package/@xpack-dev-tools/cmake)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/cmake.svg)](https://www.npmjs.com/package/@xpack-dev-tools/cmake/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/cmake.svg)](https://www.npmjs.com/package/@xpack-dev-tools/cmake/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
