---
title: How to install the xPack GNU ARM Embedded GCC binaries?
permalink: /arm-none-eabi-gcc/install/

summary: "The recommended method is via xpm."
toc: false
comments: true

date: 2019-07-10 17:53:00 +0300
last_updated: 2019-07-15 11:35:15 +0300

---

## Overview

The **xPack GNU ARM Embedded GCC** can be installed automatically, via xpm (the
recommended method), or manually, by downloading and unpacking one of the 
portable archives.

## Easy install 

The easiest way to install GNU ARM Embedded GCC is by using the 
**binary xPack**, available as 
[`@xpack-dev-tools/arm-none-eabi-gcc`](https://www.npmjs.com/package/@xpack-dev-tools/arm-none-eabi-gcc)
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
$ xpm install --global @xpack-dev-tools/arm-none-eabi-gcc@latest
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
xpm and provide a convenient method to manage paths.

### Uninstall

To remove the installed xPack, the command is similar:

```console
$ xpm uninstall --global @xpack-dev-tools/arm-none-eabi-gcc
```

(Note: not yet implemented. As a temporary workaround, simply remove the 
`xPacks/@xpack-dev-tools/arm-none-eabi-gcc` folder, or one of the versioned 
subfolders.)

## Manual install

For all platforms, the **xPack GNU ARM Embedded GCC** binaries are 
released as portable 
archives that can be installed in any location.

The archives can be downloaded from the
[GitHub Releases](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/) page.

{% capture windows %}
### Download

The Windows versions of **xPack GNU ARM Embedded GCC** are packed as ZIP files. 
Download the latest version named like:

- `xpack-arm-none-eabi-gcc-8.2.1-1.8-win32-x64.zip`
- `xpack-arm-none-eabi-gcc-8.2.1-1.8-win32-x32.zip`

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
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to 
install GNU ARM Embedded GCC in any folder, it is highly recommended 
to use this path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

To check if GCC starts, use the following command:

```
C:\Users\ilg>C:\Users\ilg\AppData\Roaming\xPacks\GNU ARM Embedded GCC\8.2.1-1.8\bin\arm-none-eabi-gcc.exe" --version
arm-none-eabi-gcc (xPack GNU ARM Embedded GCC, 64-bit) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]
```

{% include tip.html content="Since Windows does not provide the GNU make
binaries, it is recommended to also install the **Windows Build Tools**." %}

{% endcapture %}

{% capture macos %}
### Download

The macOS version of **xPack GNU ARM Embedded GCC** is packed as a TGZ archive. 
Download the latest version named like:

-  `xpack-arm-none-eabi-gcc-8.2.1-1.8-darwin-x64.tgz`

### Unpack

To install GNU ARM Embedded GCC, unpack the archive and copy it to 
`/${HOME}/opt/xPacks/arm-none-eabi-gcc/`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-arm-none-eabi-gcc-8.2.1-1.8-darwin-x64.tgz
$ chmod -R -w xPacks/arm-none-eabi-gcc/8.2.1-1.8
```

{% include note.html content="For manual installs, the recommended 
install location is different from the xpm install folders." %}

{% include important.html content="Although perfectly possible to 
install GNU ARM Embedded GCC in any folder, it is highly recommended 
to use this path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

TODO: add result of `tree`.

To check if GCC starts, use:

```console
$ ~/opt/xPacks/arm-none-eabi-gcc/8.2.1-1.8/bin/arm-none-eabi-gcc --version
arm-none-eabi-gcc (xPack GNU ARM Embedded GCC, 64-bit) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]
```

{% endcapture %}

{% capture linux %}
### Download

The GNU/Linux versions of **xPack GNU ARM Embedded GCC** are packed as 
TGZ archives. Download the latest version named like:

- `xpack-arm-none-eabi-gcc-8.2.1-1.8-linux-x64.tgz`
- `xpack-arm-none-eabi-gcc-8.2.1-1.8-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
CentOS, but can be executed on most recent GNU/Linux distributions. 
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit 
machines.

### Unpack

To install GNU ARM Embedded GCC, unpack the archive and copy it to 
`/${HOME}/opt/xPacks/arm-none-eabi-gcc/${version}`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-arm-none-eabi-gcc-8.2.1-1.8-linux-x64.tgz
$ chmod -R -w xPacks/arm-none-eabi-gcc/8.2.1-1.8
```

{% include note.html content="For manual installs, the recommended 
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to 
install GNU ARM Embedded GCC in any folder, it is highly recommended 
to use this path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

TODO: add result of `tree`.

To check if GCC starts and is recent, use:

```console
$ ~/opt/xPacks/arm-none-eabi-gcc/8.2.1-1.8/bin/arm-none-eabi-gcc --version
arm-none-eabi-gcc (xPack GNU ARM Embedded GCC, 64-bit) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]
```

{% endcapture %}

{% include platform-tabs.html %}

{% include warning.html content="**DO NOT** add the toolchain path to 
the user or system path!" %}
