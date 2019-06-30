---
title: "The xPack Project"
permalink: /

keywords: packages, code sharing, reusing, libraries, applications, c/c++, embedded
toc: false
summary: Tools to manage, configure and build complex, package based, multi-target projects.

date: 2019-06-20 23:11:00 +0300
last_updated: 2019-06-30 10:30:21 +0300

---

## Mission statement

Provide a set of cross-platform tools to manage, configure and build complex, 
modular, multi-target (multi-architecture, multi-board, multi-toolchain)
projects, intended to **enhance code sharing** and **reusing** during the 
life cycle of libraries and applications, with an emphasis on C/C++ and 
bare-metal embedded.

## xPacks overview

**xPacks** are general purpose multi-version software packages, 
much the same as the highly successful 
[npm modules](https://docs.npmjs.com/getting-started/what-is-npm) 
in the [Node.js](https://nodejs.org/en/) JavaScript ecosystem.

By **multi-version** it is understood not only that packages can have 
multiple versions, but they **can be installed in parallel**, each
project having its own set of dependencies.

Except the package manager, most of the tools are generic and do not 
mandate the use of xPack packages, and can be used in traditional 
environments (although some of them may benefit when used in an xPack
environment).

Although the focus is on **C/C++**, most of the tools are language agnostic 
and can be used with other programming languages as well.

Based on the installed content, there are currently two 
types of xPacks: **source** and **binary**:

- **source xPacks** are packages that install source files, 
generally libraries used by the project.
- **binary xPacks** are packages that install binary files, 
generally tools used during the build process, like toolchains,
builders, etc.

For more details, read the [xPack 101]({{ site.baseurl }}/intro/) page.

The entire xPack project is split amongst several groups,
published as separated GitHub _organisations_.

## xPack Core Tools

The core xPack tools are:

- [`xpm`]({{ site.baseurl }}/xpm/) - the **xPack Package Manager**
- `@xpack/xpbuild` - the **xPack Basic Project Builder**
- `@xpack/xpmake` - the **xPack Build Generator** (in design phase)
- `@xpack/xpninja` - the **xPack Build Runner** (in design phase)
- `@xpack/xpcdl` - the **xPack Build Configurator** (in design phase)
- `@xpack/xpliquid` - the **xPack Liquid Template Engine** (in design phase)
- `@xpack/xpjson` - the **xPack JSON Manager** (in design phase)

These projects are hosted in the GitHub 
[`xpack`](https://github.com/xpack) organisation.

## xPack based Development Tools

The main binary tools packed as xPacks are:

- `@xpack-dev-tools/arm-none-eabi-gcc` - the **xPack ARM Embedded GCC** toolchain
- [`@xpack-dev-tools/openocd`]({{ site.baseurl }}/openocd/) - the **xPack OpenOCD**
- [`@xpack-dev-tools/qemu`]({{ site.baseurl }}/qemu/) - the **xPack GNU ARM Eclipse QEMU**
- `@xpack-dev-tools/riscv-none-embed-gcc` - the **xPack RISC-V Embedded GCC** toolchain

Planned:

- `@xpack-dev-tools/gdb` - the **xPack GNU GDB**
- `@xpack-dev-tools/binutils` - the **xPack GNU binutils**
- `@xpack-dev-tools/gcc` - the **xPack GNU GCC**
- `@xpack-dev-tools/coreutils` - the **xPack GNU coreutils**
- `@xpack-dev-tools/make` - the **xPack make**
- `@xpack-dev-tools/cmake` - the **xPack CMake**
- `@xpack-dev-tools/ninja` - the **xPack Ninja Build**

These projects are hosted in the GitHub 
[`xpack-dev-tools`](https://github.com/xpack-dev-tools) organisation.

## Source xPacks

### µOS++

Packages part of the µOS++ framework:

- `@micro-os-plus/startup` - µOS++ Startup
- `@micro-os-plus/semihosting` - µOS++ Semihosting
- `@micro-os-plus/diag-trace` - µOS++ Tracing
- `@micro-os-plus/c-libs` - µOS++ C library
- `@micro-os-plus/cpp-libs` - µOS++ C++ library

### 3rd Party

Packages with 3rd party content (mind the **plural** in the scope name):

- `@xpacks/freertos` - FreeRTOS
- `@xpacks/chan-fatfs` - Chan-FatFS

## xPack Build Box (XBB)

Scripts to create the development environments used to build the
archives used by the binary xPacks.

The development environments are based on:

- **CentOS 6** Docker images, used to build the GNU/Linux and Windows 
  distributions
- **macOS 10.10** tools, used to build the macOS Intel distributions

These scripts are hosted in the Github 
[`xpack/xpack-build-box`](https://github.com/xpack/xpack-build-box) project.

## License

Unless otherwise mentioned, all **xPack** tools with original content 
are provided **free of charge** under the terms of the 
[MIT License](https://opensource.org/licenses/MIT).
