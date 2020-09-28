---
title:  xPack Windows Build Tools v2.12.2 released

summary: "Version 2.12.2 is a maintenance release; it repacks the same
tools from the previous release, but built with the new XBB v3.2 tools."

version: 2.12.2
npm_subversion: 2
download_url: https://github.com/xpack-dev-tools/windows-build-tools-xpack/releases/tag/v2.12.2/

date:   2020-07-14 12:01:00 +0300

categories:
  - releases
  - windows-build-tools

tags:
  - releases
  - windows-build-tools
  - build
  - make
  - rm
  - mkdir
  - busybox

---

This is the **xPack** distribution of **Windows Build Tools** (formerly part
of the GNU MCU/ARM Eclipse project).

There are separate binaries that run on **Windows**, 32/64-bit.

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Install

The full details of installing the **xPack Windows Build Tools** on various platforms
are presented in the separate
[Install]({{ site.baseurl }}/windows-build-tools/install/) page.

### Easy install

The easiest way to install Windows Build Tools is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/windows-build-tools`](https://www.npmjs.com/package/@xpack-dev-tools/windows-build-tools)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```console
$ xpm install --global @xpack-dev-tools/windows-build-tools@latest
```

To install this specific version, use:

```console
$ xpm install --global @xpack-dev-tools/windows-build-tools@{{ page.version }}-{{ page.npm_subversion }}
```

## Compliance

The xPack Windows Build Tools uses programs from other projects.

The current version is based on:

- GNU make version 4.2.1-1 from the [MSYS2](https://sourceforge.net/projects/msys2/) project
- [Busybox](https://github.com/rmyorston/busybox-w32), the 65ae5b24c commit from Apr 06, 2019

To get a list of changes since the previous release, use `git log` in the
`xpack-dev-tools/openocd` project

```
git log --pretty='%cd * %h %s' --date=short 'v2.12'..'v2.12.2'
```

## Changes

There are no functional changes from original projects..

## Known problems

- none

## Documentation

- none

## Supported platforms

Only binaries for **Windows** are provided.

The binaries were built using
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

- Windows: all binaries were built with mingw-w64 GCC 9.3, running in an
  Ubuntu 12 Docker container

## Build

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/windows-build-tools-xpack/blob/xpack/README-BUILD.md) page.

## Travis tests

- none

## Tests

The binaries were testes on Windows 10 Pro 32/64-bit.

The tests consist in running Eclipse builds.

In all cases, install the archive in Downloads and configure the path
in Eclipse.

## Checksums

The SHA-256 hashes for the files are:

```
0076cf109d08f7a176267c12aa3f8df9bce9a02b386379ad199f169b98193897
xpack-windows-build-tools-2.12.2-win32-x32.zip

b45514eece3fd28a26e69a4e16364021309900791699f4167f4172c20c81e9cf
xpack-windows-build-tools-2.12.2-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/windows-build-tools-xpack.git](https://github.com/xpack-dev-tools/windows-build-tools-xpack/)
  - latest release
[![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/windows-build-tools-xpack/latest/total.svg)](https://github.com/xpack-dev-tools/windows-build-tools-xpack/releases/)
  - all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/windows-build-tools-xpack/total.svg)](https://github.com/xpack-dev-tools/windows-build-tools-xpack/releases/)
- xPack [@xpack-dev-tools/windows-build-tools](https://github.com/xpack-dev-tools/windows-build-tools-xpack/)
  - latest release, per month
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/windows-build-tools.svg)](https://www.npmjs.com/package/@xpack-dev-tools/windows-build-tools/)
[![npm](https://img.shields.io/npm/dm/@xpack-dev-tools/windows-build-tools.svg)](https://www.npmjs.com/package/@xpack-dev-tools/windows-build-tools/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/windows-build-tools.svg)](https://www.npmjs.com/package/@xpack-dev-tools/windows-build-tools/)
  - all @gnu-mcu-eclipse releases [![npm](https://img.shields.io/npm/dt/@gnu-mcu-eclipse/windows-build-tools.svg)](https://www.npmjs.com/package/@gnu-mcu-eclipse/windows-build-tools/)
- [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=windows-build-tools-xpack) (grouped per release)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
