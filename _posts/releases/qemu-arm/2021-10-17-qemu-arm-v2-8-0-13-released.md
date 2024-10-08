---
title:  xPack QEMU Arm v2.8.0-13 released
sidebar: qemu-arm

summary: "Version **2.8.0-13** is a maintenance release; it fixes a bug and updates to the latests build environment."

version: 2.8.0-13
npm_subversion: 1

download_url: https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/tag/v2.8.0-13/

date: 2021-10-17 18:19:18 +0300

redirect_to: https://xpack-dev-tools.github.io/qemu-arm-xpack/blog/2021/10/17/qemu-arm-v2-8-0-13-released/

comments: true

categories:
  - releases
  - qemu-arm

tags:
  - releases
  - qemu
  - emulator
  - arm
  - cortex-m

---

The [xPack QEMU Arm](https://xpack.github.io/dev-tools/qemu-arm/)
is a standalone cross-platform binary distribution of
[QEMU](https://www.qemu.org), with several extensions for Arm Cortex-M
devices.

There are separate binaries for **Windows** (x64 and x86),
**macOS** (x64) and **GNU/Linux** (x64 and x86, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Prerequisites

- x86/x64 GNU/Linux: any system with **GLIBC 2.15** or higher
  (like Ubuntu 12 or later, Debian 8 or later, RedHat/CentOS 7 later,
  Fedora 20 or later, etc)
- arm64/arm GNU/Linux: any system with **GLIBC 2.23** or higher
  (like Ubuntu 16 or later, Debian 9 or later, RedHat/CentOS 8 or later,
  Fedora 24 or later, etc)
- x86/x64 Windows: Windows 7 with the Universal C Runtime
  ([UCRT](https://support.microsoft.com/en-us/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c)),
  Windows 8, Windows 10
- x64 macOS: 10.13 or later

On GNU/Linux, QEMU requires the X11 libraries to be present. On Debian derived
distribution they are already in the system; on RedHat & Arch derived
distributions they must be installed explicitly.

## Install

The full details of installing the **xPack QEMU Arm** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/qemu-arm/install/) page.

### Easy install

The easiest way to install QEMU Arm is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/qemu-arm`](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/qemu-arm@latest

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/qemu-arm@{{ page.version }}.{{ page.npm_subversion }}
```

For xPacks aware tools, like the **Eclipse Embedded C/C++ plug-ins**,
it is also possible to install QEMU Arm globally, in the user home folder.

```sh
xpm install --global @xpack-dev-tools/qemu-arm@latest --verbose
```

Eclipse will automatically
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/qemu-arm
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/qemu-arm
```

## Compliance

The xPack QEMU Arm currently is based on the official [QEMU](https://www.qemu.org),
with major changes.

The current version is based on:

- QEMU version 2.8.0, commit [0737f32](https://github.com/xpack-dev-tools/qemu/commit/0737f32daf35f3730ed2461ddfaaf034c2ec7ff0) from Dec 20th, 2016.

## Changes

Compared to the master `qemu-system-arm`, the changes are major, all
application class Arm
devices were removed and replaced by several Cortex-M devices.

The supported boards are:

```console
xPack 64-bit QEMU v2.8.0 (qemu-system-gnuarmeclipse).

Supported boards:
  BluePill             BluePill STM32F103C8T6
  Maple                LeafLab Arduino-style STM32 microcontroller board (r5)
  NUCLEO-F072RB        ST Nucleo Development Board for STM32 F072 devices
  NUCLEO-F103RB        ST Nucleo Development Board for STM32 F1 series
  NUCLEO-F411RE        ST Nucleo Development Board for STM32 F4 series
  NetduinoGo           Netduino GoBus Development Board with STM32F4
  NetduinoPlus2        Netduino Development Board with STM32F4
  OLIMEXINO-STM32      Olimex Maple (Arduino-like) Development Board
  STM32-E407           Olimex Development Board for STM32F407ZGT6
  STM32-H103           Olimex Header Board for STM32F103RBT6
  STM32-P103           Olimex Prototype Board for STM32F103RBT6
  STM32-P107           Olimex Prototype Board for STM32F107VCT6
  STM32F0-Discovery    ST Discovery kit for STM32F051 line
  STM32F051-Discovery  ST Discovery kit for STM32F051 line
  STM32F4-Discovery    ST Discovery kit for STM32F407/417 lines
  STM32F429I-Discovery ST Discovery kit for STM32F429/439 lines
  generic              Generic Cortex-M board; use -mcu to define the device

Supported MCUs:
  STM32F051R8
  STM32F103RB
  STM32F107VC
  STM32F405RG
  STM32F407VG
  STM32F407VGTx <- new
  STM32F407ZG
  STM32F411RE
  STM32F429ZI
  STM32F429ZITx <- new>
```

Warning: support for hardware floating point on Cortex-M4 devices is not
available yet.

## Bug fixes

- [[#15](https://github.com/xpack-dev-tools/qemu/issues/15)] -
in certain conditions, with some linker script memory configurations,
the emulator failed complaining that the flash regions overlap; the
problem was fixed on in v2.11 and the two related patches were cherry
picked and adapted to this distribution.

## Enhancements

- none

## Known problems

- Ctrl-C does not interrupt the execution if the `--nographic` option is used.

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

### `@executable_path`

Similarly, on macOS, the binaries are adjusted with `otool` to use a
relative path.

## Documentation

The original documentation is available in the `share/doc` folder.

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/qemu-arm-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/qemu-arm-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/qemu-arm-xpack/builds/)

## Tests

The binaries were testes on Windows 11 Pro, Ubuntu 22
LTS (x64) and macOS 14.5.

The tests consist in running a simple blinky application
on the graphically emulated STM32F4DISCOVERY board. The binaries were
those generated by the
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the **xPack GNU Arm Embedded GCC** project. Use the
`arm-f4b-fs-debug-qemu` debug luncher available in the `arm-f4b-fs` project.

On platforms where Eclipse is not available, the binaries were
tested by manually starting the
blinky test on the emulated STM32F4DISCOVERY board.

```console
.../xpack-qemu-arm-2.8.0-13/bin/qemu-system-gnuarmeclipse --version
xPack 64-bit QEMU emulator version 2.8.0-11 (v2.8.0-12-4-gb1ab9f0b32-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

mkdir -p ~/Downloads
(cd ~/Downloads; curl -L --fail -o f407-disc-blink-tutorial.elf \
https://github.com/xpack-dev-tools/qemu-eclipse-test-projects/raw/master/f407-disc-blink-tutorial/Debug/f407-disc-blink-tutorial.elf)

.../xpack-qemu-arm-2.8.0-13/bin/qemu-system-gnuarmeclipse \
--board STM32F4-Discovery \
-d unimp,guest_errors \
--nographic \
--image ~/Downloads/f407-disc-blink-tutorial.elf \
--semihosting-config enable=on,target=native \
--semihosting-cmdline test 6

DISPLAY=:1.0 .../xpack-qemu-arm-2.8.0-13/bin/qemu-system-gnuarmeclipse \
--board STM32F4-Discovery \
-d unimp,guest_errors \
--image ~/Downloads/f407-disc-blink-tutorial.elf \
--semihosting-config enable=on,target=native \
--semihosting-cmdline test 6

```

On Raspberry Pi OS 10 (buster) 64-bit the program was able to run in non
graphic mode, but did not start in graphic mode due to a
missing driver. To be further investigated.

## Checksums

The SHA-256 hashes for the files are:

```txt
9001c6befdd791f814d9c64b903915ab10983d9c80659a6d4e811290759159b7
xpack-qemu-arm-2.8.0-13-darwin-x64.tar.gz

b1b1046365ecd0d72cbb1c7d18df1451595347f454bfc6ed9fc99d3ced133ac3
xpack-qemu-arm-2.8.0-13-linux-arm.tar.gz

386abf59c78b3b840314ddcbdad42086ef88e9d3197c44201460c0e78b094a3e
xpack-qemu-arm-2.8.0-13-linux-arm64.tar.gz

a83921f994e6062abdfef49c1fd13f3aa898e85bbaeabc18b443f1176656c285
xpack-qemu-arm-2.8.0-13-linux-ia32.tar.gz

b99b87541f13e594f09f6a8ce656d84e0c0ac9623227ee6f2ba2a46c7e67a350
xpack-qemu-arm-2.8.0-13-linux-x64.tar.gz

710f0ba1a90eb8fa60d88e1a3160b8e57bf8ccb8f8232d0a036090ea0dcea9c0
xpack-qemu-arm-2.8.0-13-win32-ia32.zip

c7c35e03a3c861b5f21d8564074cb928f1478eeb2c8a2e8ee53e7513c39e2750
xpack-qemu-arm-2.8.0-13-win32-x64.zip

```

## Deprecation notices

### 32-bit support

Support for 32-bit x86 GNU/Linux and x86 Windows will most probably
be dropped in 2022. Support for 32-bit Arm GNU/Linux will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### GNU/Linux minimum requirements

Support for RedHat 7 will most probably be dropped in 2022, and the
minimum requirement will be raised to GLIBC 2.27, available starting
with Ubuntu 18 and RedHat 8.

## Download analytics

- GitHub [xpack-dev-tools/qemu-arm-xpack](https://github.com/xpack-dev-tools/qemu-arm-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/qemu-arm-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/qemu-arm-xpack/total.svg)](https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/)
  - all GNU MCU Eclipse releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/qemu/total.svg)](https://github.com/gnu-mcu-eclipse/qemu/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=qemu-arm-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/qemu-arm](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/qemu-arm.svg)](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/qemu-arm.svg)](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm/)
  - all @gnu-mcu-eclipse releases [![npm](https://img.shields.io/npm/dt/@gnu-mcu-eclipse/qemu.svg)](https://www.npmjs.com/package/@gnu-mcu-eclipse/qemu/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
