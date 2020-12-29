---
title: The xpbuild.json files
permalink: /xpbuild/files/xpbuild-json/

date: 2017-10-09 16:46:00 +0300

---

## Overview

The `xpbuild.json` files define the metadata required by the
xpbuild build process.

As for any managed build system, the xpbuild process output is a
set of command lines to be passed to the builder.

To construct these command lines, the xpbuild metadata should be able to
provide the list of source files that enter the build, and all the details
required to fill in the command lines, which means compiler options,
symbols and included header files.

Example:

```json
{
  "version": "0.1.0",
  "name": "blinky",
  "buildConfigurations": {
    "debug": { 
      "targetPlatform": "stm32f4-discovery",
      "toolchain": "arm-none-eabi-gcc",
      "profiles": [
        "commonFolders",
        "gcc.warnings",
        "debug",
        "trace"
      ],
      "...": "..."
    },
    "release" {
      "targetPlatform": "stm32f4-discovery",
      "toolchain": "arm-none-eabi-gcc",
      "profiles": [
        "commonFolders",
        "gcc.warnings",
        "release"
      ],
      "...": "..."
    }
  }
}
```

TODO: consider the possibility to store the definitions in the `xcdl.json`,
actually to make xpbuild a subset of xpcdl.

## Generalities

### Terms

- **artefact**: the result of a build; it can be an executable or
  a library;
- **target platform**: the platform that the artefact is supposed to
  run on; usually a board or a physical machine, but can also be
  a synthetic one, like a POSIX process running on a GNU/Linux or
  macOS;
- **build configuration**: a complete group of definitions which
  result in an artefact;
  for simple projects they can be only `debug`/`release`; for
  complex projects there can be more, for different targets or,
  in test cases, even for different toolchains.

### Contexts

The `xpbuild.json` files can be used in two contexts:

- when located in the project root, or in a test folder, these files
must provide full details on how to build the artefacts; they must
have a mandatory `name` property.
- when located in sub-folders, these files are simpler and define build
details specific to the sub-folder, usually compiler options and/or symbols;
the files can be named like `folder-xpbuild.json`, or `.xpbuild.json`.

To include inner files, list them explicitly:

```
{
  "includeMetadata": [
    "some-folder/.xpbuild.json"
  ]
}
```

Inner files can include other files, at any depth.

{% include note.html content="Some sections may not strictly apply
to the `xpbuild.json` file and
should be moved to a more general document about xpbuild." %}

{% include note.html content="The posibility of automatically searching
for inner files was considered, and may be added in a future version,
but foor now an explicit use is prefered." %}

### Definitions hierarchy

To allow definitions reuse between multiple build configurations,
from a logical point of view the definitions can be seen as organised in
a hierarchy:

- top
- target platform
- toolchain
- build configuration

Each sub-level
is able to contribute new, more specific definitions,
to the parent.

### Add/remove

For each level of the hierarchy, internally the definitions are kept in
an ordered list. The common behaviour is to
copy definitions from the parent and add new definitions
to the end of the list; thus the `addXxxx` properties.

If a definition from the parent is definitely not wanted, the child can
instruct the builder to not copy it, using the `removeXxx` properties.

### Profiles

For complex projects, with multiple build configurations, it is usual
to have common definitions that occur in multiple build configurations.

To increase re-usability, it is possible to group definitions by profiles,
and to apply them to build configurations.

The definitions can be grouped by any criteria, but the common use case is
to define profiles for debug/release build configurations.

### Lower case names

All names must be composed from letters, hyphens, or digits.
When used to create paths, case is not significative and all
letters are converted to lower case.

### Paths

All paths use the POSIX syntax, with `/` separators.

### Macros

In certain places, strings may contain macros, with a syntax inspired by
the Liquid templates:

```bash
{{ expression }}
```

where _expression_ can be a name or a qualified name, like `test.name`.

### Build tree

Internally, the build tree is constructed of nodes.
Nodes refer to folders or files;
the build tree hierarchy follows the file system hierarchy.

Folder nodes may have other folders or file as children.

The build tree is constructed for each build configuration,
and inherits properties from target/toolchain/profiles.

Each new depth level may contribute additional compiler options to the build,
and files located deeper in the hierarchy may be compiled with different
settings (options, symbols, includes, etc).

### Project and/or test folders

To identify a folder as an xpbuild project, a full `xpbuild.json` file,
which includes the `name` field, is expected in the project root.

Tests are a specific kind of executable projects, and are also identified
by a full `xpbuild.json` in each test folder.


## Properties

As usual with JSON files, the definitions are organised as a hierarchy of
object with properties with values.

The values can be scalar (strings, numbers, boolean), arrays or objects. 

### Version

Type: string.

This semver string identifies the expected structure of the JSON content.

```json
{
  "version": "0.1.0"
}
```

It is mandatory for all `xpbuild.json` files. A recent version of the
xpbuild tools should be prepared to parse all older version of the
`xpbuild.json` files. An old version of the xpbuild tools
should throw an error when asked to process a newer, possibly
incompatible version of `xpbuild.json` file.

The version is also used to select a JSON schema during validation.

## name

Type: string.

This string defines the build name. It is mandatory for projects and
for tests.

```json
{
  "name": "xyz"
}
```

The build name is used to derive other names, like artefact names.

## artefact

Type: object.

Alias: `artifact`.

It can be used only in project or test `xpbuild.json` files; using it in folder
specific metadata files triggers an warning.

The `artefact` object defines the type and name of the output file.

The `type` property can be one of:

- `executable` (default)
- `staticLib` (default extension is `.a`)
- `sharedLib` (default extension is `.so` for Linux)

The `name` property defaults to the test name. It may include the macros
`{{ build.name }}` or `{{ test.name }}`. If not present, it defaults to the
mandatory project or test name.

The `artefact` object may be defined at top level, or for a given
target/profile. Each definition is searched hierarchically, bottom-up;
if present in the profile, it is used, otherwise the parent definition
it is used; if none is defined, a default is applied.

```json
{
  "artefact": {
    "type": "executable",
    "name": "${test.name}",
    "outputPrefix": "",
    "outputSuffix": "",
    "extension": ""
  }
}
```

## Builder

Type: string.

It can be used only in project or test `xpbuild.json` files; using it in folder
specific metadata files triggers an warning.

This string identifies the default builder used to create the project.

```json
{
  "builder": "make"
}
```

Currently only `make` and `ninja` are supported, but an internal builder
is also planned.

## Commands

Type: object.

It can be used only in project or test `xpbuild.json` files; using it in folder
specific metadata files triggers an warning.

The `commands` object associates external commands to different actions.

```json
{
  "commands": {
    "build": [ "make" ],
    "run": [ "./${artefact.fullName}" ]
  }
}
```

The actions are identified as object properties; the values are
arrays of strings with command lines.

When serialised, the values are string arrays; when parsed, the
values may be strings.

The `build` command is used to start the actual builder, after
the build files were generated.

The `run` command is used to run a test, after a successful build.
If the `run` command is missing in a test configuration, the test is
considered _build only_.

TODO: decide if really necessary.

## Source folders

Type: array of strings.

This array defines the paths to the folders containing source files.
All paths are relative to the current folder.

Source folders can be defined hierarchically (top/target/profile/toolchain),
for all configurations or for a specific target/profile/toolchain.

Definitions are cumulative, each may remove/add entries to the parent array.

For tests, which are located deeper in the file system hierarchy,
a typical configuration is:

```json
{
  "addSourceFolders": [
    "../../src",
    "."
  ]
}
```

If a definition from the parent is definitely not wanted, it can be removed:

```json
{
  "removeSourceFolders": [
    "lib"
  ]
}
```

If the definitions to be removed did not exist, warnings are issued.

For a given build, all source folders are searched for source files,
possible exclusions from `sourceFolderSettings` are processed, and the
remaining files enter the build.

If, for a given profile, this array ends up empty, and the current
folder includes a `package.json`, the
`directories.src` definition (an array of strings), if present, is used.
Otherwise, if the `src` folder is present, it is used; if not, the current
folder is used.

TODO: decide if these defaults are necessary, or prefer explicit defs.

When serialised, the values are string arrays; when parsed, the values
may be strings.

## Symbols

Type: array of strings.

This array defines symbols to be passed to the compiler preprocessor.
Simple names or pairs of names and values are accepted.

```json
{
  "addSymbols": [
    "GNU_SOURCE",
    "NAME=value"
  ]
}
```

Definitions are cumulative, each may remove/add entries to the parent array.

If a definition from the parent is definitely not wanted, it can be removed:

```json
{
  "removeSymbols": [
    "GNU_SOURCE"
  ]
}
```

If the definitions to be removed did not exist, warnings are issued.

When serialised, the values are string arrays; when parsed, the values
may be strings.

## Include folders

Type: array of strings.

This array defines the folders to be passed to the compiler as include
folders. All paths are relative to the current folder.

Include folders can be defined hierarchically (top/target/profile/toolchain),
for all configurations or for a specific target/profile/toolchain.

Definitions are cumulative, each may remove/add entries to the parent array.

```json
{
  "addIncludeFolders": [
    "include/xyz"
  ]
}
```

If a definition from the parent is definitely not wanted, it can be removed:

```json
{
  "removeIncludeFolders": [
    "include/abc"
  ]
}
```

If the definitions to be removed did not exist, warnings are issued.

If, for a given profile, this array ends up empty, and the current
folder includes a `package.json`, the
`directories.include` definition (an array of strings), if present, is used.
Otherwise, if the `include` folder is present, it is used; if not, the current
folder is used.

TODO: decide if these defaults are necessary, or prefer explicit defs.

When generating the build files, relative paths from the build folder
to the actual files are created.

When serialised, the values are string arrays; when parsed, the values
may be strings.

## Target platforms

Type: object.

The `targetPlatforms` object defines the possible targets, or platforms, the
artefact is to be build for.

Each target may include several profiles. (???)

Each target may contribute its own specific definitions to the common
definitions.

```json
{
  "targetPlatforms": {
    "darwin": {
      "artefact": { ... },
      "excludedPaths": [ ... ],
      "removeSourceFolders": [ ... ],
      "addSourceFolders": [ ... ],
      "removeSymbols": [ ... ],
      "addSymbols": [ ... ],
      "removeIncludeFolders": [ ... ],
      "addIncludeFolders": [ ... ],
      "toolchains": { ... },
    },
    "stm32f4-discovery": {
      "crossBuildPlatforms": [
        "darwin", "linux", "windows"
      ],
      "artefact": { ... },
      "excludedPaths": [ ... ],
      "removeSourceFolders": [ ... ],
      "addSourceFolders": [ ... ],
      "removeSymbols": [ ... ],
      "addSymbols": [ ... ],
      "removeIncludeFolders": [ ... ],
      "addIncludeFolders": [ ... ],
      "toolchains": { ... },
      }
    }
  }
}
```

The `excludedPaths` array defines folders and/or files that should
not be part of the build, for a specific target.

Target names are predefined strings.

TODO: explain where target names come from.

## Toolchains

Type: object.

The `toolchains` object defines the command line options used for each compiler.

Each toolchain may contribute its own specific definitions to the common
definitions.

```json
{
  "toolchains": {
    "gcc": {
      "artefact": { ... },
      "excludedPaths": [ ... ],
      "removeSourceFolders": [... ],
      "addSourceFolders": [ ... ],
      "removeSymbols": [ ... ],
      "addSymbols": [ ... ],
      "removeIncludeFolders": [ ... ],
      "addIncludeFolders": [ ... ],
      "common": { ... },
      "tools": { ... },
      "profiles": { ... }
    },
    "arm-none-eabi-gcc": {
      "artefact": { ... },
      "excludedPaths": [ ... ],
      "removeSourceFolders": [ ... ],
      "addSourceFolders": [ ... ],
      "removeSymbols": [ ... ],
      "addSymbols": [ ... ],
      "removeIncludeFolders": [ ... ],
      "addIncludeFolders": [ ... ],
      "common": { ... },
      "tools": { ... },
      "profiles": { ... }
    }
  }
}
```

The `excludedPaths` array defines folders and/or files that should
not be part of the build, for a specific toolchain.

Toolchain names are predefined strings.

TODO: explain where Toolchain names come from.

## Common

Type: object.

The `common` object defines settings common for all tools.

```json
{
  "common": {
    "removeTarget": [ ... ],
    "addTarget": [ "-mcpu=cortex-m3" ],
    "removeDebugging": [ "-g3" ],
    "addDebugging": [ "-g3" ],
    "removeOptimizations": [ ... ],
    "addOptimizations": [ "-O3" ],
    "removeWarnings": [ "-Wall" ],
    "addWarnings": [ "-Wall" ],
    "removeMiscellaneous": [ ... ],
    "addMiscellaneous": [ ... ]
  }
}
```

## Tools

Type: object.

The `tools` object defines specific settings for one or more tools.
When applied to a file, only one tool is significative, according
to the file extension.

```json
{
  "tools": {
    "c": {
      "removeSymbols": [ ... ],
      "addSymbols": [ ... ],
      "removeIncludes": [ ... ],
      "addIncludes": [ ... ],
      "removeDebugging": [ ... ],
      "addDebugging": [ ... ],
      "removeOptimizations": [ ... ],
      "addOptimizations": [ ... ],
      "removeWarnings": [ ... ],
      "addWarnings": [ ... ],
      "removeMiscellaneous": [ ... ],
      "addMiscellaneous": [ ... ]
    }
  }
}
```

When serialised, the values are string arrays; when parsed, the values
may be strings.

## Profiles

Type: object.

The `profiles` object defines the possible slightly different builds,
typically debug/release.

Each profile may contribute its own specific definitions to the common
definitions.

```json
{
  "profiles": {
    "debug": {
      "artefact": { ... },
      "excludedPaths": [ ... ],
      "removeSourceFolders": [ ... ],
      "addSourceFolders": [],
      "removeSymbols": [],
      "addSymbols": [],
      "addIncludeFolders": [],
      "removeIncludeFolders": [],
      "common": { ... },
      "tools": { ... }
    },
    "release": {
      "artefact": { ... },
      "excludedPaths": [],
      "removeSourceFolders": [],
      "addSourceFolders": [],
      "removeSymbols": [],
      "addSymbols": [],
      "addIncludeFolders": [],
      "removeIncludeFolders": [],
      "common": { ... },
      "tools": { ... }
    }
  }
}
```

The `excludedPaths` array defines folders and/or files that should
not be part of the build, for a specific profile.

Profile names are user defined strings.

## Folder/file specific metadata

The definitions in the top `xpbuild.json` file apply to all files that enter
the build.

However it is possible to enter specific definitions for folders, and
in this case they apply for all files in the folder, or for a specific file.

Two kinds of data can be defined:

- for source folders, a list of exclusions (folders and/or files)
- for source folders/files, possible different compiler settings.

The folder/file settings are not kept in the top file, but are distributed
in each folder, with file paths local to the folder.

```json
{
  "sourceFolderSettings": {
    "excludedPaths": [],
    "removeSymbols": [],
    "addSymbols": [],
    "removeIncludeFolders": [],
    "addIncludeFolders": [],
    "targets": { ... }
  },
  "sourceFilesSettings": {
    "xyzFilePath1": {
      "removeSymbols": [],
      "addSymbols": [],
      "removeIncludeFolders": [],
      "addIncludeFolders": [],
      "targets": { ... }
    },
    "xyzFilePath2": {
      "removeSymbols": [],
      "addSymbols": [],
      "removeIncludeFolders": [],
      "addIncludeFolders": [],
      "targets": { ... }
    }
  }
}
```

## Excluded paths

Type: array of strings.

The `excludedPaths` array defines folders and/or files that should
not be part of the build, for all configurations or for a specific
configuration.

```json
{
  "excludedPaths": [
    "mem1.c",
    "mem3.c"
  ]
}
```

Excluded paths are relative to the current folder, and should refer only to
files/folders in the current folder (in other words, a folder should
not define exclusion from a child folder).

## TODO

- add linker definitions
- add pre/post actions
