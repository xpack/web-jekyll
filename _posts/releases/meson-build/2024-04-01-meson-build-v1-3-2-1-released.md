---
title:  xPack Meson Build v1.3.2-1 released

summary: "Version **1.3.2-1** is a new release; it follows the upstream release."

upstream_version: "1.3.3"
upstream_release_date: "13 Feb 2024"
python_version: "3.11"
python_subversion: "8"

version: "1.3.2-1"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/meson-build-xpack/releases/tag/v1.3.2-1/

comments: true

date: 2024-04-01 11:57:25 +0300

redirect_to: https://xpack-dev-tools.github.io/meson-build-xpack/blog/2024/04/01/meson-build-v1-3-2-1-released/

# For Jekyll releases selection.
categories:
  - releases
  - meson-build

# For navigation; use scripts/createtag.sh in Jekyll.
tags:
  - releases
  - meson-build
  - meson
  - build
  - python
  - ninja

---

The [xPack Meson Build](https://xpack.github.io/meson-build/)
is a standalone cross-platform binary distribution of
[Meson Build](https://mesonbuild.org).

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

## Install

The full details of installing the **xPack Meson Build** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/meson-build/install/) page.

### Easy install

The easiest way to install Meson Build is with
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/meson-build`](https://www.npmjs.com/package/@xpack-dev-tools/meson-build)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/meson-build@latest --verbose

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/meson-build@{{ page.version }}.{{ page.npm_subversion }} --verbose
```

It is also possible to install Meson Build globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/meson-build@latest --verbose
```

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/meson-build
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/meson-build
```

## Compliance

The xPack Meson Build generally follows the official
[Meson Build](https://mesonbuild.org) releases.

The current version is based on:

- Meson Build release
[{{ page.upstream_version }}](https://github.com/mesonbuild/meson/releases/tag/{{ page.upstream_version }}) from {{ page.upstream_release_date }}.

## Changes

Compared to the upstream version, there are no functional changes.

## Bug fixes

- none

## Enhancements

- none

## Known problems

- none

## Embedded Python

To simplify dependency management, this release embeds a **Python
{{ page.python_version }}.{{ page.python_subversion }}** instance.

The `meson` executable is a standard ELF/EXE which includes the Python
run-time; the `main()` function prepares the Python environment and then
invokes the Meson main:

```python
  PyRun_SimpleString("from mesonbuild import mesonmain\n");
  PyRun_SimpleString("sys.exit(mesonmain.main())\n");
```

The Python library is located in the standard location:

- `lib/python{{ page.python_version }}`
- `lib/python{{ page.python_version }}/lib-dynload` (the platform dependent files)

The Meson files are located in:

- `lib/python{{ page.python_version }}/mesonbuild`

To speed up execution, all Python files are compiled and are
available only as `.pyc`.

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

The original documentation is available from:

- [https://mesonbuild.com/Manual.html](https://mesonbuild.com/Manual.html)

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/meson-build-xpack/blob/xpack/README-BUILD.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/meson-build-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/meson-build-xpack/builds/)

## Checksums

The SHA-256 hashes for the files are:

```txt
0c50fa99e4f33037fe4bc1e9f1ba7474a55e89d7b33edf051782ddbc9ea725d4
xpack-meson-build-1.3.2-1-darwin-arm64.tar.gz

1a927a5e4fe036dbf20364f90fd52125bb5fa7d87ecd39d7b7caa26c8364070a
xpack-meson-build-1.3.2-1-darwin-x64.tar.gz

544a4a84882f007ac2526e8f18ea6b9aba817defb8fccf781481c67b1c1e0aa9
xpack-meson-build-1.3.2-1-linux-arm.tar.gz

e8a281bb166854bb8693c1a2f2fcba94fe36685e68f47edb3479bc585b1f81e6
xpack-meson-build-1.3.2-1-linux-arm64.tar.gz

f3924f1af34267262f230bc84957798bc4965acd86adcb74e070d335621310f0
xpack-meson-build-1.3.2-1-linux-x64.tar.gz

04417fe8a1cecc8d003a66d9ecb4a6641a6ee330f01920036d96f1979c17d75c
xpack-meson-build-1.3.2-1-win32-x64.zip

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

- GitHub [xpack-dev-tools/meson-build-xpack](https://github.com/xpack-dev-tools/meson-build-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/meson-build-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/meson-build-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/meson-build-xpack/total.svg)](https://github.com/xpack-dev-tools/meson-build-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=meson-build-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/meson-build](https://www.npmjs.com/package/@xpack-dev-tools/meson-build)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/meson-build.svg)](https://www.npmjs.com/package/@xpack-dev-tools/meson-build/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/meson-build.svg)](https://www.npmjs.com/package/@xpack-dev-tools/meson-build/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
