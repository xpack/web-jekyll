---
title:  xPack GNU ARM Embedded GCC v8.3.1-1.1 released

summary: "Version 8.3.1-1.1 is a new release of **xPack GNU ARM Embedded GCC**, 
following ARM release from July 10, 2019 (version **8-2019-q3-update**)."

version: 8.3.1-1.1
npm_subversion: 1
download_url: https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/v8.3.1-1.1/

date:   2019-07-29 19:51:00 +0300
last_updated: 2019-07-29 20:50:52 +0300

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

The full details of installing the **xPack GNU ARM Embedded GCC** on 
various platforms are presented in the separate 
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
**8-2019-q3-update** release from July 10, 2019 and it is based on the 
`gcc-arm-none-eabi-8-2019-q3-update-src.tar.bz2` source invariant.

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

### Python 3

Partial support for Python 3 was added to GDB for GNU/Linux and macOS; 
not yet available on Windows ([24469](https://sourceware.org/bugzilla/show_bug.cgi?id=24469)).

## Known problems

- none

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
61cdc9d05d6a666b2df45ad2dcd5aa5d7eccf1ffb865420c35704a1917812eb2 
xpack-arm-none-eabi-gcc-8.3.1-1.1-darwin-x64.tgz

266f5ebde79ce4d5a91232af22707dad076fdcf35031042b498fae1ae09989d7 
xpack-arm-none-eabi-gcc-8.3.1-1.1-linux-x32.tgz

2e49bdb076ed96cdde2b8320d9496875eccd7eb83d2af0dc378e02dd17aedec4 
xpack-arm-none-eabi-gcc-8.3.1-1.1-linux-x64.tgz

3854e4683d3977f27573610cf6badd0f0433ddc37ed0d922757cf1ff708be405 
xpack-arm-none-eabi-gcc-8.3.1-1.1-win32-x32.zip

39e1e553edcae83856882b8587a7f8b6d5c9f8fc11f10247b0e2af3321481fdb 
xpack-arm-none-eabi-gcc-8.3.1-1.1-win32-x64.zip
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
