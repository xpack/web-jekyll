---
title:  xPack GNU RISC-V Embedded GCC v12.1.0-2 released
sidebar: riscv-none-elf-gcc

summary: "Version **12.1.0-2** is a new release; it adds support for size optimised C++ system libraries in the nano variant of newlib."

version: 12.1.0-2
npm_subversion: 1

download_url: https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/tag/v12.1.0-2/

date: 2022-05-18 10:14:19 +0300

comments: true

categories:
  - releases
  - riscv-none-elf-gcc

tags:
  - releases
  - riscv
  - riscv-none-elf-gcc
  - gcc
  - binaries
  - c++

redirect_to: https://xpack-dev-tools.github.io/riscv-none-elf-gcc-xpack/blog/2022/05/18/riscv-none-elf-gcc-v12-1-0-2-released

---

The [xPack GNU RISC-V Embedded GCC](https://xpack.github.io/dev-tools/riscv-none-elf-gcc/)
is a standalone cross-platform binary distribution of the
[GNU GCC](https://gcc.gnu.org/releases.html).

There are separate binaries for **Windows** (Intel 64-bit),
**macOS** (Intel 64-bit)
and **GNU/Linux** (Intel 64-bit, Arm 32/64-bit).

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

## Install

The full details of installing the **xPack GNU RISC-V Embedded GCC**
on various platforms are presented in the separate [Install]({{ site.baseurl }}/dev-tools/riscv-none-elf-gcc/install/) page.

### Easy install

The easiest way to install GNU RISC-V Embedded GCC is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/riscv-none-elf-gcc`](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-elf-gcc)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/riscv-none-elf-gcc@latest

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/riscv-none-elf-gcc@{{ page.version }}.{{ page.npm_subversion }}
```

For xPacks aware tools, like the **Eclipse Embedded C/C++ plug-ins**,
it is also possible to install GNU RISC-V Embedded GCC globally, in the user home folder.

```sh
xpm install --global @xpack-dev-tools/riscv-none-elf-gcc@latest --verbose
```

Eclipse will automatically
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/riscv-none-elf-gcc
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/riscv-none-elf-gcc
```

## Compliance

The xPack GNU RISC-V Embedded GCC uses the official sources,
with no functional changes:

- GCC 12.1.0
- binutils 2.38
- gdb 12.1
- newlib 4.2.0.20211231
- python 3.10.4

## Supported libraries

The default architecture/ABI pair is `rv32imac/ilp32`.

The other supported libraries are:

```console
$ riscv-none-elf-gcc -print-multi-lib
.;
rv32e/ilp32e;@march=rv32e@mabi=ilp32e
rv32ea/ilp32e;@march=rv32ea@mabi=ilp32e
rv32eac/ilp32e;@march=rv32eac@mabi=ilp32e
rv32ec/ilp32e;@march=rv32ec@mabi=ilp32e
rv32em/ilp32e;@march=rv32em@mabi=ilp32e
rv32ema/ilp32e;@march=rv32ema@mabi=ilp32e
rv32emac/ilp32e;@march=rv32emac@mabi=ilp32e
rv32emc/ilp32e;@march=rv32emc@mabi=ilp32e
rv32i/ilp32;@march=rv32i@mabi=ilp32
rv32ia/ilp32;@march=rv32ia@mabi=ilp32
rv32iac/ilp32;@march=rv32iac@mabi=ilp32
rv32iaf_zicsr/ilp32f;@march=rv32iaf_zicsr@mabi=ilp32f
rv32iafc_zicsr/ilp32f;@march=rv32iafc_zicsr@mabi=ilp32f
rv32iafd_zicsr/ilp32d;@march=rv32iafd_zicsr@mabi=ilp32d
rv32iafdc_zicsr/ilp32d;@march=rv32iafdc_zicsr@mabi=ilp32d
rv32ic/ilp32;@march=rv32ic@mabi=ilp32
rv32if_zicsr/ilp32f;@march=rv32if_zicsr@mabi=ilp32f
rv32ifc_zicsr/ilp32f;@march=rv32ifc_zicsr@mabi=ilp32f
rv32ifd_zicsr/ilp32d;@march=rv32ifd_zicsr@mabi=ilp32d
rv32ifdc_zicsr/ilp32d;@march=rv32ifdc_zicsr@mabi=ilp32d
rv32im/ilp32;@march=rv32im@mabi=ilp32
rv32ima/ilp32;@march=rv32ima@mabi=ilp32
rv32imaf_zicsr/ilp32f;@march=rv32imaf_zicsr@mabi=ilp32f
rv32imafc_zicsr/ilp32f;@march=rv32imafc_zicsr@mabi=ilp32f
rv32imafd_zicsr/ilp32d;@march=rv32imafd_zicsr@mabi=ilp32d
rv32imafdc_zicsr/ilp32d;@march=rv32imafdc_zicsr@mabi=ilp32d
rv32imc/ilp32;@march=rv32imc@mabi=ilp32
rv32imf_zicsr/ilp32f;@march=rv32imf_zicsr@mabi=ilp32f
rv32imfc_zicsr/ilp32f;@march=rv32imfc_zicsr@mabi=ilp32f
rv32imfd_zicsr/ilp32d;@march=rv32imfd_zicsr@mabi=ilp32d
rv32imfdc_zicsr/ilp32d;@march=rv32imfdc_zicsr@mabi=ilp32d
rv64i/lp64;@march=rv64i@mabi=lp64
rv64ia/lp64;@march=rv64ia@mabi=lp64
rv64iac/lp64;@march=rv64iac@mabi=lp64
rv64iaf_zicsr/lp64f;@march=rv64iaf_zicsr@mabi=lp64f
rv64iafc_zicsr/lp64f;@march=rv64iafc_zicsr@mabi=lp64f
rv64iafd_zicsr/lp64d;@march=rv64iafd_zicsr@mabi=lp64d
rv64iafdc_zicsr/lp64d;@march=rv64iafdc_zicsr@mabi=lp64d
rv64ic/lp64;@march=rv64ic@mabi=lp64
rv64if_zicsr/lp64f;@march=rv64if_zicsr@mabi=lp64f
rv64ifc_zicsr/lp64f;@march=rv64ifc_zicsr@mabi=lp64f
rv64ifd_zicsr/lp64d;@march=rv64ifd_zicsr@mabi=lp64d
rv64ifdc_zicsr/lp64d;@march=rv64ifdc_zicsr@mabi=lp64d
rv64im/lp64;@march=rv64im@mabi=lp64
rv64ima/lp64;@march=rv64ima@mabi=lp64
rv64imac/lp64;@march=rv64imac@mabi=lp64
rv64imaf_zicsr/lp64f;@march=rv64imaf_zicsr@mabi=lp64f
rv64imafc_zicsr/lp64f;@march=rv64imafc_zicsr@mabi=lp64f
rv64imafd_zicsr/lp64d;@march=rv64imafd_zicsr@mabi=lp64d
rv64imafdc_zicsr/lp64d;@march=rv64imafdc_zicsr@mabi=lp64d
rv64imc/lp64;@march=rv64imc@mabi=lp64
rv64imf_zicsr/lp64f;@march=rv64imf_zicsr@mabi=lp64f
rv64imfc_zicsr/lp64f;@march=rv64imfc_zicsr@mabi=lp64f
rv64imfd_zicsr/lp64d;@march=rv64imfd_zicsr@mabi=lp64d
rv64imfdc_zicsr/lp64d;@march=rv64imfdc_zicsr@mabi=lp64d
```

## Changes

Compared to the upstream GNU release, there are no functional changes.

### risc-none-elf-gcc

For compliance reasons, starting with 11.x, the name of the toolchain
was updated to `risc-none-elf-gcc`.

### RISC-V ISA updates

Compared to previous releases, starting from 12.x, the compiler
implements the new RISC-V ISA, which introduces an incompatibility issue,
and builds might throw error messages like _unrecognized opcode `csrr`_.

The reason is that csr read/write (`csrr*`/`csrw*`)
instructions and `fence.i` instruction were separated from the `I`
extension, becoming two standalone extensions: `Zicsr` and `Zifencei`.

The solution is to add `_zicsr` and/or `_zifencei` to the
`-march` option, e.g. `-march=rv32imac` becomes
`-march=rv32imac_zicsr_zifencei`.

In Eclipse, until the GUI will be updated, select the *Toolchain Default*
for _Architecture_ and
enter the new string separately as _Other target flags_.

### newlib-nano

Support for **newlib-nano** is available using the
`--specs=nano.specs` option. For better results, this option must be
added to both compile and link time.

### nosys.specs

If no syscalls are needed, `--specs=nosys.specs` can be used at link
time to provide empty implementations for the POSIX system calls.

### -mcmodel=medany

The libraries are compiled with `-O2 -mcmodel=medany`. The nano version is
compiled with `-Os -mcmodel=medany`.

{% include important.html content="It is mandatory for the applications to
be compiled with
`-mcmodel=medany`, otherwise the link might fail." %}

### Python

Support for Python scripting was added to GDB. This distribution provides
a separate binary, `riscv-none-elf-gdb-py3` with
support for **Python 3**.

The Python 3 run-time is included, so GDB does not need any version of
Python to be installed, and is insensitive to the presence of other
versions.

### Text User Interface (TUI)

Support for TUI was added to GDB. The `ncurses` library was added to
the distribution.

{% include note.html content="TUI is not available on Windows." %}

## Bug fixes

- none

## Enhancements

- none

## Known problems

- due to the large number of libraries, the archive is >500 MB.

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

The original GNU GCC documentation is available
[online](https://gcc.gnu.org/onlinedocs/).

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/riscv-none-elf-gcc-xpack/builds/)

## Tests

The binaries were tested on a variety of platforms,
but mainly to check the integrity of the
build, not the compiler functionality.

## Checksums

The SHA-256 hashes for the files are:

```txt
e3532f8cc17969da85dd615108c5b2826eecacc7f003c0ba5914c03e3160af1c
xpack-riscv-none-elf-gcc-12.1.0-2-darwin-arm64.tar.gz

39bd9eb7df484309fb1c725ae806b16589b8d90f273419b2a41e4017886b2176
xpack-riscv-none-elf-gcc-12.1.0-2-darwin-x64.tar.gz

b6145dcface0ed90954ebff1fea9596bb7a6c5ce7c13d87f0340946c0e0411f3
xpack-riscv-none-elf-gcc-12.1.0-2-linux-arm.tar.gz

66a81676aff6051d6e602f336f6c8ae9ca4dec483b45adbbf747dc022768653e
xpack-riscv-none-elf-gcc-12.1.0-2-linux-arm64.tar.gz

0df95d28487b5e55eb48c487bfc8951a23ef97080a8621dd4109586f51dc177e
xpack-riscv-none-elf-gcc-12.1.0-2-linux-x64.tar.gz

ab2a596d00a4436192b80381b4b9bc1e6962de5699b4a494c4f476216963983d
xpack-riscv-none-elf-gcc-12.1.0-2-win32-x64.zip

```

## Deprecation notices

### 32-bit support

Support for 32-bit Intel Linux and Intel Windows was
dropped in 2022. Support for 32-bit Arm Linux (armv7l) will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### Linux minimum requirements

Support for RedHat 7 was dropped in 2022 and the
minimum requirement was raised to GLIBC 2.27, available starting
with Ubuntu 18, Debian 10 and RedHat 8.

## Download analytics

- GitHub [xpack-dev-tools/riscv-none-elf-gcc-xpack](https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/riscv-none-elf-gcc-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/riscv-none-elf-gcc-xpack/total.svg)](https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/)
  - deprecated xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/riscv-none-embed-gcc-xpack/total.svg)](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/)
  - all GNU MCU Eclipse releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/riscv-none-gcc/total.svg)](https://github.com/gnu-mcu-eclipse/riscv-none-gcc/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=riscv-none-elf-gcc-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/riscv-none-elf-gcc](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-elf-gcc)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/riscv-none-elf-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-elf-gcc/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/riscv-none-elf-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-elf-gcc/)
  - all @xpack-dev-tools deprecated releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/riscv-none-embed-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-embed-gcc/)
  - all @gnu-mcu-eclipse releases [![npm](https://img.shields.io/npm/dt/@gnu-mcu-eclipse/riscv-none-gcc.svg)](https://www.npmjs.com/package/@gnu-mcu-eclipse/riscv-none-gcc/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
