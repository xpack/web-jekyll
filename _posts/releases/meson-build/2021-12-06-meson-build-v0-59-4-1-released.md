---
title:  xPack Meson Build v0.59.4-1 released
sidebar: meson-build

summary: "Version **0.59.4-1** is a new release; it follows the upstream release. It also **adds support for Apple Silicon** and uses the latest build scripts."

version: 0.59.4-1
upstream_version: 0.59.4
upstream_release_date: "Oct 28th, 2021"
npm_subversion: 1
python_version: 3.9
python_subversion: 7

download_url: https://github.com/xpack-dev-tools/meson-build-xpack/releases/tag/v0.59.4-1/

date: 2021-12-06 21:45:29 +0200

redirect_to: https://xpack-dev-tools.github.io/meson-build-xpack/blog/2021/12/06/meson-build-v0-59-4-1-released/

comments: true

categories:
  - releases
  - meson-build

tags:
  - releases
  - meson-build
  - meson
  - build
  - python
  - ninja

---

The [xPack Meson Build](https://xpack.github.io/dev-tools/meson-build/)
is a standalone cross-platform binary distribution of
[Meson Build](https://mesonbuild.org).

There are separate binaries for **Windows** (x64 and x86),
**macOS** (x64, arm64)
and **GNU/Linux** (x64 and x86, arm64 and arm).

{% include note.html content="The main targets for the GNU/Linux Arm
binaries are the **Raspberry Pi** class devices (armv7l and aarch64;
armv6 is not supported)." %}

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Prerequisites

- x86/x64 GNU/Linux: any system with **GLIBC 2.15** or higher
  (like Ubuntu 12 or later, Debian 8 or later, RedHat/CentOS 7 later,
  Fedora 20 or later, etc)
- arm64/arm GNU/Linux: any system with **GLIBC 2.23** or higher
  (like Ubuntu 16 or later, Debian 9 or later, RedHat/CentOS 8 or later,
  Fedora 24 or later, etc)
- x86/x64 Windows: Windows 7 with the Universal C Runtime
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
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/meson-build@latest

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/meson-build@{{ page.version }}.{{ page.npm_subversion }}
```

It is also possible to install Meson Build globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/meson-build@latest --verbose
```

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/meson-build
```

To completely remove the package from the central xPacks store:

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

The scripts used to build this distribution are in:

- `distro-info/scripts`

For the prerequisites and more details on the build procedure, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/meson-build-xpack/blob/xpack/README-MAINTAINER.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/meson-build-xpack/actions/)
- [Travis CI](https://app.travis-ci.com/github/xpack-dev-tools/meson-build-xpack/builds/)

## Checksums

The SHA-256 hashes for the files are:

```txt
7b763d577ad058a918118f50e4970df4a651a579dcea0e7d4bb136232909fc6a
xpack-meson-build-0.59.4-1-darwin-arm64.tar.gz

92d387e2144c6856c2eaae45ed667d37df0807d100c2bc90323237d78fed7e74
xpack-meson-build-0.59.4-1-darwin-x64.tar.gz

4fc5b100efee62eddfd57adbf413091cf548c412f80ba28293af5687b9146177
xpack-meson-build-0.59.4-1-linux-arm.tar.gz

be70357fc857774c72ea3f1e663d045c3711f35db1ceb115091c7e59d0dbcfc4
xpack-meson-build-0.59.4-1-linux-arm64.tar.gz

2b21c8e75caeeebed1c0d769f5199d53f1ef4261332768a035279a8beab38989
xpack-meson-build-0.59.4-1-linux-ia32.tar.gz

81ae62a77f9d432bb5d4f8eba36ce47cdc584eff1351bf5b37fada54b1d38330
xpack-meson-build-0.59.4-1-linux-x64.tar.gz

18b4aa2323e9ca72dc6433fb0cf3ed70432cf1ed7c0755c613c8980f848f70ae
xpack-meson-build-0.59.4-1-win32-ia32.zip

c45f3003c4a926fe18dff0917c7212988b71352dab86925eb5c2b60047cf7e30
xpack-meson-build-0.59.4-1-win32-x64.zip

```

## Deprecation notices

### 32-bit support

Support for 32-bit x86 GNU/Linux and x86 Windows will most probably
be dropped in 2022. Support for 32-bit Arm GNU/Linux will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### GNU/Linux minimum requirements

Support for RedHat 7 will most probably be dropped in 2022, and the
minimum requirement will be raised to GLIBC 2.27, available starting
with Ubuntu 18 and RedHat 8.

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
