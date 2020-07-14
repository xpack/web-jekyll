---
title: How to install the xPack Windows Build Tools binaries
permalink: /windows-build-tools/install/

summary: "The recommended method is via xpm."
toc: false
comments: true

date: 2020-07-14 16:26:00 +0300
last_updated: 2020-07-14 16:57:23 +0300

---

## Overview

The **xPack Windows Build Tools** can be installed automatically, via xpm (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

## Easy install

The easiest way to install Windows Build Tools is by using the **binary xPack**, available as
[`@xpack-dev-tools/windows-build-tools`](https://www.npmjs.com/package/@xpack-dev-tools/windows-build-tools)
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
$ xpm install --global @xpack-dev-tools/windows-build-tools@latest
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

{% include important.html content="Automatic
path discovery for the packages from the new `@xpack-dev-tools` scope was
added to **GNU MCU Eclipse plug-ins** with v4.x; update
older versions or configure the path manually." %}

### Uninstall

To remove the installed xPack, the command is similar:

```console
$ xpm uninstall --global @xpack-dev-tools/windows-build-tools
```

(Note: not yet implemented. As a temporary workaround, simply remove the
`xPacks/@xpack-dev-tools/windows-build-tools` folder, or one of the versioned
subfolders.)

## Manual install

For all platforms, the **xPack Windows Build Tools** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
[GitHub Releases](https://github.com/xpack-dev-tools/windows-build-tools-xpack/releases/)
page.

{% capture windows %}
### Download

The Windows versions of **xPack Windows Build Tools** are packed as ZIP files.
Download the latest version named like:

- `xpack-windows-build-tools-2.12.2-win32-x64.zip`
- `xpack-windows-build-tools-2.12.2-win32-x32.zip`

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
install Windows Build Tools in any folder, it is highly recommended to use this
path, since by default the GNU MCU Eclipse debug plug-ins search
for the executable in this location." %}

To check if `make` starts, use the following command:

```
C:\Users\ilg>C:\Users\ilg\AppData\Roaming\xPacks\xpack-windows-build-tools-2.12.2\bin\make --version
GNU Make 4.1
Built for i686-w64-mingw32
Copyright (C) 1988-2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

{% endcapture %}

{% capture macos %}

Not required on macOS, use the system tools.

{% endcapture %}

{% capture linux %}

Not required on GNU/Linux, use the system tools.

{% endcapture %}

{% include platform-tabs.html %}
