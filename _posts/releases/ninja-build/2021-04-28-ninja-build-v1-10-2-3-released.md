---
title:  xPack Ninja Build v1.10.2-3 released
sidebar: ninja-build

summary: "Version **1.10.2-3** is a maintenance release of the **xPack Ninja Build** package, fixing the spawning of cmd.exe scripts on Windows."

version: 1.10.2-3
npm_subversion: 1

download_url: https://github.com/xpack-dev-tools/ninja-build-xpack/releases/tag/v1.10.2-3/

date: 2021-04-28 22:58:00 +0300

redirect_to: https://xpack-dev-tools.github.io/ninja-build-xpack/blog/2021/04/28/ninja-build-v1-10-2-3-released/

comments: true

categories:
  - releases
  - ninja-build

tags:
  - releases
  - ninja-build
  - ninja
  - build
  - speed
  - small

---

The [xPack Ninja Build](https://xpack.github.io/dev-tools/ninja-build/)
is the **xPack** distribution of the
[Ninja](https://ninja-build.org) build system.

There are separate binaries for **Windows** (x64 and x86),
**macOS** (x64) and **GNU/Linux** (x64 and x86, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

{% include note.html content="For consistency with the Node.js naming conventions, the names of the 32-bit x86 images are now suffixed with `-ia32`." %}

## Install

The full details of installing the **xPack Ninja Build** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/ninja-build/install/) page.

### Easy install

The easiest way to install Ninja Build is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/ninja-build`](https://www.npmjs.com/package/@xpack-dev-tools/ninja-build)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```sh
xpm install --global @xpack-dev-tools/ninja-build@latest --verbose
```

To install this specific version, use:

```sh
xpm install --global @xpack-dev-tools/ninja-build@{{ page.version }}.{{ page.npm_subversion }}
```

## Compliance

The **xPack Ninja Build** is based on the official
[Ninja](https://ninja-build.org),
without any changes.

The current version is based on:

- Ninja release
[1.10.2](https://github.com/ninja-build/ninja/releases/tag/v1.10.1)
from Nov 28th, 2020.

## Bug fixes

- [#1] on Windows, starting npm/xpm applications via the `.cmd` forwarders
  still not fully functional, as it was shown when trying meson; the problem
  was identified as the missing quotes around the command passed to cmd.exe.

## Enhancements

- none

## Changes

Compared to the upstream version, the Windows version also supports
spawning scripts via `cmd.exe /c`. These scripts are used by **npm**/**xpm**
to redirect invocations to the global xPacks store.

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

The original documentation is available from:

- [https://ninja-build.org/manual.html](https://ninja-build.org/manual.html)

## Supported platforms

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

The binaries were built using the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

- x86/x64 GNU/Linux: all binaries were built with GCC 9.3, running in an
  Ubuntu 12 Docker container
- arm64/arm GNU/Linux: all binaries were built with GCC 9.3, running in an
  Ubuntu 16 Docker container
- x86/x64 Windows: all binaries were built with mingw-w64 GCC 9.3, running in an
  Ubuntu 12 Docker container
- x64 macOS: all binaries were built with GCC 9.3, running in a separate
  folder on macOS 10.10.5.

## Build

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/ninja-build-xpack/blob/xpack/README-MAINTAINER.md) page.

## Travis tests

The first set of tests were performed on Travis, by running
a simple script to check if the binaries start on a wide range of
platforms and distributions:

- [test xPack Ninja Build on stable platforms](https://travis-ci.com/github/xpack-dev-tools/ninja-build-xpack/builds/224429685)
- [test xPack Ninja Build on latest platforms](https://travis-ci.com/github/xpack-dev-tools/ninja-build-xpack/builds/224429690)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:

```txt

bab7c9f80775d71c28bbf0c7322e9209059ca435276df221506c6a84d501e822
xpack-ninja-build-1.10.2-3-darwin-x64.tar.gz

ae093330e3f55f983a8e8de3b3ee4d6962d8ac1ff439fa505ffa34e475d5c5f2
xpack-ninja-build-1.10.2-3-linux-arm64.tar.gz

97baabda3edf74726e5d60682a9b0fe95fdc8895e631694a65974ea94e4650a6
xpack-ninja-build-1.10.2-3-linux-arm.tar.gz

52ed3dd29174b584bd57ea100f69ab5b1888df7064b9368ba8522fb99957cdbd
xpack-ninja-build-1.10.2-3-linux-ia32.tar.gz

b49522febca4c4605e335b9482b96994f530729337623efc153098738f517e62
xpack-ninja-build-1.10.2-3-linux-x64.tar.gz

223a3a32c00c12f3a64e42994c88d28a2595f70369893187fef2c96deb0c9e5c
xpack-ninja-build-1.10.2-3-win32-ia32.zip

e25d9f00bb4052eb6c61641f69ea7dcbf8ab45212d3c2078c98ef2cd1a074a5e
xpack-ninja-build-1.10.2-3-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/ninja-build-xpack](https://github.com/xpack-dev-tools/ninja-build-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/ninja-build-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/ninja-build-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/ninja-build-xpack/total.svg)](https://github.com/xpack-dev-tools/ninja-build-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=ninja-build-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/ninja-build](https://www.npmjs.com/package/@xpack-dev-tools/ninja-build)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/ninja-build.svg)](https://www.npmjs.com/package/@xpack-dev-tools/ninja-build/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/ninja-build.svg)](https://www.npmjs.com/package/@xpack-dev-tools/ninja-build/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
