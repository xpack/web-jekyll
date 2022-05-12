---
title: How to install the xPack CMake binaries
permalink: /cmake/install/

summary: "The recommended method is via xpm."

toc: false
comments: true

version: 3.19.1

date: 2020-09-29 14:05:00 +0300

---

## Overview

The **xPack CMake** can be installed automatically, via `xpm` (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install CMake is by using the **binary xPack**, available as
[`@xpack-dev-tools/cmake`](https://www.npmjs.com/package/@xpack-dev-tools/cmake)
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
$ xpm install --global @xpack-dev-tools/cmake@latest --verbose
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

### Uninstall

To remove the installed xPack, the command is similar:

```sh
xpm uninstall --global @xpack-dev-tools/cmake --verbose
```

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack CMake** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/cmake-xpack/releases/)
page.

{% endcapture %}

{% capture windows %}

{{ easy_install }}

### Test

To check if the xpm installed CMake starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\@xpack-dev-tools\cmake\{{ page.version }}-1.1\.content\bin\cmake.exe --version
cmake version {{ page.version }}

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

{{ manual_install }}

### Download

The Windows versions of **xPack CMake** are packed as ZIP files.
Download the latest version named like:

- `xpack-cmake-{{ page.version }}-1-win32-x64.zip`
- `xpack-cmake-{{ page.version }}-1-win32-ia32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-ia32` file
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

To manually install the xPack CMake,
unpack the archive and copy it into the
`%USERPROFILE%\AppData\Roaming\xPacks\cmake`
(for example `C:\Users\ilg\AppData\Roaming\xPacks\cmake`) folder;
according to Microsoft, `AppData\Roaming` is the recommended location for
installing user specific packages.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

### Test

To check if the manually installed CMake starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\cmake\xpack-cmake-{{ page.version }}-1\bin\cmake.exe --version
cmake version {{ page.version }}

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

{% endcapture %}

{% capture macos %}

{{ easy_install }}

### Test

To check if the xpm installed CMake starts, use something like:

```console
$ ~/opt/xPacks/@xpack-dev-tools/cmake/{{ page.version }}-1.1/.content/bin/cmake --version
cmake version {{ page.version }}

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

{{ manual_install }}

### Download

The macOS version of **xPack CMake** is packed as a .tar.gz archive.
Download the latest version named like:

- `xpack-cmake-{{ page.version }}-1-darwin-x64.tgz`

### Unpack

To manually install the xPack CMake,
unpack the archive and move it to
`~/opt/xPacks/cmake/xpack-cmake-{{ page.version }}-1`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-cmake-{{ page.version }}-1-darwin-x64.tgz
$ chmod -R -w xPacks/cmake/xpack-cmake-{{ page.version }}-1
```

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/Library/xPacks/cmake/xpack-cmake-{{ page.version }}-1
/Users/ilg/Library/xPacks/cmake/xpack-cmake-{{ page.version }}-1/
├── README.md
├── bin
│   ├── ccmake
│   ├── cmake
│   ├── cpack
│   ├── ctest
│   ├── libgcc_s.1.dylib
│   └── libncurses.6.dylib
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── doc
│   └── cmake-3.18
└── share
    ├── aclocal
    ├── bash-completion
    ├── cmake-3.18
    ├── emacs
    └── vim

13 directories, 8 files
```

### Test

To check if the manually installed CMake starts, use something like:

```console
$ ~/opt/xPacks/cmake/xpack-cmake-{{ page.version }}-1/bin/cmake --version
cmake version {{ page.version }}
```

{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed CMake starts, use something like:

```console
$ ~/opt/xPacks/@xpack-dev-tools/cmake/{{ page.version }}-1.1/.content/bin/cmake --version
cmake version {{ page.version }}

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack CMake** are packed as plain archives.
Download the latest version named like:

- `xpack-cmake-{{ page.version }}-1-linux-x64.tgz`
- `xpack-cmake-{{ page.version }}-1-linux-ia32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.
Select the `-x64` file for 64-bit machines and the `-ia32` file for 32-bit
machines.

### Unpack

To manually install the xPack CMake,
unpack the archive and move it to
`~/opt/xPacks/cmake/xpack-cmake-{{ page.version }}-1`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-cmake-{{ page.version }}-1-linux-x64.tgz
$ chmod -R -w xPacks/cmake/xpack-cmake-{{ page.version }}-1
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

```console
$ tree -L 2 '/home/ilg/opt/xPacks/cmake/xpack-cmake-{{ page.version }}-1'
/home/ilg/opt/xPacks/cmake/xpack-cmake-{{ page.version }}-1/
├── bin
│   ├── ccmake
│   ├── cmake
│   ├── cpack
│   ├── ctest
│   ├── libcrypto.so.1.1
│   ├── libncurses.so.6 -> libncurses.so.6.2
│   ├── libncurses.so.6.2
│   └── libssl.so.1.1
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── doc
│   └── cmake-3.18
├── README.md
└── share
    ├── aclocal
    ├── bash-completion
    ├── cmake-3.18
    ├── emacs
    └── vim

13 directories, 10 files
```

### Test

To check if the manually installed CMake starts, use something like:

```console
$ ~/opt/xPacks/cmake/xpack-cmake-{{ page.version }}-1/bin/cmake --version
cmake version {{ page.version }}

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

{% endcapture %}

{% include platform-tabs.html %}
