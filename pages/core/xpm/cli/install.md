---
title: xpm install
permalink: /xpm/cli/install/

comments: true

date: 2017-10-09 12:56:00 +0300
last_updated: 2019-07-10 19:37:59 +0300

---

## Synopsis

Invoked with args referring to packages:

```
xpm install [<options> ...] [<args>...]
```

Invoked with no args, running in a package folder:

```
xpm install [<options> ...]
```

Aliases:
- `i`

## Description

This command installs a package, and all packages that it depends on. 

As for npm, a package is any of the following:

1. A folder containing a `package.json` file.
2. A gzipped tarball containing (1).
3. A URL that resolves to (2).
4. A `<name>@<version>` that is published on the registry with (3).
5. A `<name>@<tag>` that points to (4).
6. A `<name>` that has a `latest` tag satisfying (5).
7. A `git` url that, when cloned, results in (1).

Even if you never publish your package, you can still get a lot of 
benefits of using xpm to conveniently install dependencies, 
and perhaps
to automate path management for dependent tools.

### Install dependencies

When invoked without arguments in a package folder, `xpm` installs 
the dependencies listed in the `dependencies` and `devDependencies`
field in `package.json`.

If the dependencies are xPacks, they are installed in the local `xpacks` 
folder. For binary xPacks, soft links to the executables are created 
in the `xpacks/.bin` folder (on Windows `.cmd` stubs are created).

To maintain compatibility with npm, dependencies 
must not necessarily be xPacks, they can also be npm modules, 
and are installed as usual in `node_modules`.

Example:

```console
$ cd /tmp/hifive1-blinky-cpp
$ xpm install
xPack manager - install package(s)

Installing dependencies for 'hifive1-blinky-cpp'...
Folder 'micro-os-plus-diag-trace' linked to '@micro-os-plus/diag-trace/1.0.6'.
Folder 'sifive-hifive1-board' linked to '@sifive/hifive1-board/1.0.3'.
Folder 'sifive-devices' linked to '@sifive/devices/1.0.2'.
Folder 'micro-os-plus-riscv-arch' linked to '@micro-os-plus/riscv-arch/1.0.2'.
Folder 'micro-os-plus-startup' linked to '@micro-os-plus/startup/1.0.7'.
Folder 'micro-os-plus-c-libs' linked to '@micro-os-plus/c-libs/1.0.6'.
Folder 'micro-os-plus-cpp-libs' linked to '@micro-os-plus/cpp-libs/1.0.4'.
Folder 'xmake' linked to 'xmake/0.3.8'.
File 'xmake' linked to 'xmake/bin/xmake.js'
Folder 'gnu-mcu-eclipse-riscv-none-gcc' linked to '@gnu-mcu-eclipse/riscv-none-gcc/7.2.0-2.1'.
File 'riscv-none-embed-addr2line' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-addr2line'
File 'riscv-none-embed-ar' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-ar'
File 'riscv-none-embed-as' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-as'
File 'riscv-none-embed-c++' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-c++'
File 'riscv-none-embed-c++filt' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-c++filt'
File 'riscv-none-embed-cpp' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-cpp'
File 'riscv-none-embed-elfedit' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-elfedit'
File 'riscv-none-embed-g++' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-g++'
File 'riscv-none-embed-gcc' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcc'
File 'riscv-none-embed-gcc-7.2.0' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcc-7.2.0'
File 'riscv-none-embed-gcc-ar' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcc-ar'
File 'riscv-none-embed-gcc-nm' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcc-nm'
File 'riscv-none-embed-gcc-ranlib' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcc-ranlib'
File 'riscv-none-embed-gcov' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcov'
File 'riscv-none-embed-gcov-dump' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcov-dump'
File 'riscv-none-embed-gcov-tool' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gcov-tool'
File 'riscv-none-embed-gdb' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gdb'
File 'riscv-none-embed-gprof' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-gprof'
File 'riscv-none-embed-ld' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-ld'
File 'riscv-none-embed-ld.bfd' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-ld.bfd'
File 'riscv-none-embed-nm' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-nm'
File 'riscv-none-embed-objcopy' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-objcopy'
File 'riscv-none-embed-objdump' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-objdump'
File 'riscv-none-embed-ranlib' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-ranlib'
File 'riscv-none-embed-readelf' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-readelf'
File 'riscv-none-embed-run' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-run'
File 'riscv-none-embed-size' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-size'
File 'riscv-none-embed-strings' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-strings'
File 'riscv-none-embed-strip' linked to 'gnu-mcu-eclipse-riscv-none-gcc/.content/bin/riscv-none-embed-strip'
Folder 'gnu-mcu-eclipse-openocd' linked to '@gnu-mcu-eclipse/openocd/0.10.0-7.1'.
File 'openocd' linked to 'gnu-mcu-eclipse-openocd/.content/bin/openocd'
Folder 'gnu-mcu-eclipse-windows-build-tools' linked to '@gnu-mcu-eclipse/windows-build-tools/2.10.1'.

'xpm install' completed in 6.086 sec.
$
```


### Install packages 

When invoked with arguments, they must refer to packages. The common
use case is to use names of packages stored on the public repository,
but since xpm uses the same library to manage downloads as npm,
all formats are accepted:

```
xpm install [<@scope>/]<name>
xpm install [<@scope>/]<name>@<tag>
xpm install [<@scope>/]<name>@<version>
xpm install [<@scope>/]<name>@<version range>
xpm install <git-host>:<git-user>/<repo-name>
xpm install <git repo url>
xpm install <tarball file>
xpm install <tarball url>
xpm install <folder>
```

For detail please see [`npm install`](https://docs.npmjs.com/cli/install).

Examples:

```console
$ xpm install --global @gnu-mcu-eclipse/arm-none-eabi-gcc
xPack manager - install package(s)

Processing @gnu-mcu-eclipse/arm-none-eabi-gcc@8.2.1-1.7.1...
Installing globally in '/Users/ilg/Library/xPacks/@gnu-mcu-eclipse/arm-none-eabi-gcc/8.2.1-1.7.1'...
Extracting 'gnu-mcu-eclipse-arm-none-eabi-gcc-8.2.1-1.7-20190524-0603-macos.tgz'...
3248 files extracted.

'xpm install' completed in 9.958 sec.
$ 
```

## Options

### Help (`--help`)

```
$ xpm install --help

xPack manager - install package(s)
Usage: xpm install [options...] [--global] [--system] [--force] [--dry-run]
                   [[@<scope>]/<name>[@<version]]

Install options:
  -g|--global           Install the package globally in the home folder (optional)
  -sy|--system          Install the package in a system folder (not impl) (optional)
  -f|--force            Force install over existing package (optional)
  -n|--dry-run          Pretend to install the package (not impl) (optional)

Common options:
  --loglevel <level>    Set log level (silent|warn|info|verbose|debug|trace) 
  -s|--silent           Disable all messages (--loglevel silent) 
  -q|--quiet            Mostly quiet, warnings and errors (--loglevel warn) 
  --informative         Informative (--loglevel info) 
  -v|--verbose          Verbose (--loglevel verbose) 
  -d|--debug            Debug messages (--loglevel debug) 
  -dd|--trace           Trace messages (--loglevel trace, -d -d) 
  --no-update-notifier  Skip check for a more recent version 
  -C <folder>           Set current folder 

xpm -h|--help           Quick help 
xpm --version           Show version 
xpm -i|--interactive    Enter interactive mode 

npm xpm@0.5.0 '/Users/ilg/Library/npm/lib/node_modules/xpm'
Home page: <https://github.com/xpack/xpm-js>
Bug reports: <https://github.com/xpack/xpm-js/issues>
$
```

### Install globally (`-g|--global`)

Install the package(s) in the global repository (in the user home folder).

### Force install (`-f|--force`)

Normally if a package is already installed, xpm exits with a message.

Use this option to force xpm to reinstall a package.

### Dry-run (`-n|--dry-run`)

Do everything except to actually install the package(s).

