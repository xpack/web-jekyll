---
title: "The xPack Project"
permalink: /index.html
keywords: packages, code sharing, reusing, libraries, applications, c/c++, embedded
sidebar: top_sidebar
toc: false
github_editme: true
---

## Mission statement

Provide a set of tools to manage, configure and build complex, package based, 
multi-target (multi-architecture, multi-board, multi-toolchain) projects, 
intended to **enhance code sharing** and **reusing** during the life
cycle of libraries and applications, with an emphasis on C/C++ and embedded.

## xPacks overview

**xPacks** are general purpose multi-version software packages, 
much the same as the highly successful 
[npm modules](https://docs.npmjs.com/getting-started/what-is-npm) 
in the [Node.js](https://nodejs.org/en/) JavaScript ecosystem.

By multi-version it is understood not only that packages can have 
multiple versions, but they can be installed in parallel, each
project having its own set of dependencies.

Based on the installed content, there are currently two 
types of xPacks: **source** and **binary**:

- **source** xPacks are packages that install source files, 
generally libraries added to the project.
- **binary**  xPacks are packages that install binary files, 
generally tools used during the build process, like toolchains,
builders, etc.

The entire xPack project is split amongst several groups, all
stored as separated GitHub _organizations_.

## xPack Core Tools

The core xPack tools are:

- `xpm` - the **xPack Package Manager**
- `xpbuild` - the **xPack Basic Project Builder**
- `xpmake` - the **xPack Build Generator** (in design phase)
- `xpninja` - the **xPack Build Runner** (in design phase)
- `xpcdl` - the **xPack Build Configurator** (in design phase)

## xPack based Development Tools

The main binary tools packed as xPacks are:

- `arm-none-eabi-gcc` - the xPack ARM Embedded GCC toolchain
- `openocd` - the xPack OpenOCD 
- `qemu-system-gnuarmeclipse` - the xPack GNU ARM Eclipse QEMU
- `riscv-none-embed-gcc` - the xPack RISC-V Embedded GCC toolchain

Planned to be added:

- `gdb` - the **xPack GNU GDB**
- `binutils` - the **xPack GNU binutils**
- `gcc` - the **xPack GNU GCC**
- `cmake` - the **xPack CMake**
- `ninja` - the **xPack Ninja Build**


## License

Unless otherwise mentioned, all **xPack** tools with original content 
are provided **free of charge** under the terms of the 
[MIT License](https://opensource.org/licenses/MIT).
