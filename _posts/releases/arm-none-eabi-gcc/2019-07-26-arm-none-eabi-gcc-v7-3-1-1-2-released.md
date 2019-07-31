---
title:  xPack GNU ARM Embedded GCC v7.3.1-1.2 released

summary: "Version 7.3.1-1.2 is a repack of the GNU MCU Eclipse ARM Embedded GCC
v7.3.1-1.1 using the new build scripts."

version: 7.3.1-1.2
npm_subversion: 2
download_url: https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v7.3.1-1.2/

date:   2019-07-26 12:09:00 +0300
last_updated: 2019-07-31 03:32:50 +0300

categories:
  - releases
  - arm
  - arm-none-eabi-gcc

tags:
  - releases
  - arm-none-eabi-gcc

---

[Binary files »]({{ page.download_url }})

## Install

The full details of installing the **xPack GNU ARM Embedded GCC** on various platforms
are presented in the separate 
[Install]({{ site.baseurl }}/arm-none-eabi-gcc/install/) page.

### Easy install 

The easiest way to install GNU ARM Embedded GCC is with 
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
**7-2018-q2-update** release from June 27, 2018 and it is based on the 
`gcc-arm-none-eabi-7-2018-q2-update-src.tar.bz2` source invariant.

## Changes

There should be no functional changes.

### `lib/bdf-plugins`

To improve LTO support, the `lib/bdf-plugins` folder was added, with
a link to the `liblto_plugin.so` library (a file copy on Windows).

This allows the use of traditional program names, like `arm-none-eabi-ar` 
instead of the new `arm-none-eabi-gcc-ar`, without getting errors like:

```
arm-none-eabi-ar -r  "libarm-static-lib.a"  ./lib.o   
arm-none-eabi-ar: creating libarm-static-lib.a
arm-none-eabi-ar: ./lib.o: plugin needed to handle lto object <---
```

The issue was reported to ARM as bug [1838049](https://bugs.launchpad.net/gcc-arm-embedded/+bug/1838049).

## Known problems

- due to some changes in newlib 2.9.1, the definition of the `_EXFUN` macro 
  changed and the semihosting projects created with old GNU MCU Eclipse 
  fail to build with a compile error in 
  `system/src/newlib/_syscalls.c`. The problem was in the project template
  [#317](https://github.com/gnu-mcu-eclipse/eclipse-plugins/issues/317), and
  was fixed in GNU MCU Eclipse plug-ins v4.4.2 (2018-08-27).

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit, Ubuntu 18 LTS 64-bit,
Xubuntu 18 LTS 32-bit and macOS 10.13.

The tests consist in building and debugging some 
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the project.

Since the source code used for GCC is identical to the one used by ARM, the
long and complex tests performed by ARM to validate their release were not
executed again.

## Binaries

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

The binaries were built using 
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set 
of build environments based on slightly older distributions, that should be 
compatible with most recent systems.

- GNU/Linux: all binaries were built with GCC 7.4, running in a CentOS 6 
  Docker container
- Windows: all binaries were built with mingw-w64 GCC 7.4, running in a 
  CentOS 6 Docker container 
- macOS: most binaries were built with GCC 7.4, running in a separate  
  folder on macOS 10.10.5; GDB cannot be compiled with GCC, so Apple 
  clang was used.

## Checksums

The SHA-256 hashes for the files are:

```console
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
  * this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/arm-none-eabi-gcc-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v{{ page.version }}/)
  - all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/arm-none-eabi-gcc-xpack/total.svg)](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/)
  - GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/arm-none-eabi-gcc/total.svg)](https://github.com/gnu-mcu-eclipse/arm-none-eabi-gcc/releases/)
  - [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=arm-none-eabi-gcc-xpack) (grouped per release)
- xnpmjs.com [@xpack-dev-tools/arm-none-eabi-gcc](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/arm-none-eabi-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc/)

Credit to [Shields IO](https://shields.io) for the badges and to 
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats) 
for the individual file counters.
