---
title: How to install the xPack GNU Compiler Collection binaries
permalink: /gcc/install/

summary: "The recommended method is via xpm."

toc: false
comments: true

version: 8.5.0

date: 2021-05-22 00:27:00 +0300

---

## Overview

The **xPack GNU Compiler Collection** can be installed automatically,
via `xpm` (the recommended method), or manually,
by downloading and unpacking one of the portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install the xPack GNU Compiler Collection is by using the
**binary xPack**, available as
[`@xpack-dev-tools/gcc`](https://www.npmjs.com/package/@xpack-dev-tools/gcc)
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

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/gcc@latest
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

### Update

For the moment, to update the package, try to install the latest release again,
as shown before. If there is a new release, it will be installed,
otherwise a message will warn that the package is already installed.

Future versions of xpm will implement the `outdated` and `update` commands,
as npm does.

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/gcc
```

To completely remove the package from the global store:

```sh
xpm uninstall --global @xpack-dev-tools/gcc
```

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack GNU Compiler Collection** binaries are
released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/gcc-xpack/releases/) pages.
{% endcapture %}

{% capture windows %}

{{ easy_install }}

### Test

To check if the xpm installed GCC starts, use something like:

```doscon
C:\>%USERPROFILE%\AppData\Roaming\xPacks\@xpack-dev-tool\gcc\{{ page.version }}-1.1\.content\bin\gcc.exe" --version
gcc version {{ page.version }} (xPack GCC 64-bit)
```

{{ manual_install }}

### Download

The Windows versions of **xPack GNU Compiler Collection** are packed as ZIP files.
Download the latest version named like:

- `xpack-gcc-{{ page.version }}-1-win32-x64.zip`
- `xpack-gcc-{{ page.version }}-1-win32-ia32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-ia32` file
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

To manually install the xPack GNU Compiler Collection,
unpack the archive and copy the versioned folder into the
`%USERPROFILE%\AppData\Roaming\xPacks\gcc`
(for example `C:\Users\ilg\AppData\Roaming\xPacks\gcc`) folder;
according to Microsoft, `AppData\Roaming` is the recommended location for
installing user specific packages.

You may shorten the last folder name and keep only the version.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

### Test

To check if the manually installed GCC starts, use something like:

```doscon
C:\>%USERPROFILE%\AppData\Roaming\xPacks\gcc\xpack-gcc-{{ page.version }}-1\bin\gcc.exe" --version
gcc version {{ page.version }} (xPack GCC 64-bit)
```

{% endcapture %}

{% capture macos %}

{{ easy_install }}

### Test

To check if the xpm installed GCC starts, use something like:

```console
$ ~/Library/xPacks/@xpack-dev-tools/gcc/{{ page.version }}-1.1/.content/bin/gcc --version
gcc version {{ page.version }} (xPack GCC 64-bit)
```

{{ manual_install }}

### Download

The macOS version of **xPack GNU Compiler Collection** is packed as a
`.tar.gz` archive.
Download the latest version named like:

- `xpack-gcc-{{ page.version }}-1-darwin-x64.tar.gz`

### Unpack

To manually install the xPack GNU Compiler Collection,
unpack the archive and copy it to
`~/.local/xPacks/gcc/xpack-gcc-<version>`:

```sh
mkdir -p ~/.local/xPacks/gcc
cd ~/.local/xPacks/gcc

tar xvf ~/Downloads/xpack-gcc-{{ page.version }}-1-darwin-x64.tar.gz
chmod -R -w xpack-gcc-{{ page.version }}-1
```

You may shorten the last folder name and keep only the version.

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/Library/xPacks/gcc/xpack-gcc-{{ page.version }}-1
/Users/ilg/Library/xPacks/gcc/xpack-gcc-{{ page.version }}-1
├── README.md

TODO
```

### Test

To check if the manually installed GCC starts, use something like:

```console
$ ~/.local/xPacks/gcc/xpack-gcc-{{ page.version }}-1.1/bin/gcc --version
gcc version {{ page.version }} (xPack GCC 64-bit)
```

{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed GCC starts, use something like:

```console
$ ~/.local/xPacks/@xpack-dev-tools/gcc/{{ page.version }}-1.1/.content/bin/gcc --version
gcc version {{ page.version }} (xPack GCC 64-bit)
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack GNU Compiler Collection** are packed as
`.tar.gz` archives. Download the latest version named like:

- `xpack-gcc-{{ page.version }}-1-linux-x64.tar.gz`
- `xpack-gcc-{{ page.version }}-1-linux-ia32.tar.gz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.
Select the `-x64` file for 64-bit machines and the `-ia32` file for 32-bit
machines.

### Unpack

To manually install the xPack GNU Compiler Collection,
unpack the archive and copy it to
`${HOME}/.local/xPacks/gcc/xpack-gcc-<version>`:

```sh
mkdir -p ~/.local/xPacks/gcc
cd ~/.local/xPacks/gcc

tar xvf ~/Downloads/xpack-gcc-{{ page.version }}-1-linux-x64.tar.gz
chmod -R -w xpack-gcc-{{ page.version }}-1
```

You may shorten the last folder name and keep only the version.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

The result is a structure like:

```console
$ tree -L 2 /home/ilg/.local/xPacks/gcc/xpack-gcc-{{ page.version }}-1
/home/ilg/opt/xPacks/gcc/xpack-gcc-{{ page.version }}-1

TODO
```

### Test

To check if the manually installed GCC starts, use something like:

```console
$ ~/.local/xPacks/gcc/xpack-gcc-{{ page.version }}-1/bin/gcc --version
gcc version {{ page.version }} (xPack GCC 64-bit)
```

{% endcapture %}

{% include platform-tabs.html %}

{% include warning.html content="**DO NOT** add the path to
the user or system path!" %}
