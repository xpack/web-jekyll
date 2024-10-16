---
title:  GNU MCU Eclipse ARM Embedded GCC v8.2.1-1.7 released
sidebar: arm-none-eabi-gcc

summary: "Version **8.2.1-1.7** is a maintenance release of **GNU MCU Eclipse ARM Embedded GCC** that that removes the illegal links present in the previous releases."
app_name: "GNU MCU Eclipse ARM Embedded GCC"

download_url: https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc/releases/tag/v8.2.1-1.7/

date: 2019-05-24 19:14:00 +0300

redirect_to: https://xpack-dev-tools.github.io/arm-none-eabi-gcc-xpack/blog/2019/05/24/arm-none-eabi-gcc-v8-2-1-1-7-released/

comments: true

categories:
  - releases
  - arm-none-eabi-gcc

tags:
  - releases
  - arm
  - arm-none-eabi-gcc
  - gcc
  - binaries
  - lto

---

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Compliance

This release follows the official
[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm)
**8-2018-q4-major** release from December 20, 2018 and it is based on the
`gcc-arm-none-eabi-8-2018-q4-major-src.tar.bz2` source invariant,
which include GCC 8.2.1. GDB was built with the latest available
sources (8.3.50).

## Changes

Compared to the ARM distribution, the build procedure is more or less the
same and there should be no functional differences, except the following
bug fixes:

- [Issue:[#4](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc-build/issues/4)]
  the Windows paths with spaces bug apparently was caused by an old version of
  and with the new version (5.0.4) the
  [89249](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89249)
  `gcc.c` patch is no longer needed;
- [Issue:[#3](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc-build/issues/3)]
  due to a problem in the GCC configure script and the specifics of the static
  build, LTO was not effective on Windows, and the initial workaround proved
  not effective either; in the new build environment the configure script is
  enables LTO and it is functional on windows too;
- [Issue:[#1](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc-build/issues/1)]
  the `liblto_plugin` copied/linked to the `lib/bdf-plugins` for `ar`
  to find it and be able to process archives with LTO objects
- a patch was applied to binutils to fix the 32-bit objcopy bug
  [24065](https://sourceware.org/bugzilla/show_bug.cgi?id=24065)
- a patch was applied to gcc to fix the Windows LTO with -g bug
  [89183](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89183)

Due to a large number of fixes needed, GDB was built with the
latest Git commit bda678b9 from 2019-05-09,
corresponding to GDB 8.3.50, to fix
the bugs affecting C++ LTO projects
[24145](https://sourceware.org/bugzilla/show_bug.cgi?id=24145).

## Python 3

Experimental support was added for Python 3 in GDB. Unfortunately compiling
GDB with mingw-w64 requires an update to the new Python 3
API, not yet available at the moment of this release.

Also support for 32-bit machines might not be fully functional.

## Binaries

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

The GNU/Linux binaries were built on two CentOS 6 Docker images (32/64-bit),
and run on any distribution based on CentOS 6 or later.

The macOS binary was built on a macOS 10.10.5 and must run on any newer
macOS system.

The Windows binaries were built with mingw-w64, and run on any reasonably
recent **i686** and **x86_64** Windows machines.

Instructions on how to install the binaries are available in the separate [How to install the ARM toolchain?]({{ site.baseurl }}/dev-tools/arm-none-eabi-gcc/install/) page.

The toolchain is also available as an
[xPack](https://www.npmjs.com/package/@gnu-mcu-eclipse/arm-none-eabi-gcc)
and can be conveniently installed with
[`xpm`](https://www.npmjs.com/package/xpm):

```sh
xpm install --global @gnu-mcu-eclipse/arm-none-eabi-gcc@latest
```

This installs the latest available version.

For better control and repeatability, the build scripts use Docker containers;
all files required during builds are available as a separate
[gnu-mcu-eclipse/arm-none-eabi-gcc-build](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc-build)
project.

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit, Ubuntu 18 LTS 64-bit,
Xubuntu 18 LTS 32-bit and macOS 10.13.

The tests consist in building and debugging some
[simple Eclipse projects](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc-build/tree/master/tests/eclipse)
available in the build project.

Since the source code used for GCC is identical to the one used by ARM, the
long and complex tests performed by ARM to validate their release were not
executed again.

## Known problems

* none (so far).

## Checksums

The SHA-256 hashes for the files are:

```txt
c832d4b8d7b91b6702f7188f0be30643b41991ce9ec91f4e67d821628898b564
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.7-20190524-0603-centos32.tgz

f15d9dd829262c0947a417da2626c2d4d6bd5ca7628ad7f3277d350b7986fa6c
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.7-20190524-0603-centos64.tgz

d6a162d33449282757573adab2aca8cc615d3e67a79c414dd2f6ee0c250d3a3a
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.7-20190524-0603-macos.tgz

9aa2da08fe265d31fd8291b8f4c7f20dbc3b1599d2d0c37a62c1ff28f637e43c
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.7-20190524-0603-win32.zip

7200a0d4a5bb99f6ee51b37c56716b83ffc9eb03ae5355e4a464f2d59910d214
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.7-20190524-0603-win64.zip
```
