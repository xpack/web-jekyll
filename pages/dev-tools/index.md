---
title: xPack 3rd Party Development Tools
permalink: /dev-tools/

summary: Tools from 3rd party projects used during builds.

comments: true

date: 2023-02-07 11:29:00 +0200

redirect_to: https://xpack-dev-tools.github.io

---

## Overview

These are tools provided by 3rd party projects, used during builds.

They are generally binary tools, compiled from sources.

The scripts used to build them are open source projects, hosted in the GitHub
[`xpack-dev-tools`](https://github.com/xpack-dev-tools/) organization.

## Index

The main binary tools packed as xPacks are (in alphabetical order):

- [`@xpack-dev-tools/aarch64-none-elf-gcc`]({{ site.baseurl }}/dev-tools/aarch64-none-elf-gcc/) - the **xPack GNU AArch64 Embedded GCC** toolchain
- [`@xpack-dev-tools/arm-none-eabi-gcc`]({{ site.baseurl }}/dev-tools/arm-none-eabi-gcc/) - the **xPack GNU Arm Embedded GCC** toolchain
- [`@xpack-dev-tools/clang`]({{ site.baseurl }}/dev-tools/clang/) - the **xPack LLVM clang**
- [`@xpack-dev-tools/cmake`]({{ site.baseurl }}/dev-tools/cmake/) - the **xPack CMake**
- [`@xpack-dev-tools/gcc`]({{ site.baseurl }}/dev-tools/gcc/) - the **xPack GNU Compiler Collection (GCC)**
- [`@xpack-dev-tools/meson-build`]({{ site.baseurl }}/dev-tools/meson-build/) - the **xPack Meson Build**
- [`@xpack-dev-tools/mingw-w64-gcc`]({{ site.baseurl }}/dev-tools/mingw-w64-gcc/) - the **xPack MinGW-w64 GCC** toolchain
- [`@xpack-dev-tools/ninja-build`]({{ site.baseurl }}/dev-tools/ninja-build/) - the **xPack Ninja Build**
- [`@xpack-dev-tools/openocd`]({{ site.baseurl }}/dev-tools/openocd/) - the **xPack OpenOCD**
- [`@xpack-dev-tools/qemu-arm`]({{ site.baseurl }}/dev-tools/qemu-arm/) - the **xPack QEMU Arm**
- [`@xpack-dev-tools/qemu-riscv`]({{ site.baseurl }}/dev-tools/qemu-riscv/) - the **xPack QEMU RISC-V**
- [`@xpack-dev-tools/riscv-none-elf-gcc`]({{ site.baseurl }}/dev-tools/riscv-none-elf-gcc/) - the **xPack RISC-V Embedded GCC** toolchain
- [`@xpack-dev-tools/windows-build-tools`]({{ site.baseurl }}/dev-tools/windows-build-tools/) - the **xPack Windows Build Tools**

## Other

Tools used for building the main binary tools:

- [`@xpack-dev-tools/m4`]({{ site.baseurl }}/dev-tools/m4/) - the **xPack GNU M4**
- [`@xpack-dev-tools/patchelf`]({{ site.baseurl }}/dev-tools/patchelf/) - the **xPack NixOS PatchELF**
- [`@xpack-dev-tools/pkg-config`]({{ site.baseurl }}/dev-tools/pkg-config/) - the **xPack pkg-config**
- [`@xpack-dev-tools/realpath`]({{ site.baseurl }}/dev-tools/realpath/) - the **xPack GNU realpath**
- [`@xpack-dev-tools/sed`]({{ site.baseurl }}/dev-tools/sed/) - the **xPack GNU sed**
- [`@xpack-dev-tools/wine`]({{ site.baseurl }}/dev-tools/wine/) - the **xPack WineHQ**
