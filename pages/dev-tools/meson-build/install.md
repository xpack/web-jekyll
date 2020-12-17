---
title: How to install the xPack Meson Build binaries
permalink: /meson-build/install/

summary: "The recommended method is via xpm."

toc: false
comments: true

date: 2020-09-27 11:09:00 +0300

---

## Overview

The **xPack Meson Build** can be installed automatically, via xpm (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

## Easy install

The easiest way to install Meson is by using the **binary xPack**, available as
[`@xpack-dev-tools/meson-build`](https://www.npmjs.com/package/@xpack-dev-tools/meson-build)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent
xpm, which is a portable
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

### Install

With xpm available, installing
the latest version of the package is quite easy:

```console
$ xpm install --global @xpack-dev-tools/meson-build@latest
```

This command will always install the latest available version,
in the central xPacks repository, which is a platform dependent folder
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

### Uninstall

To remove the installed xPack, the command is similar:

```console
$ xpm uninstall --global @xpack-dev-tools/meson-build
```

(Note: not yet implemented. As a temporary workaround, simply remove the
`xPacks/@xpack-dev-tools/meson-build` folder, or one of the versioned
subfolders.)

## Manual install

For all platforms, the **xPack Meson Build** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/meson-build-xpack/releases/)
page.

{% capture windows %}
### Download

The Windows versions of **xPack Meson Build** are packed as ZIP files.
Download the latest version named like:

- `xpack-meson-build-0.55.3-1-win32-x64.zip`
- `xpack-meson-build-0.55.3-1-win32-x32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-x32` file
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

Unpack the archive and copy it into the
`%userprofile%\AppData\Roaming\xPacks\meson-build`
(for example `C:\Users\ilg\AppData\Roaming\xPacks\meson-build`) folder;
according to Microsoft, `AppData\Roaming` is the recommended location for
installing user specific packages.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

To check if Meson starts, use the following command:

```
C:\Users\ilg>C:\Users\ilg\AppData\Roaming\xPacks\meson-build\xpack-meson-0.55.3-1\bin\meson.exe --version
0.55.3
```

{% endcapture %}

{% capture macos %}
### Download

The macOS version of **xPack Meson Build** is packed as a .tar.gz archive.
Download the latest version named like:

- `xpack-meson-build-0.55.3-1-darwin-x64.tgz`

### Unpack

To install Meson, unpack the archive and copy it to
`/${HOME}/opt/xPacks/meson-build/xpack-meson-build-0.55.3-1`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-meson-build-0.55.3-1-darwin-x64.tgz
$ chmod -R -w xPacks/meson-build/xpack-meson-build-0.55.3-1
```

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/Library/xPacks/meson-build/xpack-meson-build-0.55.3-1
/Users/ilg/Library/xPacks/meson-build/xpack-meson-build-0.55.3-1/
├── README.md
├── bin
│   ├── libcrypt.2.dylib
│   ├── libgcc_s.1.dylib
│   ├── libpython3.8.dylib
│   └── meson
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
└── lib
    └── python3.8

7 directories, 6 files
```

To check if Meson starts, use:

```console
$ ~/opt/xPacks/meson-build/xpack-meson-build-0.55.3-1/bin/meson --version
0.5.3
```

{% endcapture %}

{% capture linux %}
### Download

The GNU/Linux versions of **xPack Meson Build** are packed as plain archives.
Download the latest version named like:

- `xpack-meson-build-0.55.3-1-linux-x64.tgz`
- `xpack-meson-build-0.55.3-1-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
CentOS, but can be executed on most recent GNU/Linux distributions.
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit
machines.

### Unpack

To install Meson, unpack the archive and move it to
`/${HOME}/opt/xPacks/meson-build/xpack-meson-build-0.55.3-1`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-meson-build-0.55.3-1-linux-x64.tgz
$ chmod -R -w xPacks/meson-build/xpack-meson-build-0.55.3-1
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

```console
$ tree -L 2 '/home/ilg/opt/xPacks/meson-build/xpack-meson-build-0.55.3-1'
/home/ilg/opt/xPacks/meson-build/xpack-meson-build-0.55.3-1/
├── bin
│   └── meson
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── lib
│   └── python3.8
└── README.md

7 directories, 3 files
```

To check if Meson starts and is recent, use:

```console
$ ~/opt/xPacks/meson-build/xpack-meson-build-0.55.3-1/bin/meson --version
0.55.3
```

{% endcapture %}

{% include platform-tabs.html %}

## Testing

TODO
