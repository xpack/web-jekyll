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
last_updated: 2020-06-27 15:37:27 +0300

---

## Overview

**xpm** is a [Node.js](https://nodejs.org) CLI application available as the
npm package [xpm](https://www.npmjs.com/package/xpm) from the
[`npmjs.com`](https://www.npmjs.com) public repository.

## Prerequisites

A recent [Node.js](https://nodejs.org) (>=8.x), since the ECMAScript 6 class
syntax is used, and a recent [npm](https://docs.npmjs.com/cli/npm).

For details, please read (carefully!) the
[prerequisites]({{ site.baseurl }}/install/) page.

## `xpm` install

{% capture windows %}

On Windows, by default, global Node.js packages are installed in the
user home folder, in `%APPDATA%\npm`
(like `C:\Users\ilg\AppData\Roaming\npm`), and managing packages
does not require administrative rights.

```
C:\>npm install --global xpm@latest
C:\Users\ilg\AppData\Roaming\npm\xpm -> C:\Users\ilg\AppData\Roaming\npm\node_modules\xpm\bin\xpm.js
+ xpm@0.5.0
added 260 packages from 147 contributors in 36.304s
```

The result is a pair of files in the `%APPDATA%\npm` folder:

```powershell
C:\>dir "%APPDATA%"\npm\xpm*
 Volume in drive C has no label.
 Volume Serial Number is 28CE-1C06

 Directory of C:\Users\ilg\AppData\Roaming\npm

18/04/2018  10:40               319 xpm
18/04/2018  10:40               196 xpm.cmd
               2 File(s)            515 bytes
               0 Dir(s)  51,207,155,712 bytes free
```

If you followed the instructions in the
[prerequisites]({{ site.baseurl }}/install/) page, you should
already have this path configured and the program should start normally:

```powershell
C:\>xpm --version
0.5.0
```

### Aggressive antivirus programs & xpm

On Windows, binary xPacks are `.zip` archives containing `.exe` files;
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

On macOS, by default, global Node.js packages are installed in
`/usr/local`, and managing them requires administrative rights,
but if you followed the instructions in the
[prerequisites]({{ site.baseurl }}/install/) page, you should
already have configured npm to use a location in the home folder.

With the environment properly set, the command to install xpm is:

```console
$ npm install --global xpm@latest
```

To test if xpm starts:

```console
$ which xpm
/Users/ilg/Library/npm/bin/xpm
$ xpm --version
0.5.0
```

{% endcapture %}

{% capture linux %}

{% include warning.html content="The current xpm fully supports
only Intel platforms. Attempts to install Arm binary packages
will fail (actually will install the Intel packages).
Support for Arm platforms will be
added in the next release of xpm." %}

On GNU/Linux, by default, global Node.js packages are installed in
`/usr/local`, and managing them requires administrative rights,
but if you followed the instructions in the
[prerequisites]({{ site.baseurl }}/install/) page, you should
already have configured npm to use a location in the home folder.

With the environment properly set, the command to install xpm is:

```console
$ npm install --global xpm@latest
```

To test if xpm starts:

```console
$ which xpm
/home/ilg/opt/npm/bin/xpm
$ xpm --version
0.5.0
```

### Using an out of date Node.js

Ignoring the recommendation to use the LTS version of Node.js and
insisting on using the one provided by the distribution usually results in
errors like this:

```
$ xpm -v
/home/ilg/opt/npm/lib/node_modules/xpm/node_modules/@ilg/cli-start-options/lib/cli-application.js:150
  static async start () {
               ^^^^^
SyntaxError: Unexpected identifier
    at exports.runInThisContext (vm.js:53:16)
    at Module._compile (module.js:374:25)
    at Object.Module._extensions..js (module.js:417:10)
    at Module.load (module.js:344:32)
    at Function.Module._load (module.js:301:12)
    at Module.require (module.js:354:17)
    at require (internal/module.js:12:17)
    at Object.<anonymous> (/home/ilg/opt/npm/lib/node_modules/xpm/node_modules/@ilg/cli-start-options/index.js:55:24)
    at Module._compile (module.js:410:26)
    at Object.Module._extensions..js (module.js:417:10)
```

This problem is caused by the old Node.js, unable to understand the
`async` keyword.

Follow the instructions in the
[prerequisites]({{ site.baseurl }}/install/) page and update your
`node` & `npm` programs.

{% endcapture %}

{% include platform-tabs.html %}

## Uninstall

To remove xpm, the command is:

```console
$ npm uninstall --global xpm
```

## Miscellaneous

The official page explaining how to install npm in a custom
folder is [How to Prevent Permissions Errors](https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-two-change-npms-default-directory).

## `npx`

If, for any reason, you decide not to install xpm, you can still
benefit from it by using the `npx` comand, as a trampoline to start xpm:

```console
$ npx xpm --version
0.4.3
```

However, for regular usage, this method is not efficient, since
npx will need to prepare the Node.js module
for each run, and this takes some time.

## npm folders

For more details on the folders used by npm, see
[npm-folders](https://docs.npmjs.com/files/folders).

## xpm folders

To avoid security issues and the need to increase the user privilege level,
xpm does not use any system folders, and all activity happens
in the user home.

There are two main folders:

- a cache folder, where all downloaded files are stored
- a central repository folder, where the xPacks are expanded

For more details see [xpm folders]({{ site.baseurl }}/xpm/folders/).

### macOS specifics

The default location used to install the global packages repository is
in `~/Library`, a folder that, due to an unfortunate Apple decision,
is hidden for regular browsing in Finder.

To make it back visible, use:

```console
$ /usr/bin/chflags nohidden ~/Library
$ xattr -d com.apple.FinderInfo ~/Library
```

A more general solution is to make all hidden files:

```console
$ defaults write com.apple.Finder AppleShowAllFiles true
$ killall Finder
```

Another anoying behaviour of the file browser is to hide names starting
with `.` (dot), which is a real pity since the binary packages are
extracted in a folder named `.content`.

Fortunately there is a workaround for this too:

```
cmd+shift+'.'
```

This keyboard shortcut works like a toggle, using it once makes files
starting with dot visible,
using it again reverts to hiding them.

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
