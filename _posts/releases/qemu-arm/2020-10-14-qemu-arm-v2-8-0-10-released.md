---
title:  xPack QEMU Arm v2.8.0-10 released
sidebar: qemu-arm

summary: "Version **2.8.0-10** is a maintenance release; it fixes one bug and updates to the new, more robust, build scripts."

version: 2.8.0-10
npm_subversion: 1

download_url: https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/tag/v2.8.0-10/

date: 2020-10-14 21:47:00 +0300

redirect_to: https://xpack-dev-tools.github.io/qemu-arm-xpack/blog/2020/10/14/qemu-arm-v2-8-0-10-released/

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
is the **xPack** distribution of the
[QEMU](https://www.qemu.org), with several extensions for Arm Cortex-M
devices.

There are separate binaries for **Windows** (x64 and x86),
**macOS** (x64) and **GNU/Linux** (x64 and x86, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Install

The full details of installing the **xPack QEMU Arm** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/qemu-arm/install/) page.

### Easy install

The easiest way to install QEMU Arm is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/qemu-arm`](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```sh
xpm install --global @xpack-dev-tools/qemu-arm@latest --verbose
```

To install this specific version, use:

```sh
xpm install --global @xpack-dev-tools/qemu-arm@{{ page.version }}.{{ page.npm_subversion }}
```

## Compliance

xPack QEMU Arm currently is based on the official [QEMU](https://www.qemu.org),
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
  Maple                LeafLab Arduino-style STM32 microcontroller board (r5)
  NUCLEO-F103RB        ST Nucleo Development Board for STM32 F1 series
  NUCLEO-F411RE        ST Nucleo Development Board for STM32 F4 series
  NetduinoGo           Netduino GoBus Development Board with STM32F4
  NetduinoPlus2        Netduino Development Board with STM32F4
  OLIMEXINO-STM32      Olimex Maple (Arduino-like) Development Board
  STM32-E407           Olimex Development Board for STM32F407ZGT6
  STM32-H103           Olimex Header Board for STM32F103RBT6
  STM32-P103           Olimex Prototype Board for STM32F103RBT6
  STM32-P107           Olimex Prototype Board for STM32F107VCT6
  STM32F0-Discovery    ST Discovery kit for STM32F051 lines
  STM32F4-Discovery    ST Discovery kit for STM32F407/417 lines
  STM32F429I-Discovery ST Discovery kit for STM32F429/439 lines
  generic              Generic Cortex-M board; use -mcu to define the device

Supported MCUs:
  STM32F051R8
  STM32F103RB
  STM32F107VC
  STM32F405RG
  STM32F407VG
  STM32F407ZG
  STM32F411RE
  STM32F429ZI
```

Warning: support for hardware floating point on Cortex-M4 devices is not
available yet.

## Bug fixes

- [[#5](https://github.com/xpack-dev-tools/qemu/pull/5)] - the ETM and ITM
fields get mixed up when parsing the SVD; fixed.

## Enhancements

- none

## Known problems

- Ctrl-C does not interrupt the execution if the `--nographic` option is used.

## Shared libraries

On all platforms the packages are standalone, and expect only the standard
runtime (including X11) to be present on the host.

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

Similarly, on macOS, the binaries are adjusted with `otool` to use a
relative path.

## Documentation

The original documentation is available in the `share/doc` folder.

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
[README-MAINTAINER](https://github.com/xpack-dev-tools/qemu-arm-xpack/blob/xpack/README-MAINTAINER.md) page.

## Travis tests

The first set of tests were performed on Travis, by running
a simple script to check if the binaries start on a wide range of
platforms and distributions:

- [test xPack QEMU Arm on stable platforms](https://travis-ci.org/github/xpack-dev-tools/qemu-arm-xpack/builds/735831941)
- [test xPack QEMU Arm on latest platforms](https://travis-ci.org/github/xpack-dev-tools/qemu-arm-xpack/builds/703897230)

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit, Ubuntu 18 LTS 64-bit,
Xubuntu 18 LTS 32-bit and macOS 10.14.

The tests consist in running a simple blinky application
on the graphically emulated STM32F4DISCOVERY board. The binaries were
those generated by the
[simple Eclipse projects](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/tree/xpack/tests/eclipse)
available in the **xPack GNU Arm Embedded GCC** project. Use the
`arm-f4b-fs-debug-qemu` debug luncher available in the `arm-f4b-fs` project.

On Arm platforms, where Eclipse is not yet available, the binaries were
tested on Raspberry Pi OS 10 (buster) 32-bit by manually starting the
blinky test on the emulated STM32F4DISCOVERY board.

```console
~/opt/xPacks/@xpack-dev-tools/qemu-arm/2.8.0-10.1/.content/bin/qemu-system-gnuarmeclipse --version

mkdir -p ~/Downloads
(cd ~/Downloads; curl -L --fail -o f407-disc-blink-tutorial.elf \
https://github.com/xpack-dev-tools/qemu-eclipse-test-projects/raw/master/f407-disc-blink-tutorial/Debug/f407-disc-blink-tutorial.elf)

~/opt/xPacks/@xpack-dev-tools/qemu-arm/2.8.0-10.1/.content/bin/qemu-system-gnuarmeclipse \
--board STM32F4-Discovery \
-d unimp,guest_errors \
--nographic \
--image ~/Downloads/f407-disc-blink-tutorial.elf \
--semihosting-config enable=on,target=native \
--semihosting-cmdline test 6

DISPLAY=:1.0 ~/opt/xPacks/@xpack-dev-tools/qemu-arm/2.8.0-10.1/.content/bin/qemu-system-gnuarmeclipse \
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
159752281b4352e2cc0b4ec329162bdcec9af003f7db4e9a3f7e37e8a0d0faf3
xpack-qemu-arm-2.8.0-10-darwin-x64.tar.gz

63a83d93c96e224aa1df5ea8aec774e1b5932aa1167f6d2ec62dec7e3f0cd9ce
xpack-qemu-arm-2.8.0-10-linux-arm64.tar.gz

218f796c1ab8f246502faacf4759a830ca36fd918b45169612b587442aeabd33
xpack-qemu-arm-2.8.0-10-linux-arm.tar.gz

340099ec4076a55ff04964d2443f10af27a4cba98c8ad196c794e52d5072549e
xpack-qemu-arm-2.8.0-10-linux-x32.tar.gz

5d7d47519c1fbc35ded60ac98ac2c32519df09c8158c425d7da589e621863fcc
xpack-qemu-arm-2.8.0-10-linux-x64.tar.gz

1515fb8f8207e4e05943b6a7671ccd148bc123611d3efe4123347cd01775a9d7
xpack-qemu-arm-2.8.0-10-win32-x32.zip

02d1fc9287ba9d64d595b0ef6ded36858302c14ca80e80cc85386cf807b40f04
xpack-qemu-arm-2.8.0-10-win32-x64.zip
```

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
