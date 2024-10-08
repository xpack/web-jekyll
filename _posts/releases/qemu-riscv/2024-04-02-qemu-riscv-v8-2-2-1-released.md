---
title:  xPack QEMU RISC-V v8.2.2-1 released

summary: "Version **8.2.2-1** is a new release; it follows the upstream QEMU release."

qemu_version: "8.2.2"
qemu_short_commit: "11aa0b1f"
qemu_long_commit: "11aa0b1ff115b86160c4d37e7c37e6a6b13b77ea"
qemu_date: "4 Mar 2024"

version: "8.2.2-1"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/qemu-riscv-xpack/releases/tag/v8.2.2-1/

comments: true

date: 2024-04-02 12:44:52 +0300

redirect_to: https://xpack-dev-tools.github.io/qemu-riscv-xpack/blog/2024/04/02/qemu-riscv-v8-2-2-1-released/

# For Jekyll releases selection.
categories:
  - releases
  - qemu-riscv

# For navigation; use scripts/createtag.sh in Jekyll.
tags:
  - releases
  - qemu
  - emulator
  - risc-v

---

The [xPack QEMU RISC-V](https://xpack.github.io/qemu-riscv/)
is a standalone cross-platform binary distribution of
[QEMU](https://www.qemu.org).

There are separate binaries for **Windows** (x64),
**macOS** (x64, arm64)
and **GNU/Linux** (x64, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Prerequisites

- x64 GNU/Linux: any system with **GLIBC 2.27** or higher
  (like Ubuntu 18 or later, Debian 10 or later, RedHat 8 or later,
  Fedora 29 or later, etc)
- arm64/arm GNU/Linux: any system with **GLIBC 2.27** or higher
  (like Raspberry Pi OS, Ubuntu 18 or later, Debian 10 or later, RedHat 8 or later,
  Fedora 29 or later, etc)
- x64 Windows: Windows 7 with the Universal C Runtime
  ([UCRT](https://support.microsoft.com/en-us/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c)),
  Windows 8, Windows 10
- x64 macOS: 10.13 or later
- arm64 macOS: 11.6 or later

On GNU/Linux, QEMU requires the X11 libraries to be present. On Debian derived
distribution they are already in the system; on RedHat & Arch derived
distributions they must be installed explicitly.

## Install

The full details of installing the **xPack QEMU RISC-V** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/qemu-riscv/install/) page.

### Easy install

The easiest way to install QEMU RISC-V is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/qemu-riscv`](https://www.npmjs.com/package/@xpack-dev-tools/qemu-riscv)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/qemu-riscv@latest --verbose

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/qemu-riscv@{{ page.version }}.{{ page.npm_subversion }} --verbose
```

For xPacks aware tools, like the **Eclipse Embedded C/C++ plug-ins**,
it is also possible to install QEMU RISC-V globally, in the user home folder.

```sh
xpm install --global @xpack-dev-tools/qemu-riscv@latest --verbose
```

Eclipse will automatically
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/qemu-riscv
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/qemu-riscv
```

## Compliance

The xPack QEMU RISC-V currently is based on the official [QEMU](https://www.qemu.org),
with no major changes.

The current version is based on:

- QEMU version {{ page.qemu_version }},
  commit [{{ page.qemu_short_commit }}](https://github.com/xpack-dev-tools/qemu/commit/{{ page.qemu_long_commit }})
  from {{ page.qemu_date }}.

## Changes

Compared to the master `qemu-system-riscv*`, there are no major changes.

The supported boards and CPUs are:

```console
$ .../xpack-qemu-riscv-8.2.2-1/bin/qemu-system-riscv32 -machine help
Supported machines are:
none                 empty machine
opentitan            RISC-V Board compatible with OpenTitan
sifive_e             RISC-V Board compatible with SiFive E SDK
sifive_u             RISC-V Board compatible with SiFive U SDK
spike                RISC-V Spike board (default)
virt                 RISC-V VirtIO board
$ .../xpack-qemu-riscv-8.2.2-1/bin/qemu-system-riscv32 -cpu help
any
lowrisc-ibex
max
rv32
sifive-e31
sifive-e34
sifive-u34

$ .../xpack-qemu-riscv-8.2.2-1/bin/qemu-system-riscv64 -machine help
Supported machines are:
microchip-icicle-kit Microchip PolarFire SoC Icicle Kit
none                 empty machine
shakti_c             RISC-V Board compatible with Shakti SDK
sifive_e             RISC-V Board compatible with SiFive E SDK
sifive_u             RISC-V Board compatible with SiFive U SDK
spike                RISC-V Spike board (default)
virt                 RISC-V VirtIO board
$ .../xpack-qemu-riscv-7.0.0-1/bin/qemu-system-riscv64 -cpu help
any
max
rv64
shakti-c
sifive-e51
sifive-u54
thead-c906
veyron-v1
x-rv128
```

## Bug fixes

- none

## Enhancements

- none

## Known problems

- in order to build on macOS 10.13, the x64 macOS version has
  some functionality related to bridged virtual interfaces disabled.

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

### `@rpath` and `@loader_path`

Similarly, on macOS, the binaries are adjusted with `install_name_tool` to use a
relative path.

## Documentation

The original documentation is available on-line:

- <https://www.qemu.org/docs/master/>

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/qemu-riscv-xpack/blob/xpack/README-BUILD.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/qemu-riscv-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/qemu-riscv-xpack/builds/)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:

```txt
bdd409d7200e1ea7852efc0ac03ac2a38892857714d9ffc8f47fc86bcc3a8730
xpack-qemu-riscv-8.2.2-1-darwin-arm64.tar.gz

d80c9abae88bcc52280b91e2d3921fa22aa6267614b6e627736ed4e02c3a91d1
xpack-qemu-riscv-8.2.2-1-darwin-x64.tar.gz

d73bf3a4904e10b485d46adcd50c877cce13f9ac8d097b67e5643108d751172e
xpack-qemu-riscv-8.2.2-1-linux-arm.tar.gz

765ac55d58adfb31e7a88baadc9a9cf46eb30e8030d437bdc076747d63f0474c
xpack-qemu-riscv-8.2.2-1-linux-arm64.tar.gz

d5b8f77cb3ad23b29421f7fdc5456866b1a10817efacb262bbda038ca1c5a5a5
xpack-qemu-riscv-8.2.2-1-linux-x64.tar.gz

c0d1febb95bb01e093dfd5d701eea825bdadc9009b5780eb5581186bd75c1f96
xpack-qemu-riscv-8.2.2-1-win32-x64.zip

```

## Deprecation notices

### GNU/Linux minimum requirements

The minimum requirement is **GLIBC 2.27**, available starting
with Ubuntu 18, Debian 10 and RedHat 8.
Support for RedHat 7 was dropped in 2022.

### 32-bit support

Support for 32-bit x86 GNU/Linux and x86 Windows was
dropped in 2022.

### Pre-deprecation notice for 32-bit Arm GNU/Linux

Due to the large user base of 32-bit Raspberry Pi systems,
Support for 32-bit Arm GNU/Linux (armv7l) will be preserved
for a little while, but expect it to be dropped by 2025,
so it is recommended to consider an upgrade to a RPi 4 or 5 with
at least 4 GB (preferably 8 GB) of RAM.

## Pre-deprecation notice for Ubuntu 18.04

Ubuntu 18.04 LTS _Bionic Beaver_ reached the end of the standard five-year
maintenance window for Long-Term Support (LTS) release on 31 May 2023.

As a courtesy, the xPack GNU/Linux releases will continue to be based on
Ubuntu 18.04 for another year.

From 2025 onwards, the GNU/Linux binaries will be built on **Debian 10**,
(**GLIBC 2.28**), and are also expected to run on RedHat 8.

Users are urged to update their build and test infrastructure to
ensure a smooth transition to the next xPack releases.

## Download analytics

- GitHub [xpack-dev-tools/qemu-riscv-xpack](https://github.com/xpack-dev-tools/qemu-riscv-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/qemu-riscv-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/qemu-riscv-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/qemu-riscv-xpack/total.svg)](https://github.com/xpack-dev-tools/qemu-riscv-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=qemu-riscv-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/qemu-riscv](https://www.npmjs.com/package/@xpack-dev-tools/qemu-riscv)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/qemu-riscv.svg)](https://www.npmjs.com/package/@xpack-dev-tools/qemu-riscv/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/qemu-riscv.svg)](https://www.npmjs.com/package/@xpack-dev-tools/qemu-riscv/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
