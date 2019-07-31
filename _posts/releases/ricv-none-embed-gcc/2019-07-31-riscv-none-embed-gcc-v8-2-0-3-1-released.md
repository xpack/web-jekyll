---
layout: post
title:  xPack GNU RISC-V Embedded GCC v8.2.0-3.1 released

summary: "Version 8.2.0-3.1 is a new release of **xPack GNU RISC-V 
Embedded GCC**, following SiFive release from May 2019."

version: 8.2.0-3.1
npm_subversion: 1
download_url: https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/tag/v8.2.0-3.1/

date:   2019-07-31 03:19:00 +0300
last_updated: 2019-07-31 10:18:03 +0300

categories:
  - releases
  - riscv
  - riscv-none-embed-gcc

tags:
  - releases
  - riscv-none-embed-gcc

---

## Download

The binary files are available from the [GitHub Release]({{ page.download_url }}).

## Install

The full details of installing the **xPack GNU ARM Embedded GCC** on 
various platforms are presented in the separate 
[Install]({{ site.baseurl }}/riscv-none-embed-gcc/install/) page.

### Easy install 

The easiest way to install GNU ARM Embedded GCC is with 
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as 
[`@xpack-dev-tools/riscv-none-embed-gcc`](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-embed-gcc)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```console
$ xpm install --global @xpack-dev-tools/riscv-none-embed-gcc@latest
```

To install this specific version, use:

```console
$ xpm install --global @xpack-dev-tools/riscv-none-embed-gcc@{{ page.version }}.{{ page.npm_subversion }}
```

## Compliance

Starting with v8.2.0-2, this distribution closely follows the official 
[SiFive](https://www.sifive.com) 
[Freedom Tools](https://github.com/sifive/freedom-tools) distribution.

This release is similar to the SiFive 2019-05 release, including support for 
SiFive specific CLIC interrupts and a larger multilib set.

```console
$ riscv-none-embed-gcc -print-multi-lib
.;
rv32e/ilp32e;@march=rv32e@mabi=ilp32e
rv32em/ilp32e;@march=rv32em@mabi=ilp32e
rv32eac/ilp32e;@march=rv32eac@mabi=ilp32e
rv32emac/ilp32e;@march=rv32emac@mabi=ilp32e
rv32i/ilp32;@march=rv32i@mabi=ilp32
rv32im/ilp32;@march=rv32im@mabi=ilp32
rv32imf/ilp32f;@march=rv32imf@mabi=ilp32f
rv32imaf/ilp32f;@march=rv32imaf@mabi=ilp32f
rv32iac/ilp32;@march=rv32iac@mabi=ilp32
rv32imac/ilp32;@march=rv32imac@mabi=ilp32
rv32imafc/ilp32f;@march=rv32imafc@mabi=ilp32f
rv32imafdc/ilp32d;@march=rv32imafdc@mabi=ilp32d
rv64i/lp64;@march=rv64i@mabi=lp64
rv64im/lp64;@march=rv64im@mabi=lp64
rv64imf/lp64f;@march=rv64imf@mabi=lp64f
rv64iac/lp64;@march=rv64iac@mabi=lp64
rv64imac/lp64;@march=rv64imac@mabi=lp64
rv64imafc/lp64f;@march=rv64imafc@mabi=lp64f
rv64imafdc/lp64d;@march=rv64imafdc@mabi=lp64d
```

## Improvements

All architectures, ABIs and libraries supported by the `riscv64-unknown-elf` 
toolchain are also supported, with the following improvements:

* the mandatory reference to `libgloss` in the linker configuration was removed
* the `march=rv32imaf/mabi=ilp32f` library was added to the list of multilibs
* the standard documentation, in PDF and HTML, is included 

## Known problems

- none

## Supported platforms

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

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit, Ubuntu 18 LTS 64-bit,
Xubuntu 18 LTS 32-bit and macOS 10.13.

The tests consist in building and debugging some 
[simple Eclipse projects](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/tree/xpack/tests/eclipse)
available in the build project.

Since the source code used for GCC is identical to the one used by SiFive, the
long and complex tests performed by SiFive to validate their release were not
executed again.

## Checksums

The SHA-256 hashes for the files are:

```
48ece50b7272a8e49e56e37f54f9962f93dce4ca44f1bb4c8113fab0230fbdf1 
xpack-riscv-none-embed-gcc-8.2.0-3.1-darwin-x64.tgz

2e856ee33ef544a2405183366cdf299da2cca697e8cc57627dfaad8ab4460a99 
xpack-riscv-none-embed-gcc-8.2.0-3.1-linux-x32.tgz

3d40fab50ebad8424ff85748f25d2eaee50f86a5d5222abd7a45a2e490f1e4f5 
xpack-riscv-none-embed-gcc-8.2.0-3.1-linux-x64.tgz

78bcd52f7b404133de3b2f9568e7101c1de747f98db3a7b0d6251b75a1754867 
xpack-riscv-none-embed-gcc-8.2.0-3.1-win32-x32.zip

98b60720607f1400081806d60d70796b30399f8b426e2c790a4abb0bffb9e5ec 
xpack-riscv-none-embed-gcc-8.2.0-3.1-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/riscv-none-embed-gcc-xpack](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/)
  * this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/riscv-none-embed-gcc-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/v{{ page.version }}/)
  - all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/riscv-none-embed-gcc-xpack/total.svg)](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/)
  - GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/riscv-none-gcc/total.svg)](https://github.com/gnu-mcu-eclipse/riscv-none-gcc/releases/)
  - [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=riscv-none-embed-gcc-xpack) (grouped per release)
- xnpmjs.com [@xpack-dev-tools/riscv-none-embed-gcc](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-embed-gcc)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/riscv-none-embed-gcc.svg)](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-embed-gcc/)

Credit to [Shields IO](https://shields.io) for the badges and to 
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats) 
for the individual file counters.
