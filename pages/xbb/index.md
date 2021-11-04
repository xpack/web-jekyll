---
title: The xPack Build Box
permalink: /xbb/

summary: An elaborated environment for building binary xPacks.
comments: true

date: 2016-03-09 12:04:00 +0300

---

The xPack Build Box is an elaborated build environment focused on
obtaining **reproducible builds** while building **cross-platform standalone
binaries** for GNU/Linux, macOS and Windows.

## How it works?

XBB achieves repetability and consistency by compiling all dependencies
from sources.

This applies both to the development environment and to the final
application binaries.

By strictly controlling the versions of the compiled sources and tools, it is
possible to create build environments that use about the same tools
on both GNU/Linux (Intel and Arm) and macOS, helping to obtain
consistent results.

On GNU/Linux, to allow the builds to run on any distribution,
the actual development tools are packed as Docker images
(Intel/Arm, 32/64-bit).

## Types of builds

There are two types of builds:

- local/native builds, intended for development and running on the local
  machine
- distribution builds, intended for xPack binary distributions and running
  on most modern machines

The main use cases of XBBs are distribution builds, but they can be used
for native builds as well.

## Supported platforms

Generally, xPack binaries are available for the following platforms:

- Intel Windows 32-bit
- Intel Windows 64-bit
- Intel GNU/Linux 32-bit
- Intel GNU/Linux 64-bit
- Arm GNU/Linux 32-bit
- Arm GNU/Linux 64-bit
- Intel macOS 64-bit

XBB supports creating binaries for all these platforms.

For the detailed supported versions, please check the specific
[release]({{ site.baseurl }}/xbb/releases/) page.

### Arm binaries

Support for Arm binaries was added in v3.1, in early 2020.

The supported architectures are:

- `arm64v8` - the ARMv8 64-bit architecture Aarch64
- `arm32v7` - the ARMv7 32-bit architecture with hardware float (armhf)

## Docker specifics

As with any Docker builds, the XBB builds run completely inside Docker
containers, which start afresh each time they are instantiated.

To pass the folder with the build scripts in and the results out,
it is usual to use a `Work` folder, for example:

```console
$ docker run -it --volume "${HOME}/Work:/Host/Work" ilegeul/ubuntu:amd64-12.04-xbb-v3.3
root@831bc35faf9f:/# ls -l /Host/Work
total 175320
drwxr-xr-x  14 root root       448 Mar  7 19:47 arm-none-eabi-gcc-9.2.1-1.2
drwxr-xr-x 144 root root      4608 Mar  9 13:15 cache
drwxr-xr-x  34 root root      1088 Mar 26 11:22 openocd-0.10.0-14
drwxr-xr-x  12 root root       384 Oct 30 19:00 riscv-none-embed-gcc-8.3.0-1.1
```

In this simple configuration, the builds run with root permissions; with
more elaborate configurations it is possible to start the Docker images
with user rights, but they are beyound the scope of this document.

## How to use the XBB tools

Both on GNU/Linux and macOS, the XBB tools are installed in separate
folders, and are fully distinct from the system tools.

To access them, the application should update the `PATH` to prefer
the newer XBB tools.

Scripts defining some helper functions are available.

### GNU/Linux

The `xbb_activate` function can be called either for the entire lifespan
of the script, or, for a better isolation, in inner shells when the new
tools are really needed.

```bash
source "/opt/xbb/xbb-source.sh"
...
(
  xbb_activate

  ...
  ./configure
  make
)
```

### macOS

For macOS the recommended use case is similar, except the XBB tools
are installed in the user HOME folder:

```bash
source "${HOME}/.local/xbb/xbb-source.sh"
...
(
  xbb_activate

  ...
)
```

## The `xbb-source.sh` script

The build environment includes a helper script, `xbb-source.sh`,
which should be included
with `source` by the build scripts, to define more bash functions to
the shell.

These functions are used to extend the environment with resources available
in the XBB folders.

The `xbb_activate` function is used to extend the `PATH` with folders
in the XBB folders, in front of existing
folders, so that **the XBB executables are preferred over the system ones**.

## The `pkg-config-verbose` script

While running the configuration step, it is sometimes useful to trace
how `pkg-config` identifies resources to be used during the build.

The standard `pkg-config` does not have an option to increase verbosity.

The workaround is to use a separate script that displays the received command
and the response on the stderr stream.

This script is not specific to XBB, and can be used with any build.

For this, copy the file into `.../xbb/bin` or any other folder present
in the PATH and pass the script name via the environment.

```sh
chmod +x /opt/xbb/bin/pkg-config-verbose
export PKG_CONFIG=pkg-config-verbose
```

## TeX

All images include the TeX tools; on GNU/Linux, they are
installed either in the system folders or in a custom global folder
(like `/opt/texlive`); on on macOS they are installed in a custom local
folder (like `${HOME}/.local/texlive`).

## Maintainer info

- [README-MAINTAINER](https://github.com/xpack/xpack-build-box/blob/master/README-MAINTAINER.md)

## Future plans

The current XBB got extremely complex due to the initial requirement to
also support RedHat Enterprise systems.

RedHat maintenance support 1 for RHEL 7 ended in Aug. 2020, with
maintenance support 2 to last until June. 2024. However XBB support
for RHEL 7 is a tough requirement, and will be dropped in the next major
release, probably in 2022.

For the future release, the plan is to move up to
Ubuntu 18 (GLIBC 2.27). This will also provide compatibility with
RedHat 8 / Debian 10, which both use GLIBC 2.28.

## Credits

The xPack Build Box is inspired by the
[Holy Build Box](https://github.com/phusion/holy-build-box).

## Links

- [Prerequisites]({{ site.baseurl }}/xbb/prerequisites/) for using XBB
- [End-of-support]({{ site.baseurl }}/xbb/end-of-support/) considerations for GNU/Linux distributions
- [Releases]({{ site.baseurl }}/xbb/releases/)
- [GitHub](https://github.com/xpack/xpack-build-box)
