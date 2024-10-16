---
title:  GNU MCU Eclipse ARM Embedded GCC v8.2.1-1.2 released
sidebar: arm-none-eabi-gcc

summary: "Version **8.2.1-1.2** is a maintenance release of **GNU MCU Eclipse ARM Embedded GCC** that fixes the 32-bit objcopy bug present in the previous release."
app_name: "GNU MCU Eclipse ARM Embedded GCC"

download_url: https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc/releases/tag/v8.2.1-1.2/

date: 2019-01-19 21:46:00 +0300

redirect_to: https://xpack-dev-tools.github.io/arm-none-eabi-gcc-xpack/blog/2019/01/20/arm-none-eabi-gcc-v8-2-1-1-2-released/

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

---

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Deprecated

Use v8.2.1-1.6.

## Compliance

This release follows the official
[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm)
**8-2018-q4-major** release from December 20, 2018 and it is based on the
`gcc-arm-none-eabi-8-2018-q4-major-src.tar.bz2` source invariant.

The patch to fix `objcopy` is from [git](https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=a9859e01726d085db79cff88550fdb38e2434e42;hp=171b8e19575654ab32321eb99f3fd112663ae7fa).

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

## Known problems

* none.

## Checksums

The SHA-256 hashes for the files are:

```txt
b52328f55ac1477c09dfb9132f2763b5c449560bfbfbeed7c0e5071bcd938def ?
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.2-20190119-1237-centos32.tgz

2e3b920552fcebe65c56013e36e479e225079842f284522a8bedac7eaea19435 ?
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.2-20190119-1237-centos64.tgz

b6c38190f3e8769eaf3a95668e7664138516e4695df81b252605b94c112680d1 ?
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.2-20190119-1237-macos.tgz

5867fe4874f028b79b22d39a32b8db71b2fae7f2c7087d641404b1b8840ae891 ?
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.2-20190119-1237-win32.zip

f9c2653801319ec8156aca2fd6fa3462206959f421e672d29488878e9370799e ?
gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.2-20190119-1237-win64.zip
```
