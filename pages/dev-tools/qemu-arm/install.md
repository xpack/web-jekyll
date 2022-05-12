---
title: How to install the xPack QEMU Arm binaries
permalink: /qemu-arm/install/

summary: "The recommended method is via xpm."

toc: false
comments: true

version: 2.8.0

date: 2015-09-04 17:03:00 +0300

---

## Overview

The **xPack QEMU Arm** can be installed automatically, via `xpm` (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

## Easy install

The easiest way to install QEMU is by using the **binary xPack**, available as
[`@xpack-dev-tools/qemu`](https://www.npmjs.com/package/@xpack-dev-tools/qemu)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent
`xpm`, which is a portable
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

### Install

With xpm available, installing
the latest version of the package is quite easy:

```console
$ xpm install --global @xpack-dev-tools/qemu-arm@latest --verbose
```

This command will always install the latest available version,
in the global xPacks store, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

{% capture include_1 %}
The install location can be configured using the
`XPACKS_REPO_FOLDER` environment variable; for more details please check the
[xpm folders]({{ site.baseurl }}/xpm/folders/) page.
{% endcapture %}

{% include tip.html content=include_1 %}

{% include tip.html content="The archive content is unpacked in a folder
named `.content`. On some platforms
this might be hidden for normal browsing, and require
separate options (like `ls -A`) or, in file browsers, to enable
settings like **Show Hidden Files**." %}

xPacks aware tools, like the **Eclipse Embedded CDT plug-ins** automatically
identify binaries installed with
xpm and provide a convenient method to manage paths.

{% include important.html content="Automatic
path discovery for the packages from the new `@xpack-dev-tools` scope was
added to **GNU MCU Eclipse plug-ins** with v4.6.1 in 2019-09-23; update
older versions or configure the path manually." %}

### Uninstall

To remove the installed xPack, the command is similar:

```sh
xpm uninstall --global @xpack-dev-tools/qemu-arm --verbose
```

## Manual install

For all platforms, the **xPack QEMU Arm** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [Releases](https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/)
pages.

{% capture windows %}
### Download

The Windows versions of **xPack QEMU Arm** are packed as ZIP files.
Download the latest version named like:

- `xpack-qemu-arm-{{ page.version }}-7-win32-x64.zip`
- `xpack-qemu-arm-{{ page.version }}-7-win32-x32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-x32` file
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

To manually install the xPack QEMU Arm,
unpack the archive and copy it into the
`%USERPROFILE%\AppData\Roaming\xPacks\qemu-arm`
(for example `C:\Users\ilg\AppData\Roaming\xPacks\qemu-arm`) folder;
according to Microsoft, `AppData\Roaming` is the recommended location for
installing user specific packages.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to
install QEMU in any folder, it is highly recommended to use this
path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

### Test

To check if the manually installed QEMU starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\qemu-arm\xpack-qemu-arm-{{ page.version }}-7\bin\qemu-system-gnuarmeclipse.exe" --version
xPack 64-bit QEMU emulator version {{ page.version }}-7 (v{{ page.version }}-7-20180523-6-gee07085299-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```

#### Drivers

For usual Cortex-M emulation, there are no special drivers required.

{% endcapture %}

{% capture macos %}
### Download

The macOS version of **xPack QEMU Arm** is packed as a .tar.gz archive.
Download the latest version named like:

- `xpack-qemu-arm-{{ page.version }}-7-darwin-x64.tgz`

### Unpack

To manually install the xPack QEMU Arm,
unpack the archive and move it to
`~/opt/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-qemu-arm-{{ page.version }}-7-darwin-x64.tgz
$ chmod -R -w xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7
```

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

{% include important.html content="Although perfectly possible to
install QEMU in any folder, it is highly recommended to use this
path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/Library/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7
/Users/ilg/Library/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7/
├── README.md
├── bin
│   ├── libSDL2-2.0.0.dylib
│   ├── libSDL2_image-2.0.0.dylib
│   ├── libgcc_s.1.dylib
│   ├── libglib-2.0.0.dylib
│   ├── libgthread-2.0.0.dylib
│   ├── libiconv.2.dylib
│   ├── libintl.8.dylib
│   ├── libpixman-1.0.dylib
│   ├── libstdc++.6.dylib
│   ├── libz.1.2.11.dylib
│   ├── libz.1.dylib -> libz.1.2.11.dylib
│   └── qemu-system-gnuarmeclipse
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
└── share
    ├── doc
    └── qemu

8 directories, 14 files
```

### Test

To check if the manually installed QEMU starts, use something like:

```console
$ ~/opt/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7/bin/qemu-system-gnuarmeclipse --version
xPack 64-bit QEMU emulator version {{ page.version }}-7 (v{{ page.version }}-4-20190211-47-g109b69f49a-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```

{% endcapture %}

{% capture linux %}
### Download

The GNU/Linux versions of **xPack QEMU Arm** are packed as plain archives.
Download the latest version named like:

- `xpack-qemu-arm-{{ page.version }}-7-linux-x64.tgz`
- `xpack-qemu-arm-{{ page.version }}-7-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit
machines.

### Unpack

To manually install the xPack QEMU Arm,
unpack the archive and move it to
`~/opt/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-qemu-arm-{{ page.version }}-7-linux-x64.tgz
$ chmod -R -w xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to
install QEMU in any folder, it is highly recommended to use this
path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

The result is a structure like:

```console
$ tree -L 2 '/home/ilg/opt/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7'
/home/ilg/opt/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7/
├── bin
│   ├── libglib-2.0.so.0 -> libglib-2.0.so.0.5600.4
│   ├── libglib-2.0.so.0.5600.4
│   ├── libgthread-2.0.so.0 -> libgthread-2.0.so.0.5600.4
│   ├── libgthread-2.0.so.0.5600.4
│   ├── libiconv.so.2 -> libiconv.so.2.6.0
│   ├── libiconv.so.2.6.0
│   ├── libjpeg.so.9 -> libjpeg.so.9.2.0
│   ├── libjpeg.so.9.2.0
│   ├── libpixman-1.so.0 -> libpixman-1.so.0.38.0
│   ├── libpixman-1.so.0.38.0
│   ├── libpng16.so.16 -> libpng16.so.16.36.0
│   ├── libpng16.so.16.36.0
│   ├── libSDL2-2.0.so.0 -> libSDL2-2.0.so.0.9.0
│   ├── libSDL2-2.0.so.0.9.0
│   ├── libSDL2_image-2.0.so.0 -> libSDL2_image-2.0.so.0.2.2
│   ├── libSDL2_image-2.0.so.0.2.2
│   ├── libz.so.1 -> libz.so.1.2.11
│   ├── libz.so.1.2.11
│   └── qemu-system-gnuarmeclipse
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── libexec
├── README.md
└── share
    ├── doc
    └── qemu

9 directories, 21 files
```

### Test

To check if the manually installed QEMU starts, use something like:

```console
$ ~/opt/xPacks/qemu-arm/xpack-qemu-arm-{{ page.version }}-7/bin/qemu-system-gnuarmeclipse --version
xPack 64-bit QEMU emulator version {{ page.version }}-7 (v{{ page.version }}-4-20190211-47-g109b69f49a-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```

#### UDEV & Drivers

For usual Cortex-M emulation, there are no special UDEV definitions or
drivers required.

{% endcapture %}

{% include platform-tabs.html %}
