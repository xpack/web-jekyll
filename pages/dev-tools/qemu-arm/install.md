---
title: How to install the xPack QEMU ARM binaries?
permalink: /qemu-arm/install/

summary: "The recommended method is via xpm."
toc: false
comments: true

date: 2015-09-04 17:03:00 +0300
last_updated: 2019-07-02 23:14:07 +0300

---

## Overview

The **xPack QEMU ARM** can be installed automatically, via `xpm` (the
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

With `xpm` available, installing 
the latest version of the package is quite easy:

```console
$ xpm install --global @xpack-dev-tools/qemu
```

This command will always install the latest available version, 
in the central xPacks repository, which is a platform dependent folder 
(check the output of the `xpm` command or the actual folder used on 
your platform).

{% capture include_1 %}
The install location can be configured using the 
`XPACKS_REPO_FOLDER` environment variable; for more details please check the 
[xpm folders]({{ site.baseurl }}/xpm/folders/) page.
{% endcapture %}

{% include tip.html content=include_1 %}

xPacks aware tools, like the **GNU MCU Eclipse plug-ins** automatically 
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

### Uninstall

To remove the installed xPack, the command is similar:

```console
$ xpm uninstall --global @xpack-dev-tools/qemu
```

(Note: not yet implemented. As a temporary workaround, simply remove the 
`xPacks/@xpack-dev-tools/qemu` folder, or one of the versioned 
subfolders.)

## Manual install

For all platforms, the **xPack QEMU ARM** binaries are released as portable 
archives that can be installed in any location.

The archives can be downloaded from the GitHub 
[Releases](https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/) page.

{% capture windows %}
### Download

The Windows versions of **xPack QEMU ARM** are packed as ZIP files. 
Download the latest version named like:

- `xpack-qemu-arm-2.8.0-4-win32-x64.zip`
- `xpack-qemu-arm-2.8.0-4-win32-x32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-x32` file 
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes 
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

Unpack the archive and copy it into the `%userprofile%\AppData\Roaming\xPacks` 
(for example `C:\Users\ilg\AppData\Roaming\xPacks`) folder; according 
to Microsoft, this is the recommended location for installing user specific 
packages.

{% include note.html content="For manual installs, the recommended 
install location is slightly different from the `xpm` install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to 
install QEMU in any folder, it is highly recommended to use this 
path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

The result is a structure like:

![The QEMU folders structure]({{ site.baseurl }}/assets/images/2019/windows-folders-qemu.png)

To check if QEMU starts, use the following command:

```
C:\Users\ilg>C:\Users\ilg\AppData\Roaming\xPacks\QEMU\2.8.0-4\bin\qemu-system-gnuarmeclipse.exe" --version
xPack 64-bit QEMU emulator version 2.8.0-4 (v2.8.0-3-20180523-6-gee07085299-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```

#### Drivers

For usual Cortex-M emulation, there are no special drivers required.

{% endcapture %}

{% capture macos %}
### Download

The macOS version of **xPack QEMU ARM** is packed as a TGZ archive. 
Download the latest version named like:

-  `xpack-qemu-arm-2.8.0-4-darwin-x64.tgz`

### Unpack

To install QEMU, unpack the archive and copy it to 
`/${HOME}/opt/xPacks/qemu-arm/`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-qemu-arm-2.8.0-4-darwin-x64.tgz
$ chmod -R -w xPacks/qemu-arm/2.8.0-4
```

{% include note.html content="For manual installs, the recommended 
install location is different from the `xpm` install folders." %}

{% include important.html content="Although perfectly possible to 
install QEMU in any folder, it is highly recommended to use this 
path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

To check if QEMU starts, use:

```console
$ ~/opt/xPacks/qemu-arm/2.8.0-4/bin/qemu-system-gnuarmeclipse --version
xPacks 64-bit QEMU ARM emulator version 2.8.0-4 (v2.8.0-3-20180523-6-gee07085299-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```

{% endcapture %}

{% capture linux %}
### Download

The GNU/Linux versions of **xPack QEMU ARM** are packed as TGZ archives. 
Download the latest version named like:

- `xpack-qemu-arm-2.8.0-4-linux-x64.tgz`
- `xpack-qemu-arm-2.8.0-4-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
CentOS, but can be executed on most recent GNU/Linux distributions. 
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit 
machines.

### Unpack

To install QEMU, unpack the archive and copy it to 
`/${HOME}/opt/xPacks/qemu-arm/${version}`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-qemu-arm-2.8.0-4-linux-x64.tgz
$ chmod -R -w xPacks/qemu-arm/2.8.0-4
```

{% include note.html content="For manual installs, the recommended 
install location is slightly different from the `xpm` install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to 
install QEMU in any folder, it is highly recommended to use this 
path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

To check if QEMU starts and is recent, use:

```console
$ ~/opt/xPacks/qemu-arm/2.8.0-4/bin/qemu-system-gnuarmeclipse --version
xPacks 64-bit QEMU emulator version 2.8.0-4 (v2.8.0-3-20180523-6-gee07085299-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```

#### UDEV & Drivers

For usual Cortex-M emulation, there are no special UDEV definitions or 
drivers required.

{% endcapture %}

{% include platform-tabs.html %}

