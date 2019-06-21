---
layout: page
title: How to install the OpenOCD binaries?
permalink: /dev-tools/openocd/install/
sidebar: openocd_sidebar

summary: "The recommended method is via xpm."
date: 2015-09-09 19:43:00 +0300
last_updated: 2019-06-21 23:11:00 +0300

---

## Overview

The **xPack OpenOCD** can be installed automatically, via `xpm` (the
recommended method), or manually, using the portable archives.

## Easy install 

The easiest way to install OpenOCD is using the **binary xPack**, available as 
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent 
`xpm`, which is a portable 
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions in the 
[xpm install](https://xpack.github.io/core/xpm/install/) page.

### Install

With `xpm` available, installing 
the latest version of the package is quite easy:

```console
$ xpm install --global @xpack-dev-tools/openocd
```

This command will always install the latest available version, 
in the central xPacks repository, which is a platform dependent folder 
(check the output of the `xpm` command or the actual folder used on 
your platform).

This location is configurable using the environment variable 
`XPACKS_REPO_FOLDER`; for more details please check the 
[xpm folders](https://xpack.github.io/core/xpm/folders/) page.

xPacks aware tools, like the **GNU MCU Eclipse plug-ins** automatically 
identify binaries installed with
`xpm` and provide a convenient method to manage paths.

### Uninstall

To remove the installed xPack, the command is similar:

```console
$ xpm uninstall --global @xpack-dev-tools/openocd
```

(Note: not yet implemented. As a temporary workaround, simply remove the 
`xPacks/@xpack-dev-tools/openocd` folder, or one of the versioned 
subfolders.)

## Manual install

For all platforms, the **xPack OpenOCD** binaries are released as portable 
archives that can be installed in any location.

The archives can be downloaded from the GitHub 
[Releases](https://github.com/xpack-dev-tools/openocd-xpack/releases/) page.

{% include note.html content="For manual installs, the recommended 
install location is different from the xPack install folder." %}

### Windows

The Windows versions of **xPack OpenOCD** are packed as ZIP files. 
Download the latest version named like:

- `xpack-openocd-0.10.0-12-win32-x64.zip`
- `xpack-openocd-0.10.0-12-win32-x32.zip`

Select the `-x64` file for 64-bit Windows machines and the `-x32` file 
for 32-bit Windows machines.

Unpack the archive and copy it into the `%userprofile%\AppData\Roaming\xPacks` 
(for example `C:\Users\ilg\AppData\Roaming\xPacks`) folder; according 
to Microsoft, this is the recommended location for installing user specific 
packages.

{% include important.html content="Although perfectly possible to 
install OpenOCD in any folder, it is highly recommended to use this 
path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

The result is a structure like:

![The OpenOCD folders structure]({{ site.baseurl }}/assets/images/2019/windows-folders-openocd.png)

To check if OpenOCD starts, use the following command:

```
C:\Users\ilg>C:\Users\ilg\AppData\Roaming\xPacks\OpenOCD\0.10.0-12\bin\openocd.exe --version
xPack OpenOCD, 64-bit Open On-Chip Debugger 0.10.0+dev-00593-g23ad80df4 (2019-06-19-15:39)
```

#### Drivers

As usual on Windows, mastering drivers is a challenge and OpenOCD is no 
exceptions, so don't be surprised to encounter many incompatible drivers 
for various JTAG probes. The OpenOCD distribution includes some libusb 
drivers, and recommends to run the `zadig.exe` tool to activate them. 
Although this manoeuvre will make OpenOCD happy, it will most probably 
ruin other USB drivers you might have installed. Our strong recommendation 
is to **NOT** do this, and instead use the manufacturer drivers, when 
compatible with OpenOCD.

#### ST-LINK/V2

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

#### Zadig

For some devices, for example 
[ARM-USB-OCD](https://www.olimex.com/Products/ARM/JTAG/) from 
[Olimex](https://www.olimex.com/), after installing the vendor drivers, 
you must also install Zadig and convert the vendor drivers to WinUSB drivers.

### macOS

The macOS version of **xPack OpenOCD** is packed as a TGZ archive. 
Download the latest version named like:

-  `xpack-openocd-0.10.0-12-darwin-x64.tgz`

To install OpenOCD, unpack the archive and copy it to 
`/${HOME}/opt/xPacks/openocd/`:

```console
$ mkdir -p "${HOME}/opt"
$ cd "${HOME}/opt"

$ tar xvf ~/Downloads/xpack-openocd-0.10.0-12-darwin-x64.tgz
$ chmod -R -w xPacks/openocd/0.10.0-12
```

{% include important.html content="Although perfectly possible to 
install OpenOCD in any folder, it is highly recommended to use this 
path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

To check if OpenOCD starts, use:

```console
$ ~/opt/xPacks/openocd/0.10.0-12/bin/openocd --version
xPacks 64-bit Open On-Chip Debugger 0.10.0+dev-00593-g23ad80df4 (2019-06-19-19:02)
```

### GNU/Linux

The GNU/Linux versions of **xPack OpenOCD** are packed as TGZ archives. 
Download the latest version named like:

- `xpack-openocd-0.10.0-12-linux-x64.tgz`
- `xpack-openocd-0.10.0-12-linux-x32.tgz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
CentOS, but can be executed on most recent GNU/Linux distributions. 
Select the `-x64` file for 64-bit machines and the `-x32` file for 32-bit 
machines.

To install OpenOCD, unpack the archive and copy it to 
`/${HOME}/opt/xPacks/openocd/${version}`:

```console
$ mkdir -p "${HOME}/opt"
$ cd "${HOME}/opt"

$ tar xvf ~/Downloads/xpack-openocd-0.10.0-12-linux-x64.tgz
$ chmod -R -w xPacks/openocd/0.10.0-12
```

{% include important.html content="Although perfectly possible to 
install OpenOCD in any folder, it is highly recommended to use this 
path, since by default the GNU MCU Eclipse debug plug-ins search 
for the executable in this location." %}

To check if OpenOCD starts and is recent, use:

```console
$ ~/opt/xPacks/openocd/0.10.0-12/bin/openocd --version
xPacks 64-bit Open On-Chip Debugger 0.10.0+dev-00593-g23ad80df4 (2019-06-19-19:02)
```

#### UDEV

For the JTAG probes implemented as USB devices (actually most of them), 
the last installation step on GNU/Linux is to configure the **UDEV** 
subsystem. OpenOCD provides an UDEV rules file defining all the 
supported IDs; to install it, just copy the file to `/etc/udev/rules.d` 
and eventually notify the daemon:

```console
$ sudo cp ~/opt/xPacks/openocd/0.10.0-12/contrib/60-openocd.rules /etc/udev/rules.d/
$ sudo udevadm control --reload-rules
```

{% include tip.html content="If you previously installed the 
J-Link binaries, the USB IDs were 
already added to UDEV. The above OpenOCD rules file also defines the 
J-Link ID. Apparently UDEV does not complain; if you encounter 
problems, just comment out the definition in the OpenOCD file." %}

#### USB access rights

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

## Testing

To test if OpenOCD is able to connect to a specific board, it is generally 
necessary to select the interface and the processor. As a shortcut, for 
some well known boards, there are ready made configuration files 
to set both the interface and the processor. For example, on 
macOS, to test a connection via ST/LINK v2 to the STM32F4DISCOVERY board, 
you can use the sample below:

```console
$ ~/opt/gnu-mcu-eclipse/openocd/0.11.0-12/bin/openocd -f board/stm32f4discovery.cfg
xPack OpenOCD, 64-bitOpen On-Chip Debugger 0.10.0+dev-00593-g23ad80df4 (2019-06-19-19:02)
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
