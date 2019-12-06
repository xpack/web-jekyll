---
title: xmake build - Build one or more configurations
permalink: /xmake/cli/xmake-build/

summary: DEPRECATED! See xpbuild.

date: 2017-10-09 13:06:00 +0300
last_updated: 2019-12-06 22:15:35 +0200

---

DEPRECATED!

Generate the build files and build.

## Synopsis

```
xmake build [--target <name>]* [--toolchain <name>]* [--profile <name>]* [-- <args>]
```

Aliases:
- `b`
- `bild`

## Description

This command expects an `xmake.json` file in the CWD, to define the
build configurations.

A **build configuration** is a triplet (target, toolchain, profile).

For each configuration, `xmake build` creates a sub-folder in the CWD,
named `build/<name>-<target>-<toolchain>-<profile>`.

If multiple names are defined for target/toolchain/profile, a
matrix of configurations is constructed.

All names must be letters, hyphens, or digits. When used to
create paths, all letters are converted to lower case.

After generating the build folders, the native builder (like `make`)
is invoked with the extra arguments.

## Examples

```console
$ cd xyz-xpack.git
$ xmake build -- clean all
```

When executed, this command creates sub-folders like `darwin-clang-debug` and
`darwin-clang-release` and invokes `make` in each folder
to run the actual build.

