---
title: How to install the xPack GNU RISC-V Embedded GCC binaries
permalink: /riscv-none-embed-gcc/install/

summary: "The recommended method is via xpm."

toc: false
comments: true

version: 8.2.1

date: 2019-07-10 17:53:00 +0300

---

## Overview

The **xPack GNU RISC-V Embedded GCC** can be installed automatically, via **xpm** (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install GNU RISC-V Embedded GCC is by using the
**binary xPack**, available as
[`@xpack-dev-tools/riscv-none-embed-gcc`](https://www.npmjs.com/package/@xpack-dev-tools/riscv-none-embed-gcc)
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
$ xpm install --global @xpack-dev-tools/riscv-none-embed-gcc@latest
```

This command will always install the latest available version,
in the central xPacks repository, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

The archive content is unpacked in a folder named `.content`. On some platforms
this might be hidden for normal browsing, and require
separate options (like `ls -A`) or, in file browsers, to enable
configurations like **Show Hidden Files**.

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

```console
$ xpm uninstall --global @xpack-dev-tools/riscv-none-embed-gcc
```

{% include note.html content="Not yet implemented. As a temporary workaround,
simply remove the `xPacks/@xpack-dev-tools/riscv-none-embed-gcc` folder,
or one of the versioned subfolders." %}

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack GNU RISC-V Embedded GCC** binaries are
released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/) page.

{% endcapture %}

{% capture windows %}

{{ easy_install }}

### Test

To check if the xpm installed GCC starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\@xpack-dev-tools\riscv-none-embed-gcc\{{ page.version }}-3.1.1\.content\bin\riscv-none-embed-gcc.exe" --version
riscv-none-embed-gcc (xPack GNU RISC-V Embedded GCC, 64-bit) {{ page.version }}
```

{{ manual_install }}

### Download

The Windows versions of **xPack GNU RISC-V Embedded GCC** are packed as ZIP files.
Download the latest version named like:

- `xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-win32-x64.zip`
- `xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-win32-x32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-x32` file
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

Unpack the archive and copy it into the
`%USERPROFILE%\AppData\Roaming\xPacks\riscv-none-embed-gcc`
(for example `C:\Users\ilg\AppData\Roaming\xPacks\riscv-none-embed-gcc`) folder;
according to Microsoft, `AppData\Roaming` is the recommended location for
installing user specific packages.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to
install GNU RISC-V Embedded GCC in any folder, it is highly recommended
to use this path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

### Test

To check if the manually installed GCC starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\riscv-none-embed-gcc\xpack-riscv-none-embed-gcc-{{ page.version }}-3.1\bin\riscv-none-embed-gcc.exe" --version
riscv-none-embed-gcc (xPack GNU RISC-V Embedded GCC, 64-bit) {{ page.version }}
```

{% include tip.html content="Since Windows does not provide the GNU make
binaries, it is recommended to also install the **Windows Build Tools**." %}

{% endcapture %}

{% capture macos %}

{{ easy_install }}

### Test

To check if the xpm installed GCC starts, use something like:

```console
$ ~/opt/xPacks/@xpack-dev-tools/riscv-none-embed-gcc/{{ page.version }}-3.1.1/.content/bin/riscv-none-embed-gcc --version
riscv-none-embed-gcc (xPack GNU RISC-V Embedded GCC, 64-bit) {{ page.version }}
```

{{ manual_install }}

### Download

The macOS version of **xPack GNU RISC-V Embedded GCC** is packed as a .tar.gz archive.
Download the latest version named like:

- `xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-darwin-x64.tgz`

### Unpack

To install GNU RISC-V Embedded GCC, unpack the archive and copy it to
`/${HOME}/opt/xPacks/riscv-none-embed-gcc/<version>`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-darwin-x64.tgz
$ chmod -R -w xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1
```

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

{% include important.html content="Although perfectly possible to
install GNU RISC-V Embedded GCC in any folder, it is highly recommended
to use this path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1
/Users/ilg/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1/
├── README.md
├── bin
│   ├── libexpat.1.6.7.dylib
│   ├── libexpat.1.dylib -> libexpat.1.6.7.dylib
│   ├── libgcc_s.1.dylib
│   ├── libgmp.10.dylib
│   ├── libiconv.2.dylib
│   ├── liblzma.5.dylib
│   ├── libmpfr.4.dylib
│   ├── libz.1.2.8.dylib
│   ├── libz.1.dylib -> libz.1.2.8.dylib
│   ├── riscv-none-embed-addr2line
│   ├── riscv-none-embed-ar
│   ├── riscv-none-embed-as
│   ├── riscv-none-embed-c++
│   ├── riscv-none-embed-c++filt
│   ├── riscv-none-embed-cpp
│   ├── riscv-none-embed-elfedit
│   ├── riscv-none-embed-g++
│   ├── riscv-none-embed-gcc
│   ├── riscv-none-embed-gcc-{{ page.version }}
│   ├── riscv-none-embed-gcc-ar
│   ├── riscv-none-embed-gcc-nm
│   ├── riscv-none-embed-gcc-ranlib
│   ├── riscv-none-embed-gcov
│   ├── riscv-none-embed-gcov-dump
│   ├── riscv-none-embed-gcov-tool
│   ├── riscv-none-embed-gdb
│   ├── riscv-none-embed-gdb-add-index
│   ├── riscv-none-embed-gdb-add-index-py
│   ├── riscv-none-embed-gdb-py
│   ├── riscv-none-embed-gprof
│   ├── riscv-none-embed-ld
│   ├── riscv-none-embed-ld.bfd
│   ├── riscv-none-embed-nm
│   ├── riscv-none-embed-objcopy
│   ├── riscv-none-embed-objdump
│   ├── riscv-none-embed-ranlib
│   ├── riscv-none-embed-readelf
│   ├── riscv-none-embed-size
│   ├── riscv-none-embed-strings
│   └── riscv-none-embed-strip
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── include
│   └── gdb
├── lib
│   ├── bfd-plugins
│   ├── gcc
│   ├── libcc1.0.so
│   └── libcc1.so -> libcc1.0.so
├── libexec
│   └── gcc
├── riscv-none-embed
│   ├── bin
│   ├── include
│   ├── lib
│   └── share
└── share
    ├── doc
    └── gcc-riscv-none-embed

20 directories, 44 files
```

### Test

To check if the manually installed GCC starts, use something like:

```console
$ ~/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1/bin/riscv-none-embed-gcc --version
riscv-none-embed-gcc (xPack GNU RISC-V Embedded GCC, 64-bit) {{ page.version }}
```

{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed GCC starts, use something like:

```console
$ ~/opt/xPacks/@xpack-dev-tools/riscv-none-embed-gcc/{{ page.version }}-3.1.1/.content/bin/riscv-none-embed-gcc --version
riscv-none-embed-gcc (xPack GNU RISC-V Embedded GCC, 64-bit) {{ page.version }}
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack GNU RISC-V Embedded GCC** are packed as
.tar.gz archives. Download the latest version named like:

- `xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-linux-x64.tgz`
- `xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
CentOS, but can be executed on most recent GNU/Linux distributions.
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit
machines.

### Unpack

To install GNU RISC-V Embedded GCC, unpack the archive and move it to
`/${HOME}/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1-linux-x64.tgz
$ chmod -R -w xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to
install GNU RISC-V Embedded GCC in any folder, it is highly recommended
to use this path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

The result is a structure like:

```console
$ tree -L 2 /home/ilg/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1/
/home/ilg/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1/
├── bin
│   ├── libexpat.so.1 -> libexpat.so.1.6.7
│   ├── libexpat.so.1.6.7
│   ├── libfl.so.2 -> libfl.so.2.0.0
│   ├── libfl.so.2.0.0
│   ├── libgmp.so.10 -> libgmp.so.10.3.2
│   ├── libgmp.so.10.3.2
│   ├── libiconv.so.2 -> libiconv.so.2.6.0
│   ├── libiconv.so.2.6.0
│   ├── liblzma.so.5 -> liblzma.so.5.2.3
│   ├── liblzma.so.5.2.3
│   ├── libmpfr.so.4 -> libmpfr.so.4.1.6
│   ├── libmpfr.so.4.1.6
│   ├── libpython2.7.so.1.0
│   ├── libz.so.1 -> libz.so.1.2.8
│   ├── libz.so.1.2.8
│   ├── riscv-none-embed-addr2line
│   ├── riscv-none-embed-ar
│   ├── riscv-none-embed-as
│   ├── riscv-none-embed-c++
│   ├── riscv-none-embed-c++filt
│   ├── riscv-none-embed-cpp
│   ├── riscv-none-embed-elfedit
│   ├── riscv-none-embed-g++
│   ├── riscv-none-embed-gcc
│   ├── riscv-none-embed-gcc-{{ page.version }}
│   ├── riscv-none-embed-gcc-ar
│   ├── riscv-none-embed-gcc-nm
│   ├── riscv-none-embed-gcc-ranlib
│   ├── riscv-none-embed-gcov
│   ├── riscv-none-embed-gcov-dump
│   ├── riscv-none-embed-gcov-tool
│   ├── riscv-none-embed-gdb
│   ├── riscv-none-embed-gdb-add-index
│   ├── riscv-none-embed-gdb-add-index-py
│   ├── riscv-none-embed-gdb-py
│   ├── riscv-none-embed-gprof
│   ├── riscv-none-embed-ld
│   ├── riscv-none-embed-ld.bfd
│   ├── riscv-none-embed-nm
│   ├── riscv-none-embed-objcopy
│   ├── riscv-none-embed-objdump
│   ├── riscv-none-embed-ranlib
│   ├── riscv-none-embed-readelf
│   ├── riscv-none-embed-size
│   ├── riscv-none-embed-strings
│   └── riscv-none-embed-strip
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── include
│   └── gdb
├── lib
│   ├── bfd-plugins
│   └── gcc
├── lib64
│   ├── libcc1.so -> libcc1.so.0.0.0
│   ├── libcc1.so.0 -> libcc1.so.0.0.0
│   ├── libcc1.so.0.0.0
│   ├── libgcc_s.so.1
│   ├── libstdc++.so.6 -> libstdc++.so.6.0.24
│   └── libstdc++.so.6.0.24
├── libexec
│   └── gcc
├── README.md
├── riscv-none-embed
│   ├── bin
│   ├── include
│   ├── lib
│   └── share
└── share
    ├── doc
    └── gcc-riscv-none-embed

21 directories, 54 files
```

### Test

To check if the manually installed GCC starts, use something like:

```console
$ ~/opt/xPacks/riscv-none-embed-gcc/xpack-riscv-none-embed-gcc-{{ page.version }}-3.1/bin/riscv-none-embed-gcc --version
riscv-none-embed-gcc (xPack GNU RISC-V Embedded GCC, 64-bit) {{ page.version }}
```

{% endcapture %}

{% include platform-tabs.html %}

{% include warning.html content="**DO NOT** add the toolchain path to
the user or system path!" %}
