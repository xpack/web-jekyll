---
permalink: /intro/
title: xPack 101

summary: A npm module with an extra xpack property.
comments: true

date: 2019-06-26 08:57:00 +0300
last_updated: 2019-12-07 01:40:42 +0200

---

## Oh, no, not another package format!

This is probably the first thought many people might have when hearing about
xPacks. There are enough package formats and package manager,
why would we need another one?

Well, first, **xPacks** do not introduce a new package format, but use
exactly the same format as npm, and xPacks can be stored in the same
repositories.

And **xpm**, the package manager, builds on top of **npm**, the very popular
JavaScript package manager, extending it with new generic features,
so things are not that scary as they seemed initially.

## I'm perfectly happy with my development environment, why would I bother with xPacks?

The current development environments are indeed great, and rolling
distributions like Arch and Homebrew do a tremendous job in keeping the
system up-to-date, but not rarely the latest and greatest available versions
break older applications and various complex processes, like build
scripts, that depend on older versions.

**xPacks** are intended to solve exactly this problem, by providing
the simple and uniform solution of
installing different versions of the same package in different
folders, and managing dependencies.

## Why bothering to manage versions when auto-configure can sort out the differences?

The traditional way of dealing with different versions and variations between
systems is to add a complex auto-configure mechanism that is able to detect
which tools/components are present, which versions, and with
this input try to parametrise the process (for example a project build),
to accomodate for all these differences.

This approach started with GNU configure, and today use even more complex
solutions, like cMake or meson scripts.

Well, instead of permanently wondering how to make use of the new versions,
and making the auto-configure scripts more and more complex with every day,
why not allow the application to ask for the exact versions that are know
to be compatible, and let an automated tool handle the dependencies?

**xPacks** can do just this, bring in the project exactly the
versions needed, thus making the auto-configure step superfluos.

## But what are xPacks?

In brief, **xPacks** are general purpose multi-version software packages.

By **multi-version** it is understood not only that packages can have
multiple versions, but they **can be installed in parallel**, allowing each
project to have its own set of dependencies.

Based on the installed content, there are currently two
types of xPacks: **source** and **binary**:

- **source xPacks** are packages that install source files,
generally libraries used by the project.
- **binary xPacks** are packages that install binary files,
generally tools used during the build process, like toolchains,
builders, etc.

## Where does the name come from?

**xPack**, pronounced _**ɛks-pak**_, can be understood as _Universal Package_,
or _Any Type Package_, and tries to suggest that, when compared to
npm packages (which are basically about JavaScript), xPacks are more
general, and not linked/limited to a specific programming language.

Initially the _x_ came from _eXtended_, so _eXtended Packages_ can
be another choice.

## What exactly is an xPack?

The full definition is:

{% include callout.html content="An xPack is a folder which includes a
`package.json` file, defining at least
the package `name`, the package `version`, and an `xpack` object,
even empty." type="primary" %}

{% include note.html content="The name and version are mandatory
only when publishing the package or
installing it as a dependency. However it is recommended to
define them in all packages." %}

Given the direct inheritance from npm packages, a canonical
definition might be:

{% include callout.html content="An xPack is a npm package with
an additional `xpack` object defined in `package.json`." type="primary" %}

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
$ xpm init
xPack manager - create an xPack, empty or from a template
Creating project 'xyz'...
File 'package.json' generated.
File 'LICENSE' generated.

'xpm init' completed in 542 ms.
$ ls -l
total 16
-rw-r--r--  1 ilg  staff  1070 Jul  1 23:33 LICENSE
-rw-r--r--  1 ilg  staff   645 Jul  1 23:33 package.json
$ cat package.json
{
  "name": "xyz",
  "version": "1.0.0",
  "description": "An xPack with <your-description-here>",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/<user-id>/xyz.git"
  },
  "bugs": {
    "url": "https://github.com/<user-id>/xyz/issues"
  },
  "homepage": "https://github.com/<user-id>/xyz",
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

The two main reasons are:

- to automate dependencies management
- to automate path management for dependent tools

These are both simple and complicated things. To better understand
them, please continue to read how binary and source xPacks work.

## How do binary xPacks work?

Let's assume that 'my-awesome-project' needs the `arm-none-eabi-gcc`
toolchain to build,
and not any version but a specific one, like `8.2.1`; it also needs the
xPack Basic Builder, xpbuild.

```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "devDependencies": {
    "@xpack/xpbuild": "^1.2.3",
    "@xpack-dev-tools/arm-none-eabi-gcc": "^8.2.1"
  },
  "xpack": {}
}
```

{% include note.html content="The `^` used in the version field is
a npm/semver convention that means _compatible_, in other words the
highest version that does not change the major number, if available." %}

Running `xpm install` in the project folder will first install the toolchain
in the central xPack storage (a folder in user's home), then add a folder
`xpacks/.bin` and inside it create links (or `.cmd` stubs on Windows) to the
toolchain executables, like `xpacks/.bin/arm-none-eabi-gcc`.

TODO: show the output of tree on the xpacks folder.

Similarly for the builder, which is a Node.js CLI npm module, after
installing the module, npm will
add a folder `node_modules/.bin` where a link to the `xpbuild` executable
will be created (or a `xpbuild.cmd` stub on Windows).

TODO: show the output of tree on the node_modules folder.

When running actions like `npm run build`, the `PATH` is automatically
adjusted to `xpacks/.bin:node_modules/.bin:$PATH`, so the exact versions
of the tools required in the dependencies list will be preferred over any
existing tools with the same names that might be present in the `PATH`.

(Note: the package referred above are not yet available with
these names, do not try to use them yet.)

## Are binary xPacks huge?

Not at all; on the contrary, binary xPacks are very small, just a
`package.json` file, since they include only the URLs where the binaries
are actually stored (for example links to GitHub Releases), not the
binaries themselves.

## How do source xPacks work?

Even simpler. Let's assume that the 'awesome project' also needs the
µOS++ trace support, which is available as the source xPack
`@micro-os-plus/diag-trace`.

```json
{
  "name": "my-awesome-xpack",
  "version": "1.0.0",
  "dependencies": {
      "@micro-os-plus/diag-trace": "^1.0.6"
  },
  "devDependencies": {
    "@xpack/xpbuild": "^1.2.3",
    "@xpack-dev-tools/arm-none-eabi-gcc": "^8.2.1"
  },
  "xpack": {}
}
```

Running `xpm install` in the project folder will first install the
`@micro-os-plus/diag-trace` package, possibly with all other dependencies,
recursively.

Then xpm will add links to all dependent packages in the `xpacks` folder,
like `xpacks/micro-os-plus-diag-trace` (mind the linearised package name);
now the project can refer to
them as to any sub-folder local to the project.

TODO: show the output of tree on the xpacks folder.

## Example

A real example is an embedded project that lists as dependencies
two source xPacks, one Node module and three binary xPacks:

```js
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

## Continuous Integration use cases

The high degree of automation provided by xpm is of great help
for automated test environments.

### Travis

For example, with the proper scripts configured, the Travis configuration
for an xPack is as simple as this:

```yml
os:
  - linux

dist: trusty

language: node_js
node_js:
  - "node"

install:
  - npm install --global xpm

script:
  - xpm install
  - xpm run test
```
