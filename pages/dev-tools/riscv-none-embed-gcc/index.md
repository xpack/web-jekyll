---
title: The xPack GNU RISC-V Embedded GCC
permalink: /riscv-none-embed-gcc/

summary: "A binary distribution of GNU RISC-V Embedded GCC."
comments: true
keywords: 
  - riscv-none-embed-gcc
  - riscv
  - gcc
  - embedded

date: 2019-07-10 17:53:00 +0300
last_updated: 2019-10-11 15:52:59 +0300

---

## Quicklinks

If you already know the general facts about xPack GNU RISC-V Embedded GCC, you can 
directly skip to the desired pages.

User pages:

- [Install]({{ site.baseurl }}/riscv-none-embed-gcc/install/)
- [Support]({{ site.baseurl }}/riscv-none-embed-gcc/support/)
- [Releases]({{ site.baseurl }}/riscv-none-embed-gcc/releases/)

Developer & maintainer pages:

- [GitHub](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack)
- [How to build?](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/blob/xpack/README-BUILD.md)
- [How to publish?](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/blob/xpack/README-PUBLISH.md)

## Overview

The **xPack GNU RISC-V Embedded GCC** 
is an alternate binary distribution that complements the official 
[SiFive](https://www.sifive.com/boards) toolchain.

## Benefits

The main advantages of using the **xPack GNU RISC-V Embedded GCC** are:

- a convenient, uniform and portable install/uninstall/upgrade procedure;
  the same procedure is used for all major 
  platforms (Windows 64/32-bit, GNU/Linux 64/32-bit, macOS);
- a convenient integration with Continuous Integration environments, 
  like Travis;
- a better integration with development environments 
  like **GNU MCU Eclipse**.

All binaries are self-contained, they include all required libraries,
and can be installed at any location.

## Compatibility

The **xPack GNU RISC-V Embedded GCC** is generally compatible with the 
SiFive toolchain, except it no longer mandates the linker to include
the `libgloss` library, which issues `ECALL` instructions, that fail on 
bare-metal platforms.

## Install

The details of installing the **xPack GNU RISC-V Embedded GCC** on various 
platforms are presented in the separate 
[Install]({{ site.baseurl }}/riscv-none-embed-gcc/install/) page.

## Documentation

The **xPack GNU RISC-V Embedded GCC** distribution includes the 
standard GCC documentation, in info, man and pdf format; 
it is located in the `share/doc` folder, for example the pdf files are:

```console
$ tree share/doc/pdf
share/doc/pdf
├── annotate.pdf
├── as.pdf
├── bfd.pdf
├── binutils.pdf
├── gcc
│   ├── cpp.pdf
│   ├── cppinternals.pdf
│   ├── gcc.pdf
│   ├── gccinstall.pdf
│   └── gccint.pdf
├── gdb.pdf
├── gprof.pdf
├── ld.pdf
├── libc.pdf
├── libiberty.pdf
├── libm.pdf
├── porting.pdf
├── refcard.pdf
└── stabs.pdf

1 directory, 18 files
```

## riscv64-unknown-elf-gcc

After installing the toolchain, you'll end up with lots of programs 
prefixed by `riscv-none-embed-`. For those used to the RISC-V original 
toolchains, there is no `riscv64-` or `riscv32-` prefix since it is 
actually not needed, the toolchain produces both 32/64-bit binaries, 
based on `-march` and `-mabi`.

## `-march` and `-mabi`

The RISC-V design is not a single architecture, but a family of architectures, with optional components, identified by letters.

RISC-V ISA strings begin with either RV32I, RV32E, RV64I, or RV128I indicating the supported address space size in bits for the base integer ISA.

* RV32I: A load-store ISA with 32, 32-bit general-purpose integer registers. 
* RV32E: An embedded flavor of RV32I with only 16 integer registers. 
* RV64I: A 64-bit flavor of RV32I where the general-purpose integer registers are 64-bit wide. 

In addition to these base ISAs, a handful of extensions have been 
specified. The extensions that have both been specified and are supported by the toolchain are: 

* M - Integer Multiplication and Division 
* A - Atomics
* F - Single-Precision Floating-Point 
* D - Double-Precision Floating-Point
* C - 16-bit Compressed Instructions 

* G - General, a shortcut to IMAFD

RISC-V ISA strings are defined by appending the supported extensions to the 
base ISA in the order listed above. For example, the RISC-V ISA with 32, 
32-bit integer registers and the instructions to for multiplication would 
be denoted as "RV32IM". Users can control the set of instructions that GCC 
uses when generating assembly code by passing the lower-case ISA string to 
the `-march` GCC option: for example `-march=rv32im`. 

For more details, please see [The RISC-V Instruction Set Manual, Volume I: User-Level ISA, Document Version 2.2](https://riscv.org/specifications/).

In addition to controlling the instructions available to GCC during code 
generating (which defines the set of implementations the generated code 
will run on), users can select from various ABIs to target (which defines 
the calling convention and layout of objects in memory). Objects and 
libraries may only be linked together if they follow the same ABI. 

RISC-V defines two integer ABIs and three floating-point ABIs, which 
together are treated as a single ABI string. The integer ABIs follow the 
standard ABI naming scheme: 

* `ilp32`: "int", "long", and pointers are all 32-bit long. "long long" is 
a 64-bit type, "char" is 8-bit, and "short" is 16-bit. 
* `lp64`: "long" and pointers are 64-bit long, while "int" is a 32-bit type. 
The other types remain the same as ilp32. 

while the floating-point ABIs are a RISC-V specific addition: 

* "" (the empty string): No floating-point arguments are passed in registers. 
* `f`: 32-bit and smaller floating-point arguments are passed in registers. 
This ABI requires the F extension, as without F there are no 
floating-point registers. 
* `d`: 64-bit and smaller floating-point arguments are passed in registers. 
This ABI requires the D extension. 

Just like ISA strings, ABI strings are concatenated together and passed via 
the `-mabi` argument to GCC. For example: 

* `-march=rv32imafdc -mabi=ilp32d`: Hardware floating-point instructions can 
be generated and floating-point arguments are passed in registers. This 
is like the `-mfloat-abi=hard` option to Arm's GCC. 
* `-march=rv32imac -mabi=ilp32`: No floating-point instructions can be 
generated and no floating-point arguments are passed in registers. This 
is like the `-mfloat-abi=soft` argument to Arm's GCC. 
* `-march=rv32imafdc -mabi=ilp32`: Hardware floating-point instructions can 
be generated, but no floating-point arguments will be passed in 
registers. This is like the `-mfloat-abi=softfp` argument to Arm's GCC, 
and is usually used when interfacing with soft-float binaries on a 
hard-float system. 
* `-march=rv32imac -mabi=ilp32d`: Illegal, as the ABI requires floating-point 
arguments are passed in registers but the ISA defines no floating-point 
registers to pass them in. 

## Multiple libraries

Due to the large number of architectures and ABIs defined for RISC-V, not all possible combinations are actually available.

Please check the release for the actual list.

## Support

For the various support options, please read the separate 
[Support]({{ site.baseurl }}/riscv-none-embed-gcc/support/) page.

## Change log

The release and change log is available in the repository
[`CHANGELOG.md`](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/blob/xpack/CHANGELOG.md) file.

## Build details

For those interested in building the binaries, please read the 
[How to build?](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/blob/xpack/README-BUILD.md)
page. 
However, the ultimate source for details are the build scripts themselves, 
all available from the 
[`riscv-none-embed-gcc-xpack.git/scripts`](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/tree/xpack/scripts/)
folder.

## Releases

See the [Releases]({{ site.baseurl }}/riscv-none-embed-gcc/releases/) page.

