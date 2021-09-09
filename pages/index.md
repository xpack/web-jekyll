---
title: "The xPack Build Framework"
permalink: /

keywords: packages, code sharing, reusing, libraries, applications, c/c++, embedded
toc: false
summary: Tools to manage, configure and build complex, package based, multi-target projects.

date: 2019-06-20 23:11:00 +0300

---

## Mission statement

In short: help developers manage dependencies.

Based on a simple multi-version dependencies manager
(built on top of **npm**),
the xPack project aims to provide a set of cross-platform tools
to manage, configure and build complex,
modular, multi-target (multi-architecture, multi-board, multi-toolchain)
projects, with an emphasis on **C/C++** and
bare-metal embedded projects.

The expected benefits are more efficient **code sharing** and
**reusing** during the life cycle of libraries and applications.

## xPacks overview

_Did you ever face the situation when building a perfectly fine and
functional project suddenly failed after
upgrading the system? In other words, were you hit by the dependencies
hell? If so, xPacks may help you._

**xPacks** are general purpose versioned software projects,
built on top of the highly successful
[npm packages](https://docs.npmjs.com/getting-started/what-is-npm)
in the [Node.js](https://nodejs.org/en/) JavaScript ecosystem.
**xPacks** do not introduce a new package format, but use
exactly the same format as **npm packages**, and can be
stored in the same repositories.

By design the xPacks tools are **multi-version**, which means
not only that packages can have
multiple versions, but they **can be installed in parallel**, each
project/configuration having its own set of dependencies,
thus upgrading the system no longer impacts the project.

{% include note.html content="Most of the tools are generic and do not
mandate the use of a package manager; the binary xPacks are plain archives
that can be extracted manually; the source xPacks can be linked to
projects as Git submodules, etc; they all can be used in traditional
environments too, just that it requires much more work." %}

Although the focus is on **C/C++**, most of the tools are language agnostic
and can be used with other programming languages as well.

Based on the installed content, there are currently two
types of xPacks: **source** and **binary**:

- **source xPacks** are packages that install source files,
generally libraries used by the project
- **binary xPacks** are packages that install binary/executable files,
generally tools used during the build process, like toolchains,
builders, etc.

For more details, read the [xPack 101]({{ site.baseurl }}/intro/) page.

The entire xPack project is split amongst several groups,
published as separated GitHub _organisations_
([xpack](https://github.com/xpack),
[xpack-dev-tools](https://github.com/xpack-dev-tools),
[micro-os-plus](https://github.com/micro-os-plus/),
[xpack-3rd-party](https://github.com/xpack-3rd-party)).

## xPack Core Tools

The core xPack tools are:

- [`xpm`]({{ site.baseurl }}/xpm/) - the **xPack Project Manager**

Planned:

- [`@xpack/xpbuild`]({{ site.baseurl }}/xpbuild/) - the **xPack Project Builder** (under development)
- [`@xpack/xpcdl`]({{ site.baseurl }}/xpcdl/) - the **xPack Build Configurator**
- `@xpack/xpliquid` - the **xPack Liquid Template Engine**
- `@xpack/xpjson` - the **xPack JSON Manager**
- [`@xpack/xpninja`]({{ site.baseurl }}/xpninja/) - the **xPack Build Runner**

These projects are hosted in the GitHub
[`xpack`](https://github.com/xpack) organisation.

## xPack based Development Tools

The main binary tools packed as xPacks are:

- [`@xpack-dev-tools/arm-none-eabi-gcc`]({{ site.baseurl }}/arm-none-eabi-gcc/) - the **xPack Arm Embedded GCC** toolchain
- [`@xpack-dev-tools/openocd`]({{ site.baseurl }}/openocd/) - the **xPack OpenOCD**
- [`@xpack-dev-tools/qemu-arm`]({{ site.baseurl }}/qemu-arm/) - the **xPack QEMU Arm Cortex-M**
- [`@xpack-dev-tools/riscv-none-embed-gcc`]({{ site.baseurl }}/riscv-none-embed-gcc/) - the **xPack RISC-V Embedded GCC** toolchain
- [`@xpack-dev-tools/windows-build-tools`]({{ site.baseurl }}/windows-build-tools/) - the **xPack Windows Build Tools**
- [`@xpack-dev-tools/ninja-build`]({{ site.baseurl }}/ninja-build/) - the **xPack Ninja Build**
- [`@xpack-dev-tools/cmake`]({{ site.baseurl }}/cmake/) - the **xPack CMake**
- [`@xpack-dev-tools/meson-build`]({{ site.baseurl }}/meson-build/) - the **xPack Meson Build**

Under development:

- [`@xpack-dev-tools/gcc`]({{ site.baseurl }}/gcc/) - the **xPack GNU Compiler Collection (GCC)** (C/C++/Obj-C/Obj-C++/Fortran)
- `@xpack-dev-tools/clang` - the **xPack GNU GDB**

Planned:

- `@xpack-dev-tools/coreutils` - the **xPack GNU coreutils**
- `@xpack-dev-tools/make` - the **xPack make**

These projects are hosted in the GitHub
[`xpack-dev-tools`](https://github.com/xpack-dev-tools) group
(_organization_ in GitHub parlance).

## Source xPacks

### µOS++

Packages part of the µOS++ framework:

- [@micro-os-plus/architecture-cortexm](https://github.com/micro-os-plus/architecture-cortexm-xpack)
  A source xPack with the µOS++ Arm Cortex-M architecture port
- [@micro-os-plus/architecture-riscv](https://github.com/micro-os-plus/architecture-riscv-xpack)
  A source xPack with the µOS++ RISC-V architecture port
- [@micro-os-plus/architecture-synthetic-posix](https://github.com/micro-os-plus/architecture-synthetic-posix-xpack)
  A source xPack with the µOS++ synthetic POSIX architecture port
- [@micro-os-plus/build-helper](https://github.com/micro-os-plus/build-helper-xpack)
  A source xPack to assist the µOS++ builds
- [@micro-os-plus/cmsis-os](https://github.com/micro-os-plus/cmsis-os-xpack)
  A source xPack with the µOS++ CMSIS RTOS compatibility layer
- [@micro-os-plus/devices-stm32f0-extras](https://github.com/micro-os-plus/devices-stm32f0-extras-xpack)
  A source xPack with µOS++ complementary STM32F0 files
- [@micro-os-plus/devices-stm32f4-extras](https://github.com/micro-os-plus/devices-stm32f4-extras-xpack)
  A source xPack with µOS++ complementary STM32F4 files
- [@micro-os-plus/diag-trace](https://github.com/micro-os-plus/diag-trace-xpack)
  A source xPack with the µOS++ trace::printf() tracing infrastructure
- [@micro-os-plus/libs-c](https://github.com/micro-os-plus/libs-c-xpack)
  A source xPack with µOS++ complementary C library functions
- [@micro-os-plus/libs-cpp](https://github.com/micro-os-plus/libs-cpp-xpack)
  A source xPack with complementary C++ library functions
- [@micro-os-plus/libs-cpp-estd](https://github.com/micro-os-plus/libs-cpp-estd-xpack)
  A source xPack with µOS++ embedded std:: support
- [@micro-os-plus/memory-allocators](https://github.com/micro-os-plus/memory-allocators-xpack)
  A source xPack with µOS++ memory allocators
- [@micro-os-plus/posix-io](https://github.com/micro-os-plus/posix-io-xpack)
  A source xPack with POSIX I/O
- [@micro-os-plus/rtos](https://github.com/micro-os-plus/rtos-xpack)
  A source xPack with the µOS++ RTOS
- [@micro-os-plus/semihosting](https://github.com/micro-os-plus/semihosting-xpack)
  A source xPack with the portable semihosting definitions
- [@micro-os-plus/startup](https://github.com/micro-os-plus/startup-xpack)
  A source xPack with the µOS++ startup code for bare-metal platforms
- [@micro-os-plus/utils-lists](https://github.com/micro-os-plus/utils-lists-xpack)
  A source xPack with C++ lists support for µOS++
- [@micro-os-plus/version](https://github.com/micro-os-plus/version-xpack)
  A source xPack with the µOS++ version definitions

### 3rd Party

Packages with 3rd party content:

- `@xpack-3rd-party/freertos` - FreeRTOS
- `@xpack-3rd-party/chan-fatfs` - Chan-FatFS

## xPack Build Box (XBB)

Scripts to create the development environments used to build the
archives used by the binary xPacks.

The development environments are based on:

- **Ubuntu 12** Docker images, used to build the Intel GNU/Linux and Windows
  distributions
- **Ubuntu 16** Docker images, used to build the Arm GNU/Linux
  distributions
- **macOS 10.10** tools, used to build the Intel macOS distributions

These scripts are hosted in the Github
[`xpack/xpack-build-box`](https://github.com/xpack/xpack-build-box) project.

## Notifications

To stay up-to-date with new binary tools releases, the recommended way is
to follow [@xpack_project](https://twitter.com/xpack_project) on Twitter.

Alternatively you can subscribe to this site RSS feed
[https://xpack.github.io/feed.xml](https://xpack.github.io/feed.xml).

To stay current with changes to individual projects, enable **watching**
in the GitHub web interface for each project of interest.

## License

Unless otherwise mentioned, all **xPack** tools with original content
are provided **free of charge** under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Let us know if you enjoyed using this project!

If you enjoyed using this project, please let us know; here are some advices:

- the best way to praise us would be to **donate**; if you want to speed
up development and help future versions include more and more great
features, please consider donating; any contribution, small or
generous, will be highly appreciated;
- star the projects you liked on GitHub ([xPack](https://github.com/xpack)
or [xPack Dev Tools](https://github.com/xpack-dev-tools/));
- follow the project on [Twitter](https://twitter.com/xpack_project),
to get notifications on new releases.

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick" />
<input type="hidden" name="hosted_button_id" value="NXKFN7DJH8DJ6" />
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
<img alt="." border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1" />
</form>
