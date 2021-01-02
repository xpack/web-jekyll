---
title: The xPack Build Definitions
permalink: /metadata/build/

summary: The metadata used by the build tools.

date: 2017-10-09 16:46:00 +0300

---
## Overview

This document describes the metadata required by the build tools; 
it is stored in `xbuild.json` files.

The formal definition is available in the JSON schema
[xbuild-0.3.0.json]({{ site.baseurl }}/metadata/xbuild-0.3.0.json).

As for any managed build system, the result of the xPack build generator
process is a set of command lines to be passed to the builder.

To construct these command lines, the metadata files should
provide:

- a way to construct the list of source files that enter the build
- a method to select a tool to use to process the source files
- all the details required to fill in the command lines (compiler options,
defined symbols, folders with header files, etc).

A typical blinky project would look like:

{% raw %}
```json
{
  "schemaVersion": "0.3.0",
  "includeMetadata": [
    "xpacks/toolchains-metadata/toolchains-gcc-xbuild.json"
  ],
  "description": "STM32F4DISCOVERY Blinky project",
  "name": "blinky",
  "buildConfigurations": {
    "debug": { 
      "target": { 
        "platform": "stm32f4-discovery"
      },
      "toolsCollections": [ 
        "xpack-arm-none-eabi-gcc"
      ],
      "language": "c++",
      "builder": "ninja",
      "addSourcePaths": [
        "src"
      ],
      "removeSourcePaths": [
        "src/stm32f4-hal/stm32f4xx_ll_utils.c",
        "src/stm32f4-hal/stm32f4xx_ll_usb.c"
      ],
      "toolsSettings": {
        "c-compiler": {
          "addOptions": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft",
            "-g3",
            "-Wall",
            "-Wextra",
            "-O0",
            "-std=gnu11",
            "-fmessage-length=0",
            "-fsigned-char",
            "-ffunction-sections", 
            "-fdata-sections",
            "-DDEBUG",
            "-DTRACE",
            "-DUSE_FULL_ASSERT",
            "-DOS_USE_TRACE_SEMIHOSTING_DEBUG",
            "-DSTM32F407xx",
            "-DPLATFORM_STM32F4_DISCOVERY",
            "-DUSE_HAL_DRIVER",
            "-DHSE_VALUE=8000000",
            "-DOS_USE_SEMIHOSTING",
            "-I{{ project.absolutePath }}/include",
            "-I{{ project.absolutePath }}/system/include",
            "-I{{ project.absolutePath }}/system/include/cmsis",
            "-I{{ project.absolutePath }}system/include/stm32f4-hal"
          ]
        },
        "cpp-compiler": {
          "addOptions": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft",
            "-g3",
            "-Wall",
            "-Wextra",
            "-O0",
            "-std=gnu++11", 
            "-fabi-version=0",
            "-fno-exceptions", 
            "-fno-rtti", 
            "-fno-use-cxa-atexit", 
            "-fno-threadsafe-statics",
            "-fmessage-length=0",
            "-fsigned-char",
            "-ffunction-sections", 
            "-fdata-sections",
            "-DDEBUG",
            "-DTRACE",
            "-DUSE_FULL_ASSERT",
            "-DOS_USE_TRACE_SEMIHOSTING_DEBUG",
            "-DSTM32F407xx",
            "-DPLATFORM_STM32F4_DISCOVERY",
            "-DUSE_HAL_DRIVER",
            "-DHSE_VALUE=8000000",
            "-DOS_USE_SEMIHOSTING",
            "-I{{ project.absolutePath }}/include",
            "-I{{ project.absolutePath }}/system/include",
            "-I{{ project.absolutePath }}/system/include/cmsis",
            "-I{{ project.absolutePath }}system/include/stm32f4-hal"
          ]
        },
        "cpp-linker": {
          "addOptions": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft",
            "-g3",
            "-Wall",
            "-Wextra",
            "-O0",
            "-std=gnu11",
            "-fmessage-length=0",
            "-fsigned-char",
            "-ffunction-sections", 
            "-fdata-sections",
            "-Wl,--gc-sections",
            "-T{{ project.absolutePath }}/linker-scripts/mem.ld", 
            "-T{{ project.absolutePath }}/linker-scripts/sections.ld",
            "-nostartfiles", 
            "-Wl,-Map,\"{{ artefact.name }}.map\"",
            "--specs=nano.specs"
          ]
        }
      }
    },
    "release": {
      "target": { 
        "platform": "stm32f4-discovery"
      },
      "toolsCollections": [ 
        "xpack-arm-none-eabi-gcc"
      ],
      "language": "c++",
      "builder": "ninja",
      "addSourcePaths": [
        "src"
      ],
      "removeSourcePaths": [
        "src/stm32f4-hal/stm32f4xx_ll_utils.c",
        "src/stm32f4-hal/stm32f4xx_ll_usb.c"
      ],
      "toolsSettings": {
        "c-compiler": {
          "addOptions": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft",
            "-g3",
            "-Wall",
            "-Wextra",
            "-Os",
            "-std=gnu11",
            "-fmessage-length=0",
            "-fsigned-char",
            "-ffunction-sections", 
            "-fdata-sections",
            "-DNDEBUG",
            "-DSTM32F407xx",
            "-DPLATFORM_STM32F4_DISCOVERY",
            "-DUSE_HAL_DRIVER",
            "-DHSE_VALUE=8000000",
            "-DOS_USE_SEMIHOSTING",
            "-I{{ project.absolutePath }}/include",
            "-I{{ project.absolutePath }}/system/include",
            "-I{{ project.absolutePath }}/system/include/cmsis",
            "-I{{ project.absolutePath }}system/include/stm32f4-hal"
          ]
        },
        "cpp-compiler": {
          "addOptions": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft",
            "-g3",
            "-Wall",
            "-Wextra",
            "-Os",
            "-std=gnu++11", 
            "-fabi-version=0",
            "-fno-exceptions", 
            "-fno-rtti", 
            "-fno-use-cxa-atexit", 
            "-fno-threadsafe-statics",
            "-fmessage-length=0",
            "-fsigned-char",
            "-ffunction-sections", 
            "-fdata-sections",
            "-DNDEBUG",
            "-DSTM32F407xx",
            "-DPLATFORM_STM32F4_DISCOVERY",
            "-DUSE_HAL_DRIVER",
            "-DHSE_VALUE=8000000",
            "-DOS_USE_SEMIHOSTING",
            "-I{{ project.absolutePath }}/include",
            "-I{{ project.absolutePath }}/system/include",
            "-I{{ project.absolutePath }}/system/include/cmsis",
            "-I{{ project.absolutePath }}system/include/stm32f4-hal"
          ]
        },
        "cpp-linker": {
          "addOptions": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft",
            "-g3",
            "-Wall",
            "-Wextra",
            "-Os",
            "-std=gnu11",
            "-fmessage-length=0",
            "-fsigned-char",
            "-ffunction-sections", 
            "-fdata-sections",
            "-Wl,--gc-sections",
            "-T{{ project.absolutePath }}/linker-scripts/mem.ld", 
            "-T{{ project.absolutePath }}/linker-scripts/sections.ld",
            "-nostartfiles", 
            "-Wl,-Map,\"{{ artefact.name }}.map\"",
            "--specs=nano.specs"
          ]
        }
      }
    }
  }
}
```
{% endraw %}

As it can be seen, tools and build configurations have many options
in common, and this is only a simple example.

A more structured and less redundant example would use profiles and look like:

{% raw %}
```json
{
  "schemaVersion": "0.3.0",
  "includeMetadata": [
    "xpacks/toolchains-metadata/toolchains-gcc-xbuild.json",
    "xpacks/toolchains-metadata/profiles-gcc-xbuild.json"
  ],
  "name": "blinky",
  "buildConfigurations": {
    "debug": { 
      "target": { 
        "platform": "stm32f4-discovery"
      },
      "toolsCollections": [ 
        "xpack-arm-none-eabi-gcc"
      ],
      "language": "c++",
      "builder": "ninja",
      "addProfiles": [
        "project-common-defs",
        "gcc-optimize-none",
        "gcc-gc-sections",
        "gcc-warnings-all",
        "gcc-debug",
        "gcc-trace"
      ],
      "toolsSettings": {
        "(asembler|*-compiler)": {
          "addDefinedSymbols": [
            "USE_FULL_ASSERT",
            "OS_USE_TRACE_SEMIHOSTING_DEBUG"
          ]
        },
      }
    },
    "release": {
      "target": { 
        "platform": "stm32f4-discovery"
      },
      "toolsCollections": [ 
        "xpack-arm-none-eabi-gcc"
      ],
      "language": "c++",
      "builder": "ninja",
      "addProfiles": [
        "project-common-defs",
        "gcc-optimize-small",
        "gcc-gc-sections",
        "gcc-warnings-all",
        "gcc-release"
      ]
    }
  },
  "profiles": {
    "project-common-defs": {
      "addSourcePaths": [
        "src"
      ],
      "removeSourcePaths": [
        "src/stm32f4-hal/stm32f4xx_ll_utils.c",
        "src/stm32f4-hal/stm32f4xx_ll_usb.c"
      ],
      "toolsSettings": {
        "(asembler|*-compiler)": {
          "addIncludeFolders": [
            "include"
          ],
          "addDefinedSymbols": [
            "STM32F407xx",
            "PLATFORM_STM32F4_DISCOVERY",
            "USE_HAL_DRIVER",
            "HSE_VALUE=8000000",
            "OS_USE_SEMIHOSTING"
          ]
        },
        "(asembler|*-compiler|*-linker)": {
          "addArchitecture": [
            "-mcpu=cortex-m4",
            "-mthumb",
            "-mfloat-abi=soft"
          ],
          "addOptimizations": [
            "-std=gnu11",
            "-fmessage-length=0",
            "-fsigned-char",
            "-fno-move-loop-invariants"
          ]
        },
        "(cpp-compiler|cpp-linker)": {
          "addOptimizations": [
            "-std=gnu++11", 
            "-fabi-version=0",
            "-fno-exceptions", 
            "-fno-rtti", 
            "-fno-use-cxa-atexit", 
            "-fno-threadsafe-statics"
          ]
        },
        "(*-linker)": {
          "addLinkerScripts": [
            "linker-scripts/mem.ld", 
            "linker-scripts/sections.ld"
          ],
          "addMiscellaneous": [
            "-nostartfiles", 
            "-Wl,-Map,\"{{ artefact.name }}.map\"",
            "--specs=nano.specs"
          ]
        }
      }
    }
  }
}
```
{% endraw %}

## Generalities

### Definitions

- **artefact**: the result of a build; in the first implementation it
  can be an executable or a library;
- **target platform**: the platform that the artefact is supposed to
  run on; usually a board or a physical machine, but can also be
  a synthetic platform, like a POSIX process running on a GNU/Linux or
  macOS system;
- **build configuration**: a complete group of definitions which
  result in an artefact; build configuration names, including those
  used for tests, must be unique;
  for simple projects usualy there are only two top configurations,
  `debug`/`release`; for
  complex projects there can be more, for different targets or,
  in test cases, even for different toolchains;
- **toolsCollections**: collections of tools, usually toolchains.

### Contexts

The `*xbuild.json` files can be located in multiple contexts:

- package root folder
- test root folder
- sub-folders

When xPack aware tools start, they read in all `*xpack.json` files
located in the project root folder. If needed, these top files
can include files from any sub-folders, local to the project or from
dependencies.
Multiple occurences of the same definitions trigger warnings and are
ignored.

Inner files can include other files, at any depth.

Example:

```json
{
  "includeMetadata": [
    "sub-folder/.xbuild.json"
  ]
}
```

{% include note.html content="As in other parts of the xPack design,
explicit includes were prefered to an automatic discovery process." %}

### Definitions hierarchies

The main object used to store the settings to be used during
a build is the **build configuration**.

Most projects have at least two build configurations, very similar
except minor details; in order to
avoid redundacy and to maintain consistency, some definitions can be defined
separately in profiles that can be later applied to multiple build
configurations (see below).

For each build configuration, the build process
constructs a tree with folder and files nodes,
which follow the file system hierarchy.

The file nodes are leaves in this tree, while folder nodes may
have other children.

Each new sub-level may contribute additional compiler options to the build,
such that files located deeper in the hierarchy may be compiled with different
settings (options, symbols, includes, etc).

### Add/remove

For each node of the hierarchy, the definitions are kept in
ordered lists. The common behaviour when creating a new node is to
copy the definitions from the parent and append the new definitions
to the end of the list; thus the `addOptions` properties.

If a definition from the parent is not needed, the child can
instruct the builder to not copy it, by using the `removeOptions` properties.

### Profiles

For complex projects, with multiple build configurations, it is usual
to have common definitions that occur in multiple build configurations.

To increase re-usability, it is possible to group definitions by _profiles_,
and to apply them to build configurations.

The definitions can be grouped by any criteria; usual examples are
profiles with compiler options specific to debug/release build
configurations, or profiles with various compiler optimisations,
warnings, supported standards, etc.

Profiles can be stored in separate packages, and reused in multiple
projects.

### Project and/or test folders

To identify a folder as an xPack build project, a full `xbuild.json` file,
which includes the `build.name` property, is expected in the project root.

Tests are a specific kind of executable projects, and are also identified
by a full `xbuild.json` in each test folder.

## Objects

The `xbuild.json` file is a hierarchy of objects with properties,
with the JSON root on top.

### The root object

| Properties | Type | Description |
|:-----------|:-----|:------------|
| `schemaVersion` | string | The version in [semver](https://semver.org) format, that identifies the expected structure of the JSON content. |
| `name` | string | The build name. It is mandatory for projects and for tests. |
| `builder` | string | The default builder name. |
| `license` | string | The license used to distribute the file. |
| `copyright` | string | The copyright owner. |
| `description` | string | A short sentence describing the content of the file. May be displayed by tools processing the file. |
| `$comment` | string | A place to keep internal notices. |
| `includeMetadata` | string[] | An array of path relative to the location of the file. |
| `buildConfigurations` | collection | A map of build configurations. |

#### The **schemaVersion** property

The `schemaVersion` is used by parsers to dinamically adapt to different
file format versions; changes in the schema or in the semantics should be
reflected in a different version.

The `schemaVersion` property is mandatory for all `*xbuild.json` files.
A recent version of the
xPack aware tools should be prepared to parse all older version of the
`*xbuild.json` files. When asked to process a newer, possibly
incompatible, version of an `*xbuild.json` file, the tools
that do not reconise that version should throw an error.

The version is also used to select a JSON schema during validation.

Example:

```json
{
  "schemaVersion": "0.3.0"
}
```

#### The **name** property

The build name is used to create other names, like artefact names.

Example:

```json
{
  "name": "xyz"
}
```

#### The **builder** property

The `builder` property identifies the default builder used to create the
artefact.

It can be used only in project or test `*xbuild.json` files; using it in folder
specific metadata files triggers an warning.

Currently only `ninja`, `make` and `internal` are supported, with the
internal builder not yet available.

The default value is `internal`, which, for now, means that the builder must
be explicitly defined, or passed on the command line.

Example:

```json
{
  "builder": "ninja"
}
```

### The _includeMetadata_ array

To facilitate reuse of definitions, it is possible to collect them
from multiple files.

Included files may include other files, at any depth.

The location of each file is remembered, such that relative paths used
in each files can be correctly processed.

Contributions to maps/arrays are appended at the end; inner files are
processed before the current file.

Example:

```json
{
  "includeMetadata": [
    "xpacks/toolchains-metadata/toolchains-gcc-xbuild.json",
    "xpacks/toolchains-metadata/profiles-gcc-xbuild.json"
  ]
}
```

## The _buildConfiguration_ object

**Build configurations** are objects used to collect all the definitions
required to generate the builder files required to build the artefact from
the source file.

The definitions are mainly command line options to be passed to various tools.
They can be in-lined or copied from multiple _profiles_.

The build processes an array of paths, posibly with exclusions.

Source files in inner folders may be configured with specific options,
for example with extra `-Wno-xxx` options to disable some warnings.

| Parent |
|:-------|
| The root object. |

| Properties | Type | Description |
|:-----------|:-----|:------------|
| `target` | object | The target platform/device/etc. |
| `builder` | string | The default builder name; overrides the top definition. |
| `language` | string | The programming language (c/c++); overrides the top definition. |
| `artefact` | object | The name and type of the artefact to be built. |
| `addSourcePaths` | string[] | Array of paths to source files, or paths to folders with source files, to be added to the build.|
| `removeSourcePaths` | string[] | Array of paths to be excluded from the build.|
| `addProfiles` | string[] | Array of profile names to be added before the current definitions.|
| `toolsSettings` | collection | Map of settings to be added for different tools. |
| `sourceFoldersSettings` | collection | Map of settings to be added for a specific sub-folder. |
| `sourceFilesSettings` | collection | Map of settings to be added for a specific file in a sub-folder. |

## The _artefact_ object

Alias: `artifact` (american spelling).

The `artefact` object defines the type and name of the output file.

It can be used only in project or test `*xbuild.json` files; using it in folder
specific metadata files triggers an warning.

| Parents |
|:-------|
| The `buildConfigurations` collection, a property of the root object. |

| Properties | Type | Description |
|:-----------|:-----|:------------|
| `type` | string | The artefact type (application or library). |
| `name` | string | The artefact name. |
| `outputPrefix` | string | The artefact name prefix. |
| `outputSuffix` | string | The artefact name suffix. |
| `extension` | string | The artefact extension. |

The `type` property can be one of:

- `executable` (default; default extension is `.exe` on Windows)
- `staticLib` (default extension is `.a`)
- `sharedLib` (default extension is `.so` for Linux)

If not present, The `name` property defaults to `{{ build.name }}`.

If not present, the default prefix/suffix properties are empty.

The actual name used for the artefact is a concatenation of four fields:

{% raw %}
```json
"{{ artefact.outputPrefix }}{{ artefact.name }}{{ artefact.outputSuffix }}{{ artefact.extension }}"
```
{% endraw %}

Example:

{% raw %}
```json
{
  "buildConfiguration": {
    "debug": {
      "artefact": {
        "type": "executable",
        "name": "{{ build.name }}",
        "outputPrefix": "",
        "outputSuffix": "",
        "extension": ""
      },
      "...": "..."
    }
  }
}
```
{% endraw %}

## The _toolsSetting_ object

TODO

## The _sourceFoldersSetting_ object

TODO

## The _sourceFilesSetting_ object

TODO

---

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
      "toolchainsSettings": { ... },
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
      "toolchainsSettings": { ... },
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
      "profiles": { ... } ???
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
      "profiles": { ... } ???
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

The definitions in the top `*xbuild.json` file apply to all files that enter
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
