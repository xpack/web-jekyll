---
permalink: /intro/
title: xPack 101

summary: A npm module with an extra xpack property.
comments: true

date: 2019-06-26 08:57:00 +0300

---

## Oh, no, not another package format!

This is probably the first thought many people might have when hearing about
xPacks. There are enough package formats and package managers,
why would we need yet another one?

Well, first, the xPacks project **does not introduce a new package format**,
but uses exactly the same format as **npm**,
and xPacks can be stored in the same repositories, public or private.

And **xpm**, the project manager, is built on top of **npm**, the very
popular JavaScript package manager, extending it with new language
neutral features,
so things are not that scary as they seemed initially.

## I'm perfectly happy with my development environment, why would I bother with xPacks?

The current development environments are indeed great, and rolling
distributions like _Arch_ and _Homebrew_ do a tremendous job in keeping the
systems up-to-date, but not rarely the latest and greatest available versions
break older applications and various complex processes, like build
scripts, that depend on older versions.

The **xPacks** dependency mechanism is intended to solve exactly this problem,
by providing a simple and uniform solution of
installing different versions of the same package in different
folders, and managing dependencies.

## Why bother to manage versions when auto-configure can sort out the differences?

The traditional way of dealing with different versions and variations between
systems is to add a complex auto-configure mechanism that is able to detect
which tools/components are present, which versions, and with
this input do its best to parametrise the process (for example a project build),
to accommodate for all these differences.

This approach started with GNU _configure_, and today use even more complex
solutions, like _CMake_ or _meson_ scripts.

Well, instead of permanently wondering how to make use of the new versions,
and making the auto-configure scripts more and more complex with every day,
why not allow the application to ask for the exact versions that are known
to be compatible, and let an automated tool handle the dependencies?

The **xPacks** project manager can do just this, bring in the project
exactly the versions needed, thus making the auto-configure step superfluous.

## But what are xPacks?

In brief, **xPacks** are general purpose multi-version software packages.

By **multi-version** it is understood not only that packages can have
multiple versions, but they **can be installed in parallel**, allowing each
project to have its own set of dependencies.

Based on the installed content, there are currently two
types of xPacks: **source** and **binary**:

- **source xPacks** are packages that install source files,
generally libraries used by the project.
- **binary xPacks** are packages that install standalone executables/binary
files, generally tools used during the build process, like toolchains,
builders, etc; standalone means they are self-contained and do not
depend on other shared libraries or tools.

## Where does the name come from?

**xPack**, pronounced _**ɛks-pak**_, can be understood as _Universal Package_,
or _Any Type Package_, and tries to suggest that, when compared to
npm packages (which are basically JavaScript packages), xPacks are more
general, and not linked/limited to a specific programming language.

Initially the _x_ came from _eXtended_, so _eXtended Packages_ can
be another choice.

## What exactly is an xPack?

The full definition is:

{% include callout.html content="An xPack is a folder which includes a
`package.json` file, defining at least
the package `name`, the package `version`, and an `xpack` property,
even empty." type="primary" %}

{% include note.html content="The name and version are mandatory
only when publishing the package or
installing it as a dependency. However it is recommended to
define them in all packages." %}

Given the direct inheritance from npm packages, a canonical
definition might be:

{% include callout.html content="An xPack is a npm package with
an additional `xpack` property defined in `package.json`." type="primary" %}

{% include callout.html content="A binary xPack is an xPack with
two additional `xpack.binaries` and `xpack.bin` properties defined in
`package.json`." type="primary" %}

### Package formats

As for npm, a package is any of the following:

1. A folder containing a `package.json` file.
2. A gzipped tarball containing (1).
3. A URL that resolves to (2).
4. A `<name>@<version>` that is published on the registry with (3).
5. A `<name>@<tag>` that points to (4).
6. A `<name>` that has a `latest` tag satisfying (5).
7. A `git` url that, when cloned, results in (1).

## How to convert my project to an xPack?

Create a `package.json` file in the root folder of your project with at
least the following definitions:

```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "xpack": {}
}
```

{% include note.html content="The npm `package.json` has a few more
fields, please read
[Creating a package.json file](https://docs.npmjs.com/creating-a-package-json-file)
for details." %}

A more automated method is to use `xpm init`:

```console
$ mkdir xyz
$ cd xyz
$ xpm init --verbose
xPack manager - create an xPack, empty or from a template
Creating project 'xyz'...
File 'package.json' generated.
File 'LICENSE' generated.

'xpm init' completed in 98 ms.
$ ls -l
total 16
-rw-r--r--  1 ilg  staff  1070 Jul  1 23:33 LICENSE
-rw-r--r--  1 ilg  staff   645 Jul  1 23:33 package.json
$ cat package.json
{
  "name": "@<scope>/xyz",
  "version": "0.1.0",
  "description": "A source xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/<user-id>/xyz.git"
  },
  "bugs": {
    "url": "https://github.com/<user-id>/xyz/issues/"
  },
  "homepage": "https://github.com/<user-id>/xyz/",
  "keywords": [
    "xpack"
  ],
  "author": {
    "name": "<author-name>",
    "email": "<author-email>",
    "url": "<author-url>"
  },
  "license": "MIT",
  "config": {},
  "dependencies": {},
  "devDependencies": {},
  "xpack": {}
}
$
```

## Why would I convert my project to an xPack?

The top reasons are:

- to automate dependencies management
- to automate path management for dependent tools
- to manage multi-configuration builds

These are both simple and complicated things. To better understand
them, please continue to read how binary and source xPacks work.

## How do binary xPacks work?

Let's assume that 'my-awesome-project' needs the `arm-none-eabi-gcc`
toolchain to build,
and not any version but a specific one, like `10.2.1`; it also needs
the latest CMake, ninja and the liquidjs npm module.

For this, in the project folder, issue the following command, which
will install the required tools in a global xPacks store location, and add links
to them.

```console
$ xpm install @xpack-dev-tools/arm-none-eabi-gcc@10.2.1-1.1.2 @xpack-dev-tools/cmake@latest @xpack-dev-tools/ninja-build@latest liquidjs@latest --verbose
xPack manager - install package(s)

Processing @xpack-dev-tools/arm-none-eabi-gcc@10.2.1-1.1.2...
Folder 'xpacks/xpack-dev-tools-arm-none-eabi-gcc' linked to global '@xpack-dev-tools/arm-none-eabi-gcc/10.2.1-1.1.2'.
File 'xpacks/.bin/arm-none-eabi-addr2line' linked to '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-addr2line'.
File 'xpacks/.bin/arm-none-eabi-ar' linked to '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ar'.
...
File 'xpacks/.bin/arm-none-eabi-g++' linked to '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-g++'.
File 'xpacks/.bin/arm-none-eabi-gcc' linked to '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc'.
...
File 'xpacks/.bin/arm-none-eabi-strip' linked to '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-strip'.
Adding '@xpack-dev-tools/arm-none-eabi-gcc' to 'devDependencies'...

Processing @xpack-dev-tools/cmake@3.19.2-2.1...
Folder 'xpacks/xpack-dev-tools-cmake' linked to global '@xpack-dev-tools/cmake/3.19.2-2.1'.
File 'xpacks/.bin/ccmake' linked to '../xpack-dev-tools-cmake/.content/bin/ccmake'.
File 'xpacks/.bin/cmake' linked to '../xpack-dev-tools-cmake/.content/bin/cmake'.
File 'xpacks/.bin/cpack' linked to '../xpack-dev-tools-cmake/.content/bin/cpack'.
File 'xpacks/.bin/ctest' linked to '../xpack-dev-tools-cmake/.content/bin/ctest'.
Adding '@xpack-dev-tools/cmake' to 'devDependencies'...

Processing @xpack-dev-tools/ninja-build@1.10.2-2.1...
Folder 'xpacks/xpack-dev-tools-ninja-build' linked to global '@xpack-dev-tools/ninja-build/1.10.2-2.1'.
File 'xpacks/.bin/ninja' linked to '../xpack-dev-tools-ninja-build/.content/bin/ninja'.
Adding '@xpack-dev-tools/ninja-build' to 'devDependencies'...

Processing liquidjs@9.23.3...
Folder 'node_modules/liquidjs' linked to global 'liquidjs/9.23.3'.
File 'node_modules/.bin/liquidjs' linked to '../liquidjs/bin/liquid.js'.
File 'node_modules/.bin/liquid' linked to '../liquidjs/bin/liquid.js'.
Adding 'liquidjs' to 'devDependencies'...

'xpm install' completed in 1.364 sec.
```

This will also update the `package.json` with details about the dependencies:

```json
{
  "name": "@<scope>/xyz",
  "version": "0.1.0",
  "...": "...",
  "dependencies": {},
  "devDependencies": {
    "@xpack-dev-tools/arm-none-eabi-gcc": "10.2.1-1.1.2",
    "@xpack-dev-tools/cmake": "3.19.2-2.1",
    "@xpack-dev-tools/ninja-build": "1.10.2-2.1",
    "liquidjs": "^9.23.3"
  },
  "xpack": {}
}
```

{% include note.html content="The `^` used in the version field is
a npm/semver convention that means _compatible_, in other words the
highest version that does not change the major number, if available." %}

{% include note.html content="The lack of `^` means _exact_ version.
Use this syntax for binary xPacks with longer version numbers,
which generally do not abide by the semver requirements." %}

The result is the tools being downloaded and installed in the global
xPack store (a folder in user's home) and links from the project
to that folders created in the local `xpacks` folder, with links to
individual programs added in `xpacks/.bin` (or `.cmd` stubs on Windows).

Similarly for liquidjs, which is a Node.js CLI npm module, after
installing the module, npm will
add a folder `node_modules/.bin` where links to the executables
will be created (or `.cmd` stubs on Windows).

```console
$ tree -a
.
├── .DS_Store
├── LICENSE
├── node_modules
│   ├── .bin
│   │   ├── liquid -> ../liquidjs/bin/liquid.js
│   │   └── liquidjs -> ../liquidjs/bin/liquid.js
│   └── liquidjs -> /Users/ilg/Library/xPacks/liquidjs/9.23.3
├── package.json
└── xpacks
    ├── .bin
    │   ├── arm-none-eabi-addr2line -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-addr2line
    │   ├── arm-none-eabi-ar -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ar
    │   ├── arm-none-eabi-as -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-as
    │   ├── arm-none-eabi-c++ -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++
    │   ├── arm-none-eabi-c++filt -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++filt
    │   ├── arm-none-eabi-cpp -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-cpp
    │   ├── arm-none-eabi-elfedit -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-elfedit
    │   ├── arm-none-eabi-g++ -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-g++
    │   ├── arm-none-eabi-gcc -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc
    │   ├── arm-none-eabi-gcc-ar -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ar
    │   ├── arm-none-eabi-gcc-nm -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-nm
    │   ├── arm-none-eabi-gcc-ranlib -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ranlib
    │   ├── arm-none-eabi-gcov -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov
    │   ├── arm-none-eabi-gcov-dump -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-dump
    │   ├── arm-none-eabi-gcov-tool -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-tool
    │   ├── arm-none-eabi-gdb -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb
    │   ├── arm-none-eabi-gdb-add-index -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index
    │   ├── arm-none-eabi-gdb-add-index-py3 -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index-py3
    │   ├── arm-none-eabi-gdb-py3 -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-py3
    │   ├── arm-none-eabi-gprof -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gprof
    │   ├── arm-none-eabi-ld -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld
    │   ├── arm-none-eabi-ld.bfd -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld.bfd
    │   ├── arm-none-eabi-nm -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-nm
    │   ├── arm-none-eabi-objcopy -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-objcopy
    │   ├── arm-none-eabi-objdump -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-objdump
    │   ├── arm-none-eabi-ranlib -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ranlib
    │   ├── arm-none-eabi-readelf -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-readelf
    │   ├── arm-none-eabi-size -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-size
    │   ├── arm-none-eabi-strings -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-strings
    │   ├── arm-none-eabi-strip -> ../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-strip
    │   ├── ccmake -> ../xpack-dev-tools-cmake/.content/bin/ccmake
    │   ├── cmake -> ../xpack-dev-tools-cmake/.content/bin/cmake
    │   ├── cpack -> ../xpack-dev-tools-cmake/.content/bin/cpack
    │   ├── ctest -> ../xpack-dev-tools-cmake/.content/bin/ctest
    │   └── ninja -> ../xpack-dev-tools-ninja-build/.content/bin/ninja
    ├── xpack-dev-tools-arm-none-eabi-gcc -> /Users/ilg/Library/xPacks/@xpack-dev-tools/arm-none-eabi-gcc/10.2.1-1.1.2
    ├── xpack-dev-tools-cmake -> /Users/ilg/Library/xPacks/@xpack-dev-tools/cmake/3.19.2-2.1
    └── xpack-dev-tools-ninja-build -> /Users/ilg/Library/xPacks/@xpack-dev-tools/ninja-build/1.10.2-2.1

8 directories, 40 files
```

When later running actions like `xpm run build`, the `PATH` is automatically
adjusted to `xpacks/.bin:node_modules/.bin:$PATH`, so the exact versions
of the tools required in the dependencies list will be preferred over any
existing tools with the same names that might be present in the `PATH`.

### Binary xPacks are probably huge, aren't they?

Not at all; on the contrary, binary xPacks are very small, just a
`package.json` file, since they include only the URLs where the binaries
are actually stored (for example links to GitHub Releases), not the
binaries themselves.

## How do source xPacks work?

Even simpler. Let's assume that the 'xyz project' also needs the
µOS++ trace support, which is available as the source xPack
`@micro-os-plus/diag-trace`.

```console
$ xpm install @micro-os-plus/diag-trace --verbose
xPack manager - install package(s)

Processing @micro-os-plus/diag-trace@1.0.7...
Folder 'xpacks/micro-os-plus-diag-trace' linked to global '@micro-os-plus/diag-trace/1.0.7'.
Adding '@micro-os-plus/diag-trace' to 'dependencies'...

'xpm install' completed in 136 ms.
```

This results in another link in the `xpacks` folder
(mind the linearised package name):

```console
$ tree xpacks
xpacks
├── micro-os-plus-diag-trace -> /Users/ilg/Library/xPacks/@micro-os-plus/diag-trace/1.0.7
├── xpack-dev-tools-arm-none-eabi-gcc -> /Users/ilg/Library/xPacks/@xpack-dev-tools/arm-none-eabi-gcc/10.2.1-1.1.2
├── xpack-dev-tools-cmake -> /Users/ilg/Library/xPacks/@xpack-dev-tools/cmake/3.19.2-2.1
└── xpack-dev-tools-ninja-build -> /Users/ilg/Library/xPacks/@xpack-dev-tools/ninja-build/1.10.2-2.1

4 directories, 0 files
$ tree xpacks/micro-os-plus-diag-trace
xpacks/micro-os-plus-diag-trace
├── CHANGELOG.md
├── LICENSE
├── README.md
├── include
│   └── micro-os-plus
│       └── diag
│           └── trace.h
├── package.json
└── src
    └── trace.cpp

4 directories, 6 files
```

and the addition of a new dependency in `package.json`:

```json
{
  "name": "@<scope>/xyz",
  "version": "0.1.0",
  "...": "...",
  "dependencies": {
    "@micro-os-plus/diag-trace": "^1.0.7"
  },
  "devDependencies": {
    "@xpack-dev-tools/arm-none-eabi-gcc": "10.2.1-1.1.2",
    "@xpack-dev-tools/cmake": "3.19.2-2.1",
    "@xpack-dev-tools/ninja-build": "1.10.2-2.1",
    "liquidjs": "^9.23.3"
  },
  "xpack": {}
}
```

## Example

A real example is an embedded project that lists as dependencies
two source xPacks, one Node module and three binary xPacks:

```json
{
  "name": "h1b",
  "version": "1.0.0",
  "description": "An xPack with a blinky application running on HiFive1",
  "...": "...",
  "dependencies": {
    "@micro-os-plus/diag-trace": "^1.0.6",
    "@sifive/hifive1-board": "^1.0.3"
  },
  "devDependencies": {
    "xmake": "^0.3.9",
    "@gnu-mcu-eclipse/riscv-none-gcc": "^7.2.0-2.1",
    "@gnu-mcu-eclipse/openocd": "^0.10.0-7.1",
    "@gnu-mcu-eclipse/windows-build-tools": "^2.10.1"
  },
  "xpack": {
  }
}
```

The two source xPacks actually pull in six source xPacks, and the binary
xPacks contribute a lot of links to `xpacks/.bin`:

```console
$ cd /tmp/hifive1-blinky-cpp
$ xpm install --verbose
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

TODO: update for a more recent blinky project.

## Continuous Integration use cases

The high degree of automation provided by xpm is of great help
for automated test environments.

### GitHub Actions

For example, with the proper scripts configured, a multi-platform test
configuration for an xPack project may look like this:

```yml
name: CI on Push

on:
  push:

jobs:
  ci-test:
    name: 'CI tests'

    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        node-version: [14]
        # https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners
        os: [ubuntu-18.04, macos-10.15, windows-2019]

    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        fetch-depth: 3

    - name: Setup Node.js ${{ matrix.node-version }} on ${{ matrix.os }}
      # https://github.com/actions/setup-node
      uses: actions/setup-node@v2
      with:
        node-version: ${{ matrix.node-version }}

    - name: Install xpm on Linux/macOS
      if: runner.os != 'Windows'
      run: sudo npm install --global xpm@latest

    - name: Install xpm on Windows
      if: runner.os == 'Windows'
      run: npm install --global xpm@latest

    - name: Satisfy project dependencies
      run: xpm install --quiet

    - name: Run test
      run: xpm run test
```
