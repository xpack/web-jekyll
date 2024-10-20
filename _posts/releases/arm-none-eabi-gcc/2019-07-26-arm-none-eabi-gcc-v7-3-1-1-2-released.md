---
title:  xPack GNU Arm Embedded GCC v7.3.1-1.2 released
sidebar: arm-none-eabi-gcc

summary: "Version **7.3.1-1.2** is a maintenance release; it repacks the GNU MCU Eclipse Arm Embedded GCC v7.3.1-1.1 using the new build scripts."

version: 7.3.1-1.2
npm_subversion: 2

download_url: https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v7.3.1-1.2/

date: 2019-07-26 12:09:00 +0300

redirect_to: https://xpack-dev-tools.github.io/arm-none-eabi-gcc-xpack/blog/2019/07/26/arm-none-eabi-gcc-v7-3-1-1-2-released/

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

## Install

The full details of installing the **xPack GNU Arm Embedded GCC** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/arm-none-eabi-gcc/install/) page.

### Easy install

The easiest way to install GNU Arm Embedded GCC is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/arm-none-eabi-gcc`](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```sh
xpm install --global @xpack-dev-tools/arm-none-eabi-gcc@latest --verbose
```

To install this specific version, use:

```sh
xpm install --global @xpack-dev-tools/arm-none-eabi-gcc@{{ page.version }}.{{ page.npm_subversion }}
```

## Compliance

This release follows the official
[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm)
**7-2018-q2-update** release from June 27, 2018 and it is based on the
`gcc-arm-none-eabi-7-2018-q2-update-src.tar.bz2` source invariant.

For more details see the original Arm release text files:

- `distro-info/arm-readme.txt`
- `distro-info/arm-release.txt`

## Supported libraries

The supported libraries are:

```console
$ arm-none-eabi-gcc -print-multi-lib
.;
thumb;@mthumb
hard;@mfloat-abi=hard
thumb/v6-m;@mthumb@march=armv6s-m
thumb/v7-m;@mthumb@march=armv7-m
thumb/v7e-m;@mthumb@march=armv7e-m
thumb/v7-ar;@mthumb@march=armv7
thumb/v8-m.base;@mthumb@march=armv8-m.base
thumb/v8-m.main;@mthumb@march=armv8-m.main
thumb/v7e-m/fpv4-sp/softfp;@mthumb@march=armv7e-m@mfpu=fpv4-sp-d16@mfloat-abi=softfp
thumb/v7e-m/fpv4-sp/hard;@mthumb@march=armv7e-m@mfpu=fpv4-sp-d16@mfloat-abi=hard
thumb/v7e-m/fpv5/softfp;@mthumb@march=armv7e-m@mfpu=fpv5-d16@mfloat-abi=softfp
thumb/v7e-m/fpv5/hard;@mthumb@march=armv7e-m@mfpu=fpv5-d16@mfloat-abi=hard
thumb/v7-ar/fpv3/softfp;@mthumb@march=armv7@mfpu=vfpv3-d16@mfloat-abi=softfp
thumb/v7-ar/fpv3/hard;@mthumb@march=armv7@mfpu=vfpv3-d16@mfloat-abi=hard
thumb/v8-m.main/fpv5-sp/softfp;@mthumb@march=armv8-m.main@mfpu=fpv5-sp-d16@mfloat-abi=softfp
thumb/v8-m.main/fpv5-sp/hard;@mthumb@march=armv8-m.main@mfpu=fpv5-sp-d16@mfloat-abi=hard
thumb/v8-m.main/fpv5/softfp;@mthumb@march=armv8-m.main@mfpu=fpv5-d16@mfloat-abi=softfp
thumb/v8-m.main/fpv5/hard;@mthumb@march=armv8-m.main@mfpu=fpv5-d16@mfloat-abi=hard
```

## Changes

There should be no functional changes.

### `lib/bdf-plugins`

To improve LTO support, the `lib/bdf-plugins` folder was added, with
a link to the `liblto_plugin.so` library (a file copy on Windows).

This allows the use of traditional program names, like `arm-none-eabi-ar`
instead of the new `arm-none-eabi-gcc-ar`, without getting errors like:

```sh
arm-none-eabi-ar -r  "libarm-static-lib.a"  ./lib.o
arm-none-eabi-ar: creating libarm-static-lib.a
arm-none-eabi-ar: ./lib.o: plugin needed to handle lto object <---
```

The issue was reported to Arm as bug [1838049](https://bugs.launchpad.net/gcc-arm-embedded/+bug/1838049).

## Known problems

- due to some changes in newlib 2.9.1, the definition of the `_EXFUN` macro
  changed and the semihosting projects created with old GNU MCU Eclipse
  fail to build with a compile error in
  `system/src/newlib/_syscalls.c`. The problem was in the project template
  [#317](https://github.com/gnu-mcu-eclipse/eclipse-plugins/issues/317), and
  was fixed in GNU MCU Eclipse plug-ins v4.4.2 (2018-08-27).
- [[#1]](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/issues/1)
  Due to an omission in the build scripts, the content of the `libgcov`
  library is mostly empty; the problem was fixed starting with v8.3.1-1.2.

## Documentation

The original PDF documentation is available in the `share/doc` folder.

## Supported platforms

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

The binaries were built using the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

- x86/x64 GNU/Linux: all binaries were built with GCC 7.4, running in a CentOS 6
  Docker container
- x86/x64 Windows: all binaries were built with mingw-w64 GCC 7.4, running in a
  CentOS 6 Docker container
- x64 macOS: most binaries were built with GCC 7.4, running in a separate
  folder on macOS 10.10.5; GDB cannot be compiled with GCC, so Apple
  clang was used.

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

```txt
b852c2f8aa48a0d5ea6d7c5afea8ee825c1df7f7cf7492825519223b0bb7a9f2
xpack-arm-none-eabi-gcc-7.3.1-1.2-darwin-x64.tgz

eda39f5866598881a63e07eff622c3b442f3cc4b166f8ebda29ffb30a08280c9
xpack-arm-none-eabi-gcc-7.3.1-1.2-linux-x32.tgz

c5c76a218f9b847c51d354c0f994de0cac5e7568a3b58e0ca04ce3d36f4eab0e
xpack-arm-none-eabi-gcc-7.3.1-1.2-linux-x64.tgz

d6d5613f032060ccfaa43757a1f56a01308c5b879630b9d21742adbd8ae40d57
xpack-arm-none-eabi-gcc-7.3.1-1.2-win32-x32.zip

b5501d197ba19724783e42a454c260f9a73ab9a759279aea72bf353dd5301afc
xpack-arm-none-eabi-gcc-7.3.1-1.2-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/arm-none-eabi-gcc-xpack](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/arm-none-eabi-gcc-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/arm-none-eabi-gcc-xpack/total.svg)](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/)
  - all GNU MCU Eclipse releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/arm-none-eabi-gcc/total.svg)](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=arm-none-eabi-gcc-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/arm-none-eabi-gcc](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/arm-none-eabi-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/arm-none-eabi-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc/)
  - all @gnu-mcu-eclipse releases [![npm](https://img.shields.io/npm/dt/@gnu-mcu-eclipse/arm-none-eabi-gcc.svg)](https://www.npmjs.com/package/@gnu-mcu-eclipse/arm-none-eabi-gcc/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
