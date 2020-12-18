---
title: How to install the xPack OpenOCD binaries
permalink: /openocd/install/

summary: "The recommended method is via xpm."

toc: false
comments: true

version: 0.10.0

date: 2015-09-09 19:43:00 +0300

---

## Overview

The **xPack OpenOCD** can be installed automatically, via **xpm** (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install OpenOCD is by using the **binary xPack**, available as
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
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
$ xpm install --global @xpack-dev-tools/openocd@latest
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
$ xpm uninstall --global @xpack-dev-tools/openocd
```

{% include note.html content="Not yet implemented. As a temporary workaround,
simply remove the `xPacks/@xpack-dev-tools/openocd` folder,
or one of the versioned subfolders." %}

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack OpenOCD** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
page.

{% endcapture %}

{% capture windows %}

{{ easy_install }}

### Test

To check if the xpm installed OpenOCD starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\@xpack-dev-tools\openocd\{{ page.version }}-13\.content\bin\openocd.exe --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```

{{ manual_install }}

### Download

The Windows versions of **xPack OpenOCD** are packed as ZIP files.
Download the latest version named like:

- `xpack-openocd-{{ page.version }}-13-win32-x64.zip`
- `xpack-openocd-{{ page.version }}-13-win32-x32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-x32` file
for 32-bit Windows machines.

{% include note.html content="In case you wonder where the suffix comes
from, it is exactly the Node.js `process.platform` and `process.arch`.
The `win32` part is confusing, but we have to leave with it." %}

### Unpack

Unpack the archive and copy it into the
`%USERPROFILE%\AppData\Roaming\xPacks\openocd`
(for example `C:\Users\ilg\AppData\Roaming\xPacks\openocd`) folder;
according to Microsoft, `AppData\Roaming` is the recommended location for
installing user specific packages.

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to
install OpenOCD in any folder, it is highly recommended to use this
path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

The result is a structure like:

![The OpenOCD folders structure]({{ site.baseurl }}/assets/images/2019/windows-folders-openocd.png)

### Test

To check if the manually installed OpenOCD starts, use something like:

```
C:\>%USERPROFILE%\AppData\Roaming\xPacks\openocd\xpack-openocd-{{ page.version }}-13\bin\openocd.exe --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```

### Drivers

As usual on Windows, mastering drivers is a challenge and OpenOCD is no
exceptions, so don't be surprised to encounter many incompatible drivers
for various JTAG probes.

### Zadig

The OpenOCD distribution includes some libusb
drivers, and recommends to run the [`zadig.exe`](https://zadig.akeo.ie) tool to activate them.

For example
[ARM-USB-OCD](https://www.olimex.com/Products/ARM/JTAG/) from
[Olimex](https://www.olimex.com/), after installing the vendor drivers,
asks to install Zadig and convert the vendor drivers to WinUSB drivers.

{% include warning.html content="Although converting the vendor drivers
to WinUSB drivers will make OpenOCD happy, please be aware that other
tools using the original drivers will no longer work while Zadig is
active, and to make them work you need to uninstall the Zadig driver
for the device and reinstall the vendor driver (see
[Zadig FAQ](https://github.com/pbatard/libwdi/wiki/FAQ#Help_Zadig_replaced_the_driver_for_the_wrong_device_How_do_I_restore_it)).
Our
recommendation is to use Zadig only as a last resort solution, and, when
possible, prefer the manufacturer drivers." %}

### ST-LINK/V2

One example of compatible drivers are the ST-LINK/V2 USB drivers, from ST,
available as part number 
[STSW-LINK009](http://www.st.com/web/en/catalog/tools/FM147/SC1887/PF260219).
Download the `stsw-link009.zip` archive, extract its content into a separate
folder, and run the `dpinst_amd64.exe` (or `dpinst_x86.exe`) with
administrative privileges.

As for most Windows drivers, to complete the installation, a restart
usually helps.

Connect the ST-LINK/v2 or the DISCOVERY board and check in **Control Panel** 
→ **System** → **Device Manager** if the JTAG is operational.

![ST-LINK Windows device]({{ site.baseurl }}/assets/images/2019/windows-devices-stlink.png)

For other probes follow the manufacturer instructions.

{% include note.html content="All Windows tests were performed on Windows 10.
If, for any
reasons, you still use older versions, especially the venerable Windows XP,
some differences may be observed in the USB subsystem; to stay on the
safe side, try to always use original manufacturer drivers." %}

{% endcapture %}

{% capture macos %}

{{ easy_install }}

### Test

To check if the xpm installed OpenOCD starts, use something like:

```console
$ ~/opt/xPacks/@xpack-dev-tools/openocd/{{ page.version }}-13/.content/bin/openocd --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```

{{ manual_install }}

### Download

The macOS version of **xPack OpenOCD** is packed as a .tar.gz archive.
Download the latest version named like:

- `xpack-openocd-{{ page.version }}-13-darwin-x64.tgz`

### Unpack

To install OpenOCD, unpack the archive and copy it to
`/${HOME}/opt/xPacks/openocd/<version>`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-openocd-{{ page.version }}-13-darwin-x64.tgz
$ chmod -R -w xPacks/openocd/xpack-openocd-{{ page.version }}-13
```

{% include note.html content="For manual installs, the recommended
install location is different from the xpm install folders." %}

{% include important.html content="Although perfectly possible to
install OpenOCD in any folder, it is highly recommended to use this
path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

The result is a structure like:

```console
$ tree -L 2 /Users/ilg/Library/xPacks/openocd/xpack-openocd-{{ page.version }}-13
/Users/ilg/Library/xPacks/openocd/xpack-openocd-{{ page.version }}-13
├── OpenULINK
│   └── ulink_firmware.hex
├── README.md
├── bin
│   ├── libftdi1.2.4.0.dylib
│   ├── libftdi1.2.dylib -> libftdi1.2.4.0.dylib
│   ├── libgcc_s.1.dylib
│   ├── libhidapi.0.dylib
│   ├── libusb-0.1.4.dylib
│   ├── libusb-1.0.0.dylib
│   └── openocd
├── contrib
│   ├── 60-openocd.rules
│   └── libdcc
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── scripts
│   ├── bitsbytes.tcl
│   ├── board
│   ├── chip
│   ├── cpld
│   ├── cpu
│   ├── fpga
│   ├── interface
│   ├── mem_helper.tcl
│   ├── memory.tcl
│   ├── mmr_helpers.tcl
│   ├── target
│   ├── test
│   └── tools
└── share
    └── doc

20 directories, 15 files
```

### Test

To check if the manually installed OpenOCD starts, use something like:

```console
$ ~/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13/bin/openocd --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```
{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed OpenOCD starts, use something like:

```console
$ ~/opt/xPacks/@xpack-dev-tools/openocd/{{ page.version }}-13/.content/bin/openocd --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack OpenOCD** are packed as plain archives.
Download the latest version named like:

- `xpack-openocd-{{ page.version }}-13-linux-x64.tgz`
- `xpack-openocd-{{ page.version }}-13-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
CentOS, but can be executed on most recent GNU/Linux distributions.
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit
machines.

### Unpack

To install OpenOCD, unpack the archive and move it to
`/${HOME}/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13`:

```console
$ mkdir -p ~/opt
$ cd ~/opt

$ tar xvf ~/Downloads/xpack-openocd-{{ page.version }}-13-linux-x64.tgz
$ chmod -R -w xPacks/openocd/xpack-openocd-{{ page.version }}-13
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

{% include important.html content="Although perfectly possible to
install OpenOCD in any folder, it is highly recommended to use this
path, since by default the Eclipse Embedded CDT debug plug-ins search
for the executable in this location." %}

```console
$ tree -L 2 '/home/ilg/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13'
/home/ilg/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13/
├── bin
│   ├── libftdi1.so.2 -> libftdi1.so.2.4.0
│   ├── libftdi1.so.2.4.0
│   ├── libhidapi-hidraw.so.0 -> libhidapi-hidraw.so.0.0.0
│   ├── libhidapi-hidraw.so.0.0.0
│   ├── libiconv.so.2 -> libiconv.so.2.6.0
│   ├── libiconv.so.2.6.0
│   ├── libudev.so
│   ├── libudev.so.0 -> libudev.so
│   ├── libusb-0.1.so.4 -> libusb-0.1.so.4.4.4
│   ├── libusb-0.1.so.4.4.4
│   ├── libusb-1.0.so.0 -> libusb-1.0.so.0.1.0
│   ├── libusb-1.0.so.0.1.0
│   └── openocd
├── contrib
│   ├── 60-openocd.rules
│   └── libdcc
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── OpenULINK
│   └── ulink_firmware.hex
├── README.md
├── scripts
│   ├── bitsbytes.tcl
│   ├── board
│   ├── chip
│   ├── cpld
│   ├── cpu
│   ├── fpga
│   ├── interface
│   ├── mem_helper.tcl
│   ├── memory.tcl
│   ├── mmr_helpers.tcl
│   ├── target
│   ├── test
│   └── tools
└── share
    └── doc

20 directories, 21 files
```

### Test

To check if the manually installed OpenOCD starts, use something like:

```console
$ ~/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13/bin/openocd --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```

### UDEV

For the JTAG probes implemented as USB devices (actually most of them),
the last installation step on GNU/Linux is to configure the **UDEV**
subsystem. OpenOCD provides an UDEV rules file defining all the
supported IDs; to install it, just copy the file to `/etc/udev/rules.d`
and eventually notify the daemon:

```console
$ sudo cp ~/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13/contrib/60-openocd.rules /etc/udev/rules.d/
$ sudo udevadm control --reload-rules
```

{% include tip.html content="If you previously installed the
J-Link binaries, the USB IDs were
already added to UDEV. The above OpenOCD rules file also defines the
J-Link ID. Apparently UDEV does not complain; if you encounter
problems, just comment out the definition in the OpenOCD file." %}

### USB access rights

On some GNU/Linux distributions, the UDEV definitions are not enough,
or are not effective, and when trying to access the JTAG probe,
an error is issued:

```
libusb_open failed: LIBUSB_ERROR_ACCESS
```

If this happens, first try to start openocd with sudo; if this works,
for regular work you also need to grant your user permission to use the USB.

For example, on Ubuntu you need to issue something like:

```console
$ sudo usermod -aG plugdev $USER
```

Then restart and login again.

If you still have problems, check your distribution documentation and
when you have a functional solution post it on the project forum.

### Test

To check if the manually installed OpenOCD starts, use something like:

```console
$ ~/opt/xPacks/openocd/xpack-openocd-{{ page.version }}-13/bin/openocd --version
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
```

{% endcapture %}

{% include platform-tabs.html %}

## Testing

To test if the xpm installed OpenOCD is able to connect to a specific board,
it is generally
necessary to select the interface and the processor. As a shortcut, for
some well known boards, there are ready made configuration files
to set both the interface and the processor. For example, on
macOS, to test a connection via ST/LINK v2 to the STM32F4DISCOVERY board,
you can use the sample below:

```console
$ ~/opt/xPacks/@xpack-dev-tools/openocd/{{ page.version }}-13/.content/bin/openocd -f board/stm32f4discovery.cfg
xPack OpenOCD, 64-bit Open On-Chip Debugger {{ page.version }}+dev (2019-07-17-15:21)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : The selected transport took over low-level target control. The results might differ compared to plain JTAG/SWD
adapter speed: 2000 kHz
adapter_nsrst_delay: 100
none separate
srst_only separate srst_nogate srst_open_drain connect_deassert_srst
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : clock speed 2000 kHz
Info : STLINK V2J14S0 (API v2) VID:PID 0483:3748
Info : Target voltage: 2.881412
Info : stm32f4x.cpu: hardware has 6 breakpoints, 4 watchpoints
Info : Listening on port 3333 for gdb connections
^C
```
