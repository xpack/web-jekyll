---
title: How to install xpm?
permalink: /xpm/install/

toc: false
comments: true
keywords: 
  - xpm
  - npm
  - xpack
  - install


date: 2017-10-09 14:14:00 +0300
last_updated: 2019-06-30 10:30:20 +0300

---

## Overview

`xpm` is a [Node.js](https://nodejs.org) CLI application available as the 
npm package [`xpm`](https://www.npmjs.com/package/xpm) from the 
[npmjs.com](https://www.npmjs.com) public repository.

## Prerequisites

A recent [Node.js](https://nodejs.org) (>=8.x), since the ECMAScript 6 class 
syntax is used.

```console
$ node --version
v10.6.0
```

If this is your first encounter with `npm`/`xpm`, you need to install the 
Node.js JavaScript run-time. The process is 
straightforward and does not pollute the system locations significantly; 
there are two `node` versions, **LTS** (**Long Term Service**) and 
**Current**; generally it is safer to use LTS, especially on Windows.

![The Node Download page]({{ site.baseurl }}/assets/images/2019/nodejs-org.png)

The general procedure is to download the package suitable for your 
platform and install it as usual.
The result is a binary program called `node` (that can be used to execute 
JavaScript code from the terminal), and a link called `npm`, pointing to 
the `npm-cli.js` script, which is part of the node module that implements 
the npm functionality. 

{% include tip.html content="The usual method is to install `node` with 
administrative rights;
it is also possible to install it in a custom location, using the
archive distributions. Regardless where it is installed, `node` must 
be in the system path." %}

{% capture version_manager %}
### Version manager

For advanced users, it is recommended to use a version manager,
which allows to install multiple versions of Node.js in parallel. 
For details, see the 
[Using a Version Manager to install Node.js and npm](https://docs.npmjs.com/getting-started/installing-node#using-a-version-manager-to-install-nodejs-and-npm)
page.
{% endcapture %}

{% capture node_install %}
## `node` install
{% endcapture %}

{% capture xpm_install %}
## `xpm` install

The command line tool is implemented as a portable node module, available as 
[`xpm`](https://www.npmjs.com/package/xpm) from the public repository.
{% endcapture %}

{% capture windows %}

{{ node_install }}

Download the **Windows Installer (.msi)** and install it as usual, 
with administrative rights.
If you are using a 64-bit machine, download the `node-v*-x64.msi` file.

The result is a folder like `C:\Program Files\nodejs`, added to the 
system path since it includes the `node.exe` binary.

Although not mandatory for using `xpm` alone, on Windows it is recommended to 
also install the [Git for Windows](https://git-scm.com/download/win) package.

`npm`/`xpm` can run either in the Windows `cmd.exe` terminal, 
or in the git shell terminal.

{{ version_manager }}

{{ xpm_install }}

On **Windows**, by default, global node packages are installed in the 
user home folder, in `%APPDATA%\npm` 
(like `C:\Users\ilg\AppData\Roaming\npm`), and managing packages 
does not require administrative rights.

```
C:\>npm install --global xpm
```

The result is a pair of files in the `%APPDATA%\npm` folder:

```powershell
C:\>dir "%APPDATA%"\npm\xpm*
 Volume in drive C has no label.
 Volume Serial Number is 28CE-1C06

 Directory of C:\Users\Liviu Ionescu\AppData\Roaming\npm

18/04/2018  10:40               319 xpm
18/04/2018  10:40               196 xpm.cmd
               2 File(s)            515 bytes
               0 Dir(s)  51,207,155,712 bytes free
```

Recent versions of `node` usually work directly, however, in some setups, 
attempts to start the program may fail:

```
C:\>xpm --version
'xpm' is not recognized as an internal or external command,
operable program or batch file.
```

The reason is that this path may not be in the default environment, 
and must be added manually.

```
C:\>setx Path "%Path%;%APPDATA%\npm"
```

After this, the program should start normally:

```
C:\>xpm --version
0.4.3
```

To remove `xpm`, the command is similar:

```
C:\>npm uninstall --global xpm
```

### Aggressive antivirus programs & xpm

On Windows, binary xPacks are .zip archives containing .exe files; 
some aggressive antivirus programs may quarantine those files, or 
even modify the content of the archives, affecting the checksum and 
thus preventing the packages to be installed.

Errors may look like:

```
Downloading https://github.com/gnu-mcu-eclipse/qemu/releases/download/v2.8.0-4-20190211/gnu-mcu-eclipse-qemu-2.8.0-4-20190211-0633-win64.zip...
{ Error: sha256-p3CgzXJt4zi5g0kxQXlOpss3Xu5Yy+Zv8HXWXkUdg6g= integrity checksum failed when using sha256: wanted sha256-p3CgzXJt4zi5g0kxQXlOpss3Xu5Yy+Zv8HXWXkUdg6g= but got sha512-k1s9UW6Zb20llIuopUwbf3D38OP1F+Nkgf3wGWwsXPwoQfhuiR89+VF3Rrf7YF20fN3tG4/3jZSC3apiHbQ6NA== sha256-ABnfxLMtY8E5KqJkrtIlPB4ML7CSFvjizCabv7i7SbU=. (9 bytes)
...
Extracting 'gnu-mcu-eclipse-qemu-2.8.0-4-20190211-0633-win64.zip'...
error: Cannot read property 'path' of null
```

The solution is to configure the antivirus program to be less aggressive,
at least for files in the 
`AppData\Roaming\xPacks` and `AppData\Local\Caches\xPacks` folders.

If this is not possible, temporarily disable the antivirus program.

{% endcapture %}

{% capture macos %}

{{ node_install }}

Download the **macOS Installer (.pkg)** and install it as usual,
with administrative rights.

The result is a binary like `/usr/local/bin/node` and a folder like
`/usr/local/lib/node_modules` where the modules, including `npm`, 
are installed.

{{ version_manager }}

{{ xpm_install }}

### Default (with administrative rights)

On **macOS**, by default, global node packages are installed in 
`/usr/local`, and managing them requires administrative rights.

```console
$ sudo npm install --global xpm   <-- DO NOT DO THAT
```

The result is a link in `/usr/local/bin`:

```console
$ ls -l /usr/local/bin/xpm
lrwxr-xr-x  1 root  wheel  34 Nov 13 03:02 /usr/local/bin/xpm -> ../lib/node_modules/xpm/bin/xpm.js
```

### Recommended (without administrative rights)

To avoid some nasty errors while installing packages,
**the recommended install location** is `${HOME}/Library/npm`.

{% capture uninstall %}
For those who already performed the install in `/usr/local`, the 
command to remove it is: `sudo npm uninstall --global xpm`.
{% endcapture %}

{% include tip.html content=uninstall %}

{% include note.html content="On macOS, by default, `~/Library` is 
hidden and does not show in folder selections. See below how to
make it visible again, or select an alternate location." %}

The commands to configure the custom location are:

```console
$ mkdir -p ~/Library/npm
$ npm config set prefix ~/Library/npm
$ echo 'export PATH="${HOME}/Library/npm/bin:${PATH}"' >> ~/.profile
$ source ~/.profile
```

With the environment properly set, the command to install `xpm` is:

```console
$ npm install --global xpm
```

To test if `xpm` starts:

```console
$ which xpm
/Users/ilg/Library/npm/bin/xpm
$ xpm --version
0.4.3
```

To remove `xpm`, the command is similar:

```console
$ npm uninstall --global xpm
```

### macOS specifics

On macOS, by default, `~/Library` is hidden and does not show in folder selections.

To make it visible, use:

```console
$ /usr/bin/chflags nohidden ~/Library
$ xattr -d com.apple.FinderInfo ~/Library
```

If you don't want to do this, an alternate solution is to install
the xPacks in `~/opt`, as on GNU/Linux.

For this set the environment variables to the new location:

```
XPACKS_REPO_FOLDER="${HOME}/opt/xPacks"
XPACKS_CACHE_FOLDER="${HOME}/.cache/xPacks"
```

You can also reconfigure the location where `npm` is installed:

```console
$ mkdir -p ~/opt/npm
$ npm config set prefix ~/opt/npm
$ echo 'export PATH="${HOME}/opt/npm/bin:${PATH}"' >> ~/.profile
$ source ~/.profile
```

(Be sure to remove the previous location from `.profile`.)

{% endcapture %}

{% capture linux %}

{{ node_install }}

On GNU/Linux, follow the instructions in 
[Installing Node.js via package manager](https://nodejs.org/en/download/package-manager/).

The result is a binary like `/usr/bin/node` and a folder like
`/usr/lib/node_modules` where the modules, including `npm`, are installed.

{% include warning.html content="Your distribution may already have a `node` 
binary installed; if
it is not >=8.x, `xpm` will complain and do not start; anyway, we strongly
recommend to avoid the distribution binary and install at least 
the LTS package from Node.js." %}

{{ version_manager }}

{{ xpm_install }}

### Default (with administrative rights)

On **GNU/Linux**, by default, global node packages are installed in 
`/usr/local`, and managing them requires administrative rights.

```console
$ sudo npm install --global xpm   <-- DO NOT DO THAT
```

The result is a link in `/usr/local/bin`:

```console
$ ls -l /usr/local/bin/xpm
lrwxr-xr-x  1 root  wheel  34 Nov 13 03:02 /usr/local/bin/xpm -> ../lib/node_modules/xpm/bin/xpm.js
```

### Recommended (without administrative rights)

To avoid some nasty errors while installing packages,
**the recommended install location** is `${HOME}/opt/npm`.

{% capture uninstall %}
For those who already performed the install in `/usr/local`, the 
command to remove it is: `sudo npm uninstall --global xpm`.
{% endcapture %}

{% include tip.html content=uninstall %}

The commands to configure the custom location are:

```console
$ mkdir -p ~/opt/npm
$ npm config set prefix ~/opt/npm
$ echo 'export PATH="${HOME}/opt/npm/bin:${PATH}"' >> ~/.profile
$ source ~/.profile
```

(These commands were tested with `bash`, for other shells may need small
adjustments).

With the environment properly set, the command to install `xpm` is:

```console
$ npm install --global xpm
```

To test if `xpm` starts:

```console
$ which xpm
/home/ilg/opt/npm/bin/xpm
$ xpm --version
0.4.3
```

To remove `xpm`, the command is similar:

```console
$ npm uninstall --global xpm
```

{% endcapture %}

{% include platform-tabs.html %}

## Update npm to the latest release

Regardless if `npm` was already installed, or you just installed it with
`node`, it is alwys a good idea to update `npm` to the latest version:

```console
$ npm install --global npm
```

If you did not switch to local install, on macOS and GNU/Linux use `sudo`.

## Miscellaneous

The official page explaining how to install `npm` in a custom
folder is [How to Prevent Permissions Errors](https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-two-change-npms-default-directory).

## `npx`

If, for any reason, you decide not to install `xpm`, you can still 
benefit from it by using `npx`, as a trampoline to start `xpm`:

```console
$ npx xpm --version
0.4.3
```

However, for regular usage, this method is not efficient, since 
`npx` will need to prepare the node module
for each run, and this takes some time.

## `npm` folders

For more details on the folders used by `npm`, see 
[npm-folders](https://docs.npmjs.com/files/folders).

## `xpm` folders

To avoid security issues and the need to increase the user privilege level,
`xpm` does not use any system folders, and all activity happens
in the user home.

There are two main folders:
- a cache folder, where all downloaded files are stored
- a central repository folder, where the xPacks are expanded

For more details see [xpm folders]({{ site.baseurl }}/xpm/folders/).

## User info

To get an initial glimpse on the program, ask for help:

```console
$ xpm --help

The xPack package manager command line tool
Usage: xpm <command> [<subcommand>...] [<options> ...] [<args>...]

where <command> is one of:
  build, init, install, run-script

Common options:
  --loglevel <level>     Set log level (silent|warn|info|verbose|debug|trace) 
  -s|--silent            Disable all messages (--loglevel silent) 
  -q|--quiet             Mostly quiet, warnings and errors (--loglevel warn) 
  --informative          Informative (--loglevel info) 
  -v|--verbose           Verbose (--loglevel verbose) 
  -d|--debug             Debug messages (--loglevel debug) 
  -dd|--trace            Trace messages (--loglevel trace, -d -d) 
  -C <folder>            Set current folder 

xpm -h|--help            Quick help 
xpm <command> -h|--help  Quick help on command 
xpm --version            Show version 
xpm -i|--interactive     Enter interactive mode 

npm xpm@0.2.10 '/Users/ilg/My Files/MacBookPro Projects/xPack/npm-modules/xpm-js.git'
Home page: <https://github.com/xpack/xpm-js>
Bug reports: <https://github.com/xpack/xpm-js/issues>
$
```
