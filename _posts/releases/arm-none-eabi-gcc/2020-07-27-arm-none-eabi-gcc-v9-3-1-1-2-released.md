---
title:  xPack GNU Arm Embedded GCC v9.3.1-1.2 released

summary: "Version 9.3.1-1.2 is a maintenance release of **xPack GNU Arm 
Embedded GCC**, intended to **fix C++ exceptions** support for non-nano 
libraries, and to use **DT_RPATH** to make the binaries immune to custom
LD_LIBRARY_PATH."

arm_version: 9-2020-q2-update
arm_date: June 01, 2020
version: 9.3.1-1.2
npm_subversion: 1
download_url: https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v9.3.1-1.2/

date:   2020-07-27 11:23:00 +0300

categories:
  - releases
  - arm-none-eabi-gcc

tags:
  - releases
  - arm
  - arm-none-eabi-gcc
  - gcc
  - binaries
  - c++
  - exceptions

---

This is the **xPack** distribution of the
[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm).

There are separate binaries for **Windows** 32/64-bit, **macOS**,
**Intel GNU/Linux** 32/64-bit and **Arm GNU/Linux** 32/64-bit platforms,
like **Raspberry Pi**.

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Install

The full details of installing the **xPack GNU Arm Embedded GCC** on
various platforms are presented in the separate
[Install]({{ site.baseurl }}/arm-none-eabi-gcc/install/) page.

### Easy install

The easiest way to install GNU Arm Embedded GCC is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/arm-none-eabi-gcc`](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```console
$ xpm install --global @xpack-dev-tools/arm-none-eabi-gcc@latest
```

To install this specific version, use:

```console
$ xpm install --global @xpack-dev-tools/arm-none-eabi-gcc@{{ page.version }}.{{ page.npm_subversion }}
```

## Compliance

This release follows the official
[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm)
**{{ page.arm_version }}** release {{ page.arm_date }} and it is based on the
`gcc-arm-none-eabi-9-2020-q2-update-src.tar.bz2` source invariant.

For more details see the original Arm release text files:

- `distro-info/arm-readme.txt`
- `distro-info/arm-release.txt`

## Supported libraries

The supported libraries are:

```console
$ arm-none-eabi-gcc -print-multi-lib
.;
arm/v5te/softfp;@marm@march=armv5te+fp@mfloat-abi=softfp
arm/v5te/hard;@marm@march=armv5te+fp@mfloat-abi=hard
thumb/nofp;@mthumb@mfloat-abi=soft
thumb/v7/nofp;@mthumb@march=armv7@mfloat-abi=soft
thumb/v7+fp/softfp;@mthumb@march=armv7+fp@mfloat-abi=softfp
thumb/v7+fp/hard;@mthumb@march=armv7+fp@mfloat-abi=hard
thumb/v7-r+fp.sp/softfp;@mthumb@march=armv7-r+fp.sp@mfloat-abi=softfp
thumb/v7-r+fp.sp/hard;@mthumb@march=armv7-r+fp.sp@mfloat-abi=hard
thumb/v6-m/nofp;@mthumb@march=armv6s-m@mfloat-abi=soft
thumb/v7-m/nofp;@mthumb@march=armv7-m@mfloat-abi=soft
thumb/v7e-m/nofp;@mthumb@march=armv7e-m@mfloat-abi=soft
thumb/v7e-m+fp/softfp;@mthumb@march=armv7e-m+fp@mfloat-abi=softfp
thumb/v7e-m+fp/hard;@mthumb@march=armv7e-m+fp@mfloat-abi=hard
thumb/v7e-m+dp/softfp;@mthumb@march=armv7e-m+fp.dp@mfloat-abi=softfp
thumb/v7e-m+dp/hard;@mthumb@march=armv7e-m+fp.dp@mfloat-abi=hard
thumb/v8-m.base/nofp;@mthumb@march=armv8-m.base@mfloat-abi=soft
thumb/v8-m.main/nofp;@mthumb@march=armv8-m.main@mfloat-abi=soft
thumb/v8-m.main+fp/softfp;@mthumb@march=armv8-m.main+fp@mfloat-abi=softfp
thumb/v8-m.main+fp/hard;@mthumb@march=armv8-m.main+fp@mfloat-abi=hard
thumb/v8-m.main+dp/softfp;@mthumb@march=armv8-m.main+fp.dp@mfloat-abi=softfp
thumb/v8-m.main+dp/hard;@mthumb@march=armv8-m.main+fp.dp@mfloat-abi=hard
```

## Bug fixes

- [[#7]](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/issues/7)
Due to a bug in the build scripts, the non-nano libraries were also build
without C++ exceptions support; fixed.

## Enhancements

The relative path in binaries was changed from `DT_RUNPATH` to `DT_RPATH`;
this improves reliability, since the binaries can no longer be affected
by custom `LD_LIBRARY_PATH`, as when using `DT_RUNPATH`.

## Changes

There should be no functional changes.

Starting with 9.x, the new archives are created with
a single folder named `xpack-arm-none-eabi-gcc-9.3.1-1.2` instead of
the hierarchical `xPacks/arm-none-eabi-gcc/9.3.1-1.2`. This internal
folder name is used consistently on all platforms. The archive extension
was changed to `.tar.gz`.

With these changes, the archives can now be used directly in other
development environments (like Arduino), without having to repack them.

## Python

Support for Python scripting was added to GDB. This distribution provides
two separate binaries,
`arm-none-eabi-gdb-py` with Python 2.7 support, and `arm-none-eabi-gdb-py3` with
support for Python 3.7.

Mode details on the prerequisites of running GDB with Python support are
available from
[GDB with Python support](https://xpack.github.io/arm-none-eabi-gcc/python/).

## Text User Interface (TUI)

Support for TUI was added to GDB. The `ncurses` library (v6.2) was added to
the distribution.

Note: TUI is not available on Windows.

## Known problems

- the GDB binaries with Python support were built with version 2.7/3.7,
 and require exactly those versions in order to run properly.

## Shared libraries

On all platforms the packages are standalone, and expect only the standard
runtime to be present on the host.

All dependencies that are build as shared libraries are copied locally in the
same folder as the executable.

### `DT_RPATH` and `LD_LIBRARY_PATH`

On GNU/Linux the binaries are adjusted to use a relative path:

```console
$ readelf -d library.so | grep rpath
 0x000000000000001d (RPATH)            Library runpath: [$ORIGIN]
```

In the GNU ld.so search strategy, the `DT_RPATH` has
the highest priority, higher than `LD_LIBRARY_PATH`, so if this later one
is set in the environment, it should not interfere with the xPack binaries.

Please note that previous versions, up to mid-2020, used `DT_RUNPATH`, which
has a priority lower than `LD_LIBRARY_PATH`, and does not tolerate setting
it in the environment.

### `@executable_path`

Similarly, on macOS, the dynamic libraries are adjusted with `otool` to use a
relative path.

## Documentation

The original PDF documentation is available in the `share/doc` folder.

## Supported platforms

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

The binaries were built using the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

- Intel GNU/Linux: all binaries were built with GCC 9.3, running in an
  Ubuntu 12 Docker container
- Arm GNU/Linux: all binaries were built with GCC 9.3, running in an
  Ubuntu 16 Docker container (added in mid-2020)
- Windows: all binaries were built with mingw-w64 GCC 9.3, running in an
  Ubuntu 12 Docker container
- macOS: all binaries were built with GCC 9.3, running in a separate
  folder on macOS 10.10.5.

## Build

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/blob/xpack/README-BUILD.md) page.

## Travis tests

The first set of tests were performed on Travis, by running
a simple script to check if the binaries start and compile several simple
programs on a wide range of platforms and distributions:

- [test xPack Arm Embed GCC on stable platforms](https://travis-ci.org/github/xpack-dev-tools/arm-none-eabi-gcc-xpack/builds/721612783)
- [test xPack Arm Embed GCC on latest platforms](https://travis-ci.org/github/xpack-dev-tools/arm-none-eabi-gcc-xpack/builds/721619581)

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit, Ubuntu 18 LTS 64-bit,
Xubuntu 18 LTS 32-bit and macOS 10.13.

The tests consist in building and debugging some
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the project.

Since the source code used for GCC is identical to the one used by Arm, the
long and complex tests performed by Arm to validate their release were not
executed again.

## Checksums

The SHA-256 hashes for the files are:

```
622a4d54cef4c88f3a2ba2fc312a9490f5c406feb2ab16e3eda3cb053c12a1bf
xpack-arm-none-eabi-gcc-9.3.1-1.2-darwin-x64.tar.gz

fb3258a52d09bae05f81e15c0fecde0d8930e14fda6b3dee89971b6a5c0d6f21
xpack-arm-none-eabi-gcc-9.3.1-1.2-linux-arm64.tar.gz

34a977e63ae11b8854e35ed8698f2641a83536b455a3529d2801e1c538e1d6ae
xpack-arm-none-eabi-gcc-9.3.1-1.2-linux-arm.tar.gz

f633d3017edc7d8aa0c21112dcc84bb3a5474a7a9c127134b036e1b6db544794
xpack-arm-none-eabi-gcc-9.3.1-1.2-linux-x32.tar.gz

ada5b1e4d4fd6f6ffe80c398188eab5d2fc43639cb219fe212576f4bc2ebe35a
xpack-arm-none-eabi-gcc-9.3.1-1.2-linux-x64.tar.gz

90d075bf405c5f427d674ad874680d8c31f4d1ea293bd8392b4dee04da411759
xpack-arm-none-eabi-gcc-9.3.1-1.2-win32-x32.zip

ad9e7a9c0e64a7ebc38b431876dc4998f655a4385e56b7283a11ef1a5247567d
xpack-arm-none-eabi-gcc-9.3.1-1.2-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/arm-none-eabi-gcc-xpack](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/arm-none-eabi-gcc-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v{{ page.version }}/)
  - all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/arm-none-eabi-gcc-xpack/total.svg)](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/)
  - GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/arm-none-eabi-gcc/total.svg)](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc/releases/)
  - [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=arm-none-eabi-gcc-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/arm-none-eabi-gcc](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/arm-none-eabi-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
