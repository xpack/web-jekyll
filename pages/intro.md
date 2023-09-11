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

## Nix also provides reproducible builds, plus lots of packages, why bother with xPacks?

[Nix](https://nixos.org) is a great project, and takes a very strict path
in controlling the
versions, down to the individual library. However, by design, it uses
links to files, which are not available (or are not reliable) on Windows,
thus Nix is currently available only on GNU/Linux and macOS.
Plus that the Nix language requires quite some efforts to master.

## Why npm could not be used as-is and why exactly was it necessary to invent xpm?

Because each package manager implements a strategy for managing dependencies.
npm/yarn/pnpm all implement various strategies specific to ECMAScript
dependencies.

Unfortunately these strategies do not work for other languages, like C/C++;
plus that it would be very difficult and require ugly hacks to accommodate
development dependencies to binary archives (for tools like compilers).

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
generally libraries used by the project
- **binary xPacks** are packages that install standalone relocatable
executables/binary
files, generally tools used during the build process, like toolchains,
builders, etc; standalone means they are self-contained and do not
depend on other shared libraries or tools; relocatable means they
can be installed in any location.

## Where does the name come from?

**xPack**, pronounced _**ɛks-pæk**_, can be understood as _Universal Package_,
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
% mkdir demo && cd demo
% xpm init --verbose
xPack manager - create an xPack, empty or from a template
Creating project 'demo'...
File 'package.json' generated.
File 'LICENSE' generated.

'xpm init' completed in 167 ms.
% ls -l
total 16
-rw-r--r--  1 ilg  staff  1070 Sep 11 13:22 LICENSE
-rw-r--r--  1 ilg  staff   822 Sep 11 13:22 package.json
% cat package.json
{
  "name": "@<scope>/demo",
  "version": "0.1.0",
  "description": "A source xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/<user-id>/demo.git"
  },
  "homepage": "https://github.com/<user-id>/demo/",
  "bugs": {
    "url": "https://github.com/<user-id>/demo/issues/"
  },
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
  "xpack": {
    "minimumXpmRequired": "0.16.3",
    "dependencies": {},
    "devDependencies": {},
    "properties": {},
    "actions": {},
    "buildConfigurations": {}
  }
}
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
and not any version but a specific one, like `12.2.1`; it also needs
the latest CMake, ninja and the liquidjs npm module.

For this, in the project folder, issue the following command, which
will install the required tools in a global xPacks store location, and add links
to them.

```console
% xpm install @xpack-dev-tools/arm-none-eabi-gcc@12.2.1-1.2.1 @xpack-dev-tools/cmake@latest @xpack-dev-tools/ninja-build@latest --verbose
xPack manager - install package(s)

Processing @xpack-dev-tools/arm-none-eabi-gcc@12.2.1-1.2.1...
Folder 'xpacks/@xpack-dev-tools/arm-none-eabi-gcc' linked to global '@xpack-dev-tools/arm-none-eabi-gcc/12.2.1-1.2.1'.
File 'xpacks/.bin/arm-none-eabi-addr2line' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-addr2line'.
File 'xpacks/.bin/arm-none-eabi-ar' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ar'.
File 'xpacks/.bin/arm-none-eabi-as' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-as'.
File 'xpacks/.bin/arm-none-eabi-c++' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++'.
File 'xpacks/.bin/arm-none-eabi-c++filt' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++filt'.
File 'xpacks/.bin/arm-none-eabi-cpp' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-cpp'.
File 'xpacks/.bin/arm-none-eabi-elfedit' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-elfedit'.
File 'xpacks/.bin/arm-none-eabi-g++' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-g++'.
File 'xpacks/.bin/arm-none-eabi-gcc' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc'.
File 'xpacks/.bin/arm-none-eabi-gcc-ar' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ar'.
File 'xpacks/.bin/arm-none-eabi-gcc-nm' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-nm'.
File 'xpacks/.bin/arm-none-eabi-gcc-ranlib' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ranlib'.
File 'xpacks/.bin/arm-none-eabi-gcov' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov'.
File 'xpacks/.bin/arm-none-eabi-gcov-dump' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-dump'.
File 'xpacks/.bin/arm-none-eabi-gcov-tool' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-tool'.
File 'xpacks/.bin/arm-none-eabi-gdb' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb'.
File 'xpacks/.bin/arm-none-eabi-gdb-add-index' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index'.
File 'xpacks/.bin/arm-none-eabi-gdb-add-index-py3' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index-py3'.
File 'xpacks/.bin/arm-none-eabi-gdb-py3' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-py3'.
File 'xpacks/.bin/arm-none-eabi-gfortran' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gfortran'.
File 'xpacks/.bin/arm-none-eabi-gprof' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gprof'.
File 'xpacks/.bin/arm-none-eabi-ld' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld'.
File 'xpacks/.bin/arm-none-eabi-ld.bfd' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld.bfd'.
File 'xpacks/.bin/arm-none-eabi-lto-dump' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-lto-dump'.
File 'xpacks/.bin/arm-none-eabi-nm' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-nm'.
File 'xpacks/.bin/arm-none-eabi-objcopy' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-objcopy'.
File 'xpacks/.bin/arm-none-eabi-objdump' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-objdump'.
File 'xpacks/.bin/arm-none-eabi-ranlib' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ranlib'.
File 'xpacks/.bin/arm-none-eabi-readelf' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-readelf'.
File 'xpacks/.bin/arm-none-eabi-size' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-size'.
File 'xpacks/.bin/arm-none-eabi-strings' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-strings'.
File 'xpacks/.bin/arm-none-eabi-strip' linked to '../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-strip'.
Adding '@xpack-dev-tools/arm-none-eabi-gcc' to 'devDependencies'...

Processing @xpack-dev-tools/cmake@3.26.5-1.1...
Folder 'xpacks/@xpack-dev-tools/cmake' linked to global '@xpack-dev-tools/cmake/3.26.5-1.1'.
File 'xpacks/.bin/ccmake' linked to '../@xpack-dev-tools/cmake/.content/bin/ccmake'.
File 'xpacks/.bin/cmake' linked to '../@xpack-dev-tools/cmake/.content/bin/cmake'.
File 'xpacks/.bin/cpack' linked to '../@xpack-dev-tools/cmake/.content/bin/cpack'.
File 'xpacks/.bin/ctest' linked to '../@xpack-dev-tools/cmake/.content/bin/ctest'.
Adding '@xpack-dev-tools/cmake' to 'devDependencies'...

Processing @xpack-dev-tools/ninja-build@1.11.1-3.1...
Folder 'xpacks/@xpack-dev-tools/ninja-build' linked to global '@xpack-dev-tools/ninja-build/1.11.1-3.1'.
File 'xpacks/.bin/ninja' linked to '../@xpack-dev-tools/ninja-build/.content/bin/ninja'.
Adding '@xpack-dev-tools/ninja-build' to 'devDependencies'...

'xpm install' completed in 5.760 sec.
% npm install liquidjs --save-dev

added 2 packages, and audited 3 packages in 2s

1 package is looking for funding
  run `npm fund` for details

found 0 vulnerabilities
%
```

This will also update the `package.json` with details about the dependencies:

```json
{
  "name": "@<scope>/demo",
  "version": "0.1.0",
  "description": "A source xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/<user-id>/demo.git"
  },
  "homepage": "https://github.com/<user-id>/demo/",
  "bugs": {
    "url": "https://github.com/<user-id>/demo/issues/"
  },
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
  "devDependencies": {
    "liquidjs": "^10.9.2"
  },
  "xpack": {
    "minimumXpmRequired": "0.16.3",
    "dependencies": {},
    "devDependencies": {
      "@xpack-dev-tools/arm-none-eabi-gcc": {
        "specifier": "12.2.1-1.2.1",
        "local": "link",
        "platforms": "all"
      },
      "@xpack-dev-tools/cmake": {
        "specifier": "3.26.5-1.1",
        "local": "link",
        "platforms": "all"
      },
      "@xpack-dev-tools/ninja-build": {
        "specifier": "1.11.1-3.1",
        "local": "link",
        "platforms": "all"
      }
    },
    "properties": {},
    "actions": {},
    "buildConfigurations": {}
  }
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
$ tree -a -L 3
.
├── LICENSE
├── node_modules
│   ├── .bin
│   │   ├── liquid -> ../liquidjs/bin/liquid.js
│   │   └── liquidjs -> ../liquidjs/bin/liquid.js
│   ├── .package-lock.json
│   ├── commander
│   │   ├── LICENSE
│   │   ├── Readme.md
│   │   ├── esm.mjs
│   │   ├── index.js
│   │   ├── lib
│   │   ├── package-support.json
│   │   ├── package.json
│   │   └── typings
│   └── liquidjs
│       ├── LICENSE
│       ├── README.md
│       ├── bin
│       ├── dist
│       └── package.json
├── package-lock.json
├── package.json
└── xpacks
    ├── .bin
    │   ├── arm-none-eabi-addr2line -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-addr2line
    │   ├── arm-none-eabi-ar -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ar
    │   ├── arm-none-eabi-as -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-as
    │   ├── arm-none-eabi-c++ -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++
    │   ├── arm-none-eabi-c++filt -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++filt
    │   ├── arm-none-eabi-cpp -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-cpp
    │   ├── arm-none-eabi-elfedit -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-elfedit
    │   ├── arm-none-eabi-g++ -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-g++
    │   ├── arm-none-eabi-gcc -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc
    │   ├── arm-none-eabi-gcc-ar -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ar
    │   ├── arm-none-eabi-gcc-nm -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-nm
    │   ├── arm-none-eabi-gcc-ranlib -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ranlib
    │   ├── arm-none-eabi-gcov -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov
    │   ├── arm-none-eabi-gcov-dump -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-dump
    │   ├── arm-none-eabi-gcov-tool -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-tool
    │   ├── arm-none-eabi-gdb -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb
    │   ├── arm-none-eabi-gdb-add-index -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index
    │   ├── arm-none-eabi-gdb-add-index-py3 -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index-py3
    │   ├── arm-none-eabi-gdb-py3 -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-py3
    │   ├── arm-none-eabi-gfortran -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gfortran
    │   ├── arm-none-eabi-gprof -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-gprof
    │   ├── arm-none-eabi-ld -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld
    │   ├── arm-none-eabi-ld.bfd -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld.bfd
    │   ├── arm-none-eabi-lto-dump -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-lto-dump
    │   ├── arm-none-eabi-nm -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-nm
    │   ├── arm-none-eabi-objcopy -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-objcopy
    │   ├── arm-none-eabi-objdump -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-objdump
    │   ├── arm-none-eabi-ranlib -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-ranlib
    │   ├── arm-none-eabi-readelf -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-readelf
    │   ├── arm-none-eabi-size -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-size
    │   ├── arm-none-eabi-strings -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-strings
    │   ├── arm-none-eabi-strip -> ../@xpack-dev-tools/arm-none-eabi-gcc/.content/bin/arm-none-eabi-strip
    │   ├── ccmake -> ../@xpack-dev-tools/cmake/.content/bin/ccmake
    │   ├── cmake -> ../@xpack-dev-tools/cmake/.content/bin/cmake
    │   ├── cpack -> ../@xpack-dev-tools/cmake/.content/bin/cpack
    │   ├── ctest -> ../@xpack-dev-tools/cmake/.content/bin/ctest
    │   └── ninja -> ../@xpack-dev-tools/ninja-build/.content/bin/ninja
    └── @xpack-dev-tools
        ├── arm-none-eabi-gcc -> /Users/ilg/Library/xPacks/@xpack-dev-tools/arm-none-eabi-gcc/12.2.1-1.2.1
        ├── cmake -> /Users/ilg/Library/xPacks/@xpack-dev-tools/cmake/3.26.5-1.1
        └── ninja-build -> /Users/ilg/Library/xPacks/@xpack-dev-tools/ninja-build/1.11.1-3.1

15 directories, 52 files
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
% xpm install @micro-os-plus/diag-trace --verbose
xPack manager - install package(s)

Processing @micro-os-plus/diag-trace@4.2.0...
Folder 'xpacks/@micro-os-plus/diag-trace' linked to global '@micro-os-plus/diag-trace/4.2.0'.
Adding '@micro-os-plus/diag-trace' to 'dependencies'...

'xpm install' completed in 2.129 sec.
```

This results in another link in the `xpacks` folder:

```console
xpacks
├── @micro-os-plus
│   └── diag-trace -> /Users/ilg/Library/xPacks/@micro-os-plus/diag-trace/4.2.0
└── @xpack-dev-tools
    ├── arm-none-eabi-gcc -> /Users/ilg/Library/xPacks/@xpack-dev-tools/arm-none-eabi-gcc/12.2.1-1.2.1
    ├── cmake -> /Users/ilg/Library/xPacks/@xpack-dev-tools/cmake/3.26.5-1.1
    └── ninja-build -> /Users/ilg/Library/xPacks/@xpack-dev-tools/ninja-build/1.11.1-3.1

7 directories, 0 files
% tree xpacks/@micro-os-plus/diag-trace
xpacks/@micro-os-plus/diag-trace
├── CHANGELOG.md
├── CMakeLists.txt
├── LICENSE
├── README.md
├── include
│   └── micro-os-plus
│       └── diag
│           └── trace.h
├── meson.build
├── package.json
├── src
│   └── trace.cpp
└── xpack.json

5 directories, 9 files
```

and the addition of a new dependency in `package.json`:

```json
{
  "name": "@<scope>/demo",
  "version": "0.1.0",
  "description": "A source xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/<user-id>/demo.git"
  },
  "homepage": "https://github.com/<user-id>/demo/",
  "bugs": {
    "url": "https://github.com/<user-id>/demo/issues/"
  },
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
  "devDependencies": {
    "liquidjs": "^10.9.2"
  },
  "xpack": {
    "minimumXpmRequired": "0.16.3",
    "dependencies": {
      "@micro-os-plus/diag-trace": {
        "specifier": "^4.2.0",
        "local": "link",
        "platforms": "all"
      }
    },
    "devDependencies": {
      "@xpack-dev-tools/arm-none-eabi-gcc": {
        "specifier": "12.2.1-1.2.1",
        "local": "link",
        "platforms": "all"
      },
      "@xpack-dev-tools/cmake": {
        "specifier": "3.26.5-1.1",
        "local": "link",
        "platforms": "all"
      },
      "@xpack-dev-tools/ninja-build": {
        "specifier": "1.11.1-3.1",
        "local": "link",
        "platforms": "all"
      }
    },
    "properties": {},
    "actions": {},
    "buildConfigurations": {}
  }
}
```

## Example

A real example is an embedded Cortex-M7 project that prints a _Hello World_
message via semihosting:

```console
ilg@wksi tmp % mkdir -p my-project && cd my-project
ilg@wksi my-project % xpm init --template @micro-os-plus/hello-world-qemu-template@latest --property target=cortex-m7f

Checking package @micro-os-plus/hello-world-qemu-template@latest metadata...
Processing @micro-os-plus/hello-world-qemu-template@1.4.1...

Creating the C++ project 'my-project'...
- target=cortex-m7f
- buildGenerator=cmake

Folder 'cmake' copied.
File 'CMakeLists.txt' generated.
File 'src/main.cpp' generated.
Folder 'include' copied.
Folder 'platform-qemu-cortex-m7f' copied.
File '.vscode/tasks.json' copied.
File '.vscode/settings.json' copied.
File '.clang-format' copied.
File 'README.md' generated.
File 'LICENSE' generated.
File 'package.json' generated.
ilg@wksi my-project %
```

The resulting project has the following `package.json`:

```json
{
  "name": "@my-scope/my-project",
  "version": "0.1.0",
  "description": "A source xPack with a semihosted Hello World application running on QEMU",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/ilg-ul/my-project.git"
  },
  "bugs": {
    "url": "https://github.com/ilg-ul/my-project/issues/"
  },
  "homepage": "https://github.com/ilg-ul/my-project/",
  "keywords": [
    "xpack"
  ],
  "author": {
    "name": "Liviu Ionescu",
    "email": "ilg@livius.net",
    "url": "https://github.com/ilg-ul/"
  },
  "license": "MIT",
  "config": {},
  "dependencies": {},
  "bundledDependencies": [],
  "devDependencies": {},
  "xpack": {
    "minimumXpmRequired": "0.14.0",
    "dependencies": {
      "@micro-os-plus/architecture-cortexm": "^6.2.0",
      "@micro-os-plus/devices-qemu-cortexm": "^4.1.1",
      "@xpack-3rd-party/arm-cmsis-core": "5.4.0-6",
      "@micro-os-plus/build-helper": "^2.11.0",
      "@micro-os-plus/diag-trace": "^4.1.1",
      "@micro-os-plus/semihosting": "^8.0.0",
      "@micro-os-plus/startup": "^5.2.0"
    },
    "devDependencies": {
      "@xpack-dev-tools/cmake": "3.21.6-1.1",
      "@xpack-dev-tools/ninja-build": "1.11.0-1.1",
      "@xpack-dev-tools/arm-none-eabi-gcc": "11.2.1-1.2.2",
      "@xpack-dev-tools/qemu-arm": "7.0.0-1.1"
    },
    "properties": {
    "buildFolderRelativePath": "{{ 'build' | path_join: configuration.name | to_filename | downcase }}",
      "buildFolderRelativePathPosix": "{{ 'build' | path_posix_join: configuration.name | downcase }}",
    "commandCMakePrepare": "{{ properties.commandCMakeReconfigure }} --log-level=VERBOSE",
      "commandCMakePrepareWithToolchain": "{{ properties.commandCMakePrepare }} -D CMAKE_TOOLCHAIN_FILE=xpacks/micro-os-plus-build-helper/cmake/toolchains/{{ properties.toolchainFileName }}",
      "commandCMakeReconfigure": "cmake -S . -B {{ properties.buildFolderRelativePathPosix }} -G Ninja -D CMAKE_BUILD_TYPE={{ properties.buildType }} -D PLATFORM_NAME={{ properties.platformName }} -D CMAKE_EXPORT_COMPILE_COMMANDS=ON",
      "commandCMakeBuild": "cmake --build {{ properties.buildFolderRelativePathPosix }}",
      "commandCMakeBuildVerbose": "cmake --build {{ properties.buildFolderRelativePathPosix }} --verbose",
      "commandCMakeClean": "cmake --build {{ properties.buildFolderRelativePathPosix }} --target clean",
      "commandCMakePerformTests": "cd {{ properties.buildFolderRelativePath }} && ctest -V"
    },
    "actions": {
      "test-qemu-cortex-m7f-cmake-debug": [
        "xpm run prepare --config qemu-cortex-m7f-cmake-debug",
        "xpm run build --config qemu-cortex-m7f-cmake-debug",
        "xpm run test --config qemu-cortex-m7f-cmake-debug"
      ],
      "test-qemu-cortex-m7f-cmake-release": [
        "xpm run prepare --config qemu-cortex-m7f-cmake-release",
        "xpm run build --config qemu-cortex-m7f-cmake-release",
        "xpm run test --config qemu-cortex-m7f-cmake-release"
      ],
      "test-all": [
        "xpm run test-qemu-cortex-m7f-cmake-debug",
        "xpm run test-qemu-cortex-m7f-cmake-release"
      ],
      "clean-all": [
        "xpm run clean --config qemu-cortex-m7f-cmake-debug",
        "xpm run clean --config qemu-cortex-m7f-cmake-release"
      ],
      "link-deps": [
        "xpm link @xpack-3rd-party/arm-cmsis-core --quiet",
        "xpm link @micro-os-plus/architecture-cortexm --quiet",
        "xpm link @micro-os-plus/devices-qemu-cortexm --quiet",
        "xpm link @micro-os-plus/startup --quiet",
        "xpm link @micro-os-plus/build-helper --quiet",
        "xpm link @micro-os-plus/diag-trace --quiet",
        "xpm link @micro-os-plus/semihosting --quiet"
      ]
    },
    "buildConfigurations": {
      "qemu-cortex-m7f-cmake-debug": {
        "properties": {
          "buildType": "Debug",
          "platformName": "qemu-cortex-m7f",
          "toolchainFileName": "arm-none-eabi-gcc.cmake"
        },
        "actions": {
        "prepare": "{{ properties.commandCMakePrepareWithToolchain }}",
          "build": [
            "{{ properties.commandCMakeReconfigure }}",
            "{{ properties.commandCMakeBuild }}"
          ],
          "test": "{{ properties.commandCMakePerformTests }}",
          "clean": "{{ properties.commandCMakeClean }}"
        }
      },
      "qemu-cortex-m7f-cmake-release": {
        "inherit": [
          "qemu-cortex-m7f-cmake-debug"
        ],
        "properties": {
          "buildType": "Release"
        }
      }
    }
  }
}
```

The next step is to install dependencies:

```console
ilg@wksi my-project % xpm install
@my-scope/my-project...
+ @micro-os-plus/startup@5.2.0
+ @micro-os-plus/semihosting@8.0.0
+ @micro-os-plus/diag-trace@4.1.1
+ @micro-os-plus/architecture-cortexm@6.2.0
+ @xpack-3rd-party/arm-cmsis-core@5.4.0-6
+ @micro-os-plus/build-helper@2.11.0
+ @micro-os-plus/devices-qemu-cortexm@4.1.1
+ @xpack-dev-tools/ninja-build@1.11.0-1.1
+ @xpack-dev-tools/cmake@3.21.6-1.1
+ @xpack-dev-tools/arm-none-eabi-gcc@11.2.1-1.2.2
+ @xpack-dev-tools/qemu-arm@7.0.0-1.1
'xpacks/micro-os-plus-semihosting' -> '/Users/ilg/Library/xPacks/@micro-os-plus/semihosting/8.0.0'
'xpacks/micro-os-plus-diag-trace' -> '/Users/ilg/Library/xPacks/@micro-os-plus/diag-trace/4.1.1'
'xpacks/xpack-3rd-party-arm-cmsis-core' -> '/Users/ilg/Library/xPacks/@xpack-3rd-party/arm-cmsis-core/5.4.0-6'
'xpacks/micro-os-plus-startup' -> '/Users/ilg/Library/xPacks/@micro-os-plus/startup/5.2.0'
'xpacks/micro-os-plus-architecture-cortexm' -> '/Users/ilg/Library/xPacks/@micro-os-plus/architecture-cortexm/6.2.0'
'xpacks/micro-os-plus-devices-qemu-cortexm' -> '/Users/ilg/Library/xPacks/@micro-os-plus/devices-qemu-cortexm/4.1.1'
'xpacks/xpack-dev-tools-ninja-build' -> '/Users/ilg/Library/xPacks/@xpack-dev-tools/ninja-build/1.11.0-1.1'
'xpacks/xpack-dev-tools-arm-none-eabi-gcc' -> '/Users/ilg/Library/xPacks/@xpack-dev-tools/arm-none-eabi-gcc/11.2.1-1.2.2'
'xpacks/micro-os-plus-build-helper' -> '/Users/ilg/Library/xPacks/@micro-os-plus/build-helper/2.11.0'
'xpacks/xpack-dev-tools-cmake' -> '/Users/ilg/Library/xPacks/@xpack-dev-tools/cmake/3.21.6-1.1'
'xpacks/xpack-dev-tools-qemu-arm' -> '/Users/ilg/Library/xPacks/@xpack-dev-tools/qemu-arm/7.0.0-1.1'
'xpacks/.bin/ninja' -> '../xpack-dev-tools-ninja-build/.content/bin/ninja'
'xpacks/.bin/arm-none-eabi-addr2line' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-addr2line'
'xpacks/.bin/ccmake' -> '../xpack-dev-tools-cmake/.content/bin/ccmake'
'xpacks/.bin/qemu-system-arm' -> '../xpack-dev-tools-qemu-arm/.content/bin/qemu-system-arm'
'xpacks/.bin/arm-none-eabi-ar' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ar'
'xpacks/.bin/cmake' -> '../xpack-dev-tools-cmake/.content/bin/cmake'
'xpacks/.bin/qemu-system-aarch64' -> '../xpack-dev-tools-qemu-arm/.content/bin/qemu-system-aarch64'
'xpacks/.bin/arm-none-eabi-as' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-as'
'xpacks/.bin/cpack' -> '../xpack-dev-tools-cmake/.content/bin/cpack'
'xpacks/.bin/qemu-system-gnuarmeclipse' -> '../xpack-dev-tools-qemu-arm/.content/bin/qemu-system-gnuarmeclipse'
'xpacks/.bin/arm-none-eabi-as-py3' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-as-py3'
'xpacks/.bin/ctest' -> '../xpack-dev-tools-cmake/.content/bin/ctest'
'xpacks/.bin/arm-none-eabi-c++' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++'
'xpacks/.bin/arm-none-eabi-c++filt' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-c++filt'
'xpacks/.bin/arm-none-eabi-cpp' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-cpp'
'xpacks/.bin/arm-none-eabi-elfedit' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-elfedit'
'xpacks/.bin/arm-none-eabi-g++' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-g++'
'xpacks/.bin/arm-none-eabi-gcc' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc'
'xpacks/.bin/arm-none-eabi-gcc-ar' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ar'
'xpacks/.bin/arm-none-eabi-gcc-nm' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-nm'
'xpacks/.bin/arm-none-eabi-gcc-ranlib' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcc-ranlib'
'xpacks/.bin/arm-none-eabi-gcov' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov'
'xpacks/.bin/arm-none-eabi-gcov-dump' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-dump'
'xpacks/.bin/arm-none-eabi-gcov-tool' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gcov-tool'
'xpacks/.bin/arm-none-eabi-gdb' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb'
'xpacks/.bin/arm-none-eabi-gdb-add-index' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index'
'xpacks/.bin/arm-none-eabi-gdb-add-index-py3' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-add-index-py3'
'xpacks/.bin/arm-none-eabi-gdb-py3' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gdb-py3'
'xpacks/.bin/arm-none-eabi-gfortran' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gfortran'
'xpacks/.bin/arm-none-eabi-gprof' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gprof'
'xpacks/.bin/arm-none-eabi-gprof-py3' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-gprof-py3'
'xpacks/.bin/arm-none-eabi-ld' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld'
'xpacks/.bin/arm-none-eabi-ld.bfd' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ld.bfd'
'xpacks/.bin/arm-none-eabi-lto-dump' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-lto-dump'
'xpacks/.bin/arm-none-eabi-nm' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-nm'
'xpacks/.bin/arm-none-eabi-objcopy' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-objcopy'
'xpacks/.bin/arm-none-eabi-objdump' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-objdump'
'xpacks/.bin/arm-none-eabi-ranlib' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-ranlib'
'xpacks/.bin/arm-none-eabi-readelf' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-readelf'
'xpacks/.bin/arm-none-eabi-size' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-size'
'xpacks/.bin/arm-none-eabi-strings' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-strings'
'xpacks/.bin/arm-none-eabi-strip' -> '../xpack-dev-tools-arm-none-eabi-gcc/.content/bin/arm-none-eabi-strip'
ilg@wksi my-project %
```

Finally, build and run the test:

```console
ilg@wksi my-project % xpm run test-qemu-cortex-m7f-cmake-debug
> xpm run prepare --config qemu-cortex-m7f-cmake-debug
> cmake -S . -B build/qemu-cortex-m7f-cmake-debug -G Ninja -D CMAKE_BUILD_TYPE=Debug -D PLATFORM_NAME=qemu-cortex-m7f -D CMAKE_EXPORT_COMPILE_COMMANDS=ON --log-level=VERBOSE -D CMAKE_TOOLCHAIN_FILE=xpacks/micro-os-plus-build-helper/cmake/toolchains/arm-none-eabi-gcc.cmake
-- The C compiler identification is GNU 11.2.1
-- The CXX compiler identification is GNU 11.2.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /Users/ilg/tmp/my-project/xpacks/.bin/arm-none-eabi-gcc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /Users/ilg/tmp/my-project/xpacks/.bin/arm-none-eabi-g++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- The ASM compiler identification is GNU
-- Found assembler: /Users/ilg/tmp/my-project/xpacks/.bin/arm-none-eabi-gcc
-- Including micro-os-plus-build-helper module...
-- CMake version: 3.21.6
-- Compiler: GNU 11.2.1
-- package.name: @my-scope/my-project
-- package.version: 0.1.0
-- Platform name: qemu-cortex-m7f
-- Build type: Debug
-- Project path: /Users/ilg/tmp/my-project
-- Build path: /Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug
-- Module path: /Users/ilg/tmp/my-project/xpacks/micro-os-plus-build-helper/cmake
-- CMAKE_C_COMPILER_ID: GNU
-- CMAKE_SYSTEM_NAME: Generic
-- CMAKE_SYSTEM_PROCESSOR: arm
-- Including global definitions...
-- Adding GCC warnings...
-- Including platform-qemu-cortex-m7f globals...
-- .G+ -I platform-qemu-cortex-m7f/include-config
-- .G+ -D $<$<CONFIG:Debug>:MICRO_OS_PLUS_DEBUG>
-- .G+ -D $<$<CONFIG:Debug>:MICRO_OS_PLUS_TRACE>
-- .G+ -D MICRO_OS_PLUS_INCLUDE_CONFIG_H
-- .G+ -D _POSIX_C_SOURCE=200809L
-- .G+ -fmessage-length=0
-- .G+ -fsigned-char
-- .G+ -ffunction-sections
-- .G+ -fdata-sections
-- .G+ -fdiagnostics-color=always
-- .G+ -Wall
-- .G+ -Waggregate-return
-- .G+ -Wcast-align
-- .G+ -Wcast-qual
-- .G+ -Wconversion
-- .G+ -Wdouble-promotion
-- .G+ -Wduplicated-branches
-- .G+ -Wduplicated-cond
-- .G+ -Wextra
-- .G+ -Wfloat-conversion
-- .G+ -Wfloat-equal
-- .G+ -Wformat-nonliteral
-- .G+ -Wformat-overflow=2
-- .G+ -Wformat-security
-- .G+ -Wformat-signedness
-- .G+ -Wformat-truncation=2
-- .G+ -Wformat-y2k
-- .G+ -Wformat=2
-- .G+ -Wlogical-op
-- .G+ -Wmissing-declarations
-- .G+ -Wmissing-include-dirs
-- .G+ -Wnull-dereference
-- .G+ -Wpacked
-- .G+ -Wpadded
-- .G+ -Wpointer-arith
-- .G+ -Wredundant-decls
-- .G+ -Wshadow
-- .G+ -Wshift-overflow=2
-- .G+ -Wsign-conversion
-- .G+ -Wswitch-default
-- .G+ -Wswitch-enum
-- .G+ -Wundef
-- .G+ -Wuninitialized
-- .G+ -Wvla
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wbad-function-cast>
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wc++-compat>
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wduplicate-decl-specifier>
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wmissing-prototypes>
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wnested-externs>
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wold-style-definition>
-- .G+ $<$<COMPILE_LANGUAGE:C>:-Wstrict-prototypes>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wctor-dtor-privacy>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wnoexcept>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wold-style-cast>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Woverloaded-virtual>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wplacement-new=2>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wregister>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wsign-promo>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wstrict-null-sentinel>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-final-methods>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-final-types>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-override>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wuseless-cast>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wzero-as-null-pointer-constant>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wextra-semi>
-- .G+ -Warith-conversion
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wcomma-subscript>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wredundant-tags>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wvolatile>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-Wmismatched-tags>
-- .G+ -mcpu=cortex-m7
-- .G+ -mthumb
-- .G+ -mfloat-abi=hard
-- .G+ -Werror
-- .G+ $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
-- .G+ $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
-- Adding 'xpacks/micro-os-plus-architecture-cortexm'...
-- Processing xPack @micro-os-plus/architecture-cortexm@6.2.0...
-- > micro-os-plus-architecture-cortexm-interface
-- + -I include
-- > micro-os-plus::architecture-cortexm -> micro-os-plus-architecture-cortexm-interface
-- > micro-os-plus::architecture -> micro-os-plus-architecture-cortexm-interface
-- Adding 'xpacks/micro-os-plus-devices-qemu-cortexm'...
-- Processing xPack @micro-os-plus/devices-qemu-cortexm@4.1.1...
-- > micro-os-plus-devices-qemu-cortexm-interface
-- + -I include
-- + src/reset-handler.c
-- + src/system-cortexm.c
-- + src/vectors-cortexm.c
-- + src/exception-handlers.cpp
-- + -D DEVICE_QEMU_CORTEX_M7
-- + xpack-3rd-party::arm-cmsis-core-m
-- > micro-os-plus::devices-qemu-cortexm -> micro-os-plus-devices-qemu-cortexm-interface
-- > micro-os-plus::device -> micro-os-plus-devices-qemu-cortexm-interface
-- Adding 'xpacks/micro-os-plus-diag-trace'...
-- Processing xPack @micro-os-plus/diag-trace@4.1.1...
-- > micro-os-plus-diag-trace-interface
-- + -I include
-- + src/trace.cpp
-- > micro-os-plus::diag-trace -> micro-os-plus-diag-trace-interface
-- Adding 'xpacks/micro-os-plus-semihosting'...
-- Processing xPack @micro-os-plus/semihosting@8.0.0...
-- > micro-os-plus-semihosting-interface
-- + -I include
-- + src/semihosting-startup.cpp
-- + src/semihosting-syscalls.cpp
-- + src/semihosting-trace.cpp
-- + micro-os-plus::diag-trace
-- + micro-os-plus::architecture
-- > micro-os-plus::semihosting -> micro-os-plus-semihosting-interface
-- Adding 'xpacks/micro-os-plus-startup'...
-- Processing xPack @micro-os-plus/startup@5.2.0...
-- > micro-os-plus-startup-interface
-- + -I include
-- + src/startup.cpp
-- + src/exit.c
-- + src/_sbrk.c
-- + micro-os-plus::diag-trace
-- + micro-os-plus::architecture
-- > micro-os-plus::startup -> micro-os-plus-startup-interface
-- Adding 'xpacks/xpack-3rd-party-arm-cmsis-core'...
-- Processing xPack @xpack-3rd-party/arm-cmsis-core@5.4.0-6...
-- > xpack-3rd-party-arm-cmsis-core-m-interface
-- + -I CMSIS/Core/Include
-- + -D __PROGRAM_START
-- > xpack-3rd-party::arm-cmsis-core-m -> xpack-3rd-party-arm-cmsis-core-m-interface
-- > xpack-3rd-party-arm-cmsis-core-a-interface
-- + -I CMSIS/Core_A/Include
-- + -D __PROGRAM_START
-- > xpack-3rd-party::arm-cmsis-core-a -> xpack-3rd-party-arm-cmsis-core-a-interface
-- > hello-world-interface
-- + -I include
-- + src/main.cpp
-- > app::hello-world -> hello-world-interface
-- Processing 'platform-qemu-cortex-m7f'...
-- > platform-qemu-cortex-m7f-interface
-- + -I include-platform
-- + -D PLATFORM_QEMU_CORTEX_M7F
-- + micro-os-plus::devices-qemu-cortexm
-- > micro-os-plus::platform -> platform-qemu-cortex-m7f-interface
-- A> hello-world
-- Configuring done
-- Generating done
-- Build files have been written to: /Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug
> xpm run build --config qemu-cortex-m7f-cmake-debug
> cmake -S . -B build/qemu-cortex-m7f-cmake-debug -G Ninja -D CMAKE_BUILD_TYPE=Debug -D PLATFORM_NAME=qemu-cortex-m7f -D CMAKE_EXPORT_COMPILE_COMMANDS=ON
-- Configuring done
-- Generating done
-- Build files have been written to: /Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug
> cmake --build build/qemu-cortex-m7f-cmake-debug
[13/13] Linking CXX executable platform-bin/hello-world.elf
   text	   data	    bss	    dec	    hex	filename
 355436	   4744	   8856	 369036	  5a18c	/Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug/platform-bin/hello-world.elf
> xpm run test --config qemu-cortex-m7f-cmake-debug
> cd build/qemu-cortex-m7f-cmake-debug && ctest -V
UpdateCTestConfiguration  from :/Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug/DartConfiguration.tcl
UpdateCTestConfiguration  from :/Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug/DartConfiguration.tcl
Test project /Users/ilg/tmp/my-project/build/qemu-cortex-m7f-cmake-debug
Constructing a list of tests
Done constructing a list of tests
Updating test list for fixtures
Added 0 tests to meet fixture requirements
Checking test dependency graph...
Checking test dependency graph end
test 1
    Start 1: hello-world

1: Test command: /Users/ilg/tmp/my-project/xpacks/.bin/qemu-system-arm "--machine" "mps2-an500" "--cpu" "cortex-m7" "--kernel" "hello-world.elf" "--nographic" "-d" "unimp,guest_errors" "--semihosting-config" "enable=on,target=native,arg=hello-world,arg=M7"
1: Test timeout computed to be: 10000000
1:
1: µOS++ IIIe version 7.x
1: Copyright (c) 2007-2022 Liviu Ionescu
1: Built with GCC 11.2.1 20220111, with FP, with exceptions, with MICRO_OS_PLUS_DEBUG
1:
1: Heap: @0x20002CB0 (8178 KiB)
1: micro_os_plus_run_init_array()
1: main(argc=2, argv=["hello-world", "M7"])
1:
1: Hello M7 World!
1: (in debug mode)
1:
1: exit(0)
1: micro_os_plus_run_fini_array()
1: _Exit(0)
1:
1: Hasta la vista!
1/1 Test #1: hello-world ......................   Passed    0.75 sec

100% tests passed, 0 tests failed out of 1

Total Test time (real) =   0.75 sec
ilg@wksi my-project %
```
