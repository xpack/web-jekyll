---
title: How to install the xPack GNU sed binaries
permalink: /dev-tools/sed/install/

summary: "The recommended method is via xpm."

version: "4.9.0"
xpack-subversion: "2"
short-version: "4.9"

comments: true
toc: false

date: 2022-10-04 10:32:00 +0300

---

## Overview

The **xPack GNU sed** can be installed automatically, via `xpm` (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install GNU sed is by using the **binary xPack**, available as
[`@xpack-dev-tools/sed`](https://www.npmjs.com/package/@xpack-dev-tools/sed)
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

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/sed@latest --verbose
```

This command will always install the latest available version,
in the global xPacks store, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

{% capture include_1 %}
The install location can be configured using the
`XPACKS_STORE_FOLDER` environment variable; for more details please check the
[xpm folders]({{ site.baseurl }}/xpm/folders/) page.
{% endcapture %}

{% include tip.html content=include_1 %}

{% include tip.html content="The archive content is unpacked into a folder
named `.content`. On some platforms
this might be hidden for normal browsing, and require
separate options (like `ls -A`) or, in file browsers, to enable
settings like **Show Hidden Files**." %}

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/sed
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/sed --verbose
```

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack GNU sed** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/sed-xpack/releases/)
page.

{% endcapture %}

{% capture windows %}

Binaries are available only for GNU/Linux and macOS.

{% endcapture %}

{% capture macos %}

{{ easy_install }}

### Test

To check if the xpm installed GNU sed starts, use something like:

```console
$ ~/Library/xPacks/@xpack-dev-tools/sed/{{ page.version }}-{{ page.xpack-subversion }}.1/.content/bin/sed --version
sed (GNU sed) {{ page.short-version }}
```

{{ manual_install }}

### Download

The macOS versions of **xPack GNU sed**
are packed as `.tar.gz` archives.
Download the latest version named like:

- `xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}-darwin-x64.tar.gz`
- `xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}-darwin-arm64.tar.gz`

### Unpack

To manually install the xPack GNU sed,
unpack the archive and move it to
`~/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}`:

```sh
mkdir -p ~/.local/xPacks/sed
cd ~/.local/xPacks/sed

tar xvf ~/Downloads/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}-darwin-x64.tar.gz
chmod -R -w xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}
```

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}
/Users/ilg/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}/
├── README.md
├── bin
│   ├── gsed -> sed
│   └── sed
└── distro-info
    ├── CHANGELOG.md
    ├── licenses
    └── scripts

4 directories, 4 files
```

### Test

To check if the manually installed GNU sed starts, use something like:

```console
$ ~/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}/bin/sed --version
sed (GNU sed) {{ page.short-version }}
```

{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed GNU sed starts, use something like:

```console
$ ~/.local/xPacks/@xpack-dev-tools/sed/{{ page.version }}-{{ page.xpack-subversion }}.1/.content/bin/sed --version
sed (GNU sed) {{ page.short-version }}
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack GNU sed**
are packed as `.tar.gz` archives.
Download the latest version named like:

- `xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}-linux-x64.tar.gz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.

### Unpack

To manually install the xPack GNU sed,
unpack the archive and move it to
`~/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}`:

```console
mkdir -p ~/.local/xPacks/sed
cd ~/.local/xPacks/sed

tar xvf ~/Downloads/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}-linux-x64.tar.gz
chmod -R -w xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

```console
$ tree -L 2 '/home/ilg/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}'
/home/ilg/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}/
├── README.md
├── bin
│   ├── gsed -> sed
│   └── sed
└── distro-info
    ├── CHANGELOG.md
    ├── licenses
    └── scripts

4 directories, 4 files
```

### Test

To check if the manually installed GNU sed starts, use something like:

```console
$ ~/.local/xPacks/sed/xpack-sed-{{ page.version }}-{{ page.xpack-subversion }}/bin/sed --version
sed (GNU sed) {{ page.short-version }}
```

{% endcapture %}

{% include platform-tabs.html %}
