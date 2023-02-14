---
title: XCDL packages (outdated)
permalink: /xcdl/guide/packages/

comments: true

date: 2015-10-25 12:00:00 +0200

---

For a package to be usable in the XCDL component framework it must conform to certain rules imposed by the framework. Packages must be distributed in a form that is understood by the component repository administration tool. For each package there must be a top-level XCDL metadata file which describes the package to the component framework. There are certain portability requirements related to how a package gets built, so that the package can be used in a variety of host environments. In addition to these rules, the component framework provides a number of guidelines. It is not mandatory for the packages to strictly conform to all guidelines, but sticking to them can simplify certain operations.

## Packages

### What is a package?

An XCDL/xPack package is:

1. a folder containing a valid `.xpack.json` file;
2. a gzipped tarball containing 1);
3. a URL that resolves to 2);
4. a Git URL that, when cloned, results in 1).

The definition is inspired from the [NPM](https://docs.npmjs.com/misc/developers#what-is-a-package) package definition, and is intentionally Git and JavaScript centric, as these technologies are considered mature and worth considering.

Since the external representation of the XCDL metadata will probably remain based on JSON, the documentation will use this syntax.

### Package contents

In addition to the `.xpack.json` metadata file, a typical package contains the following:

*  some number of source files (.c/.cpp) and header files (.h). The project artefact (library or executable) will be created using these files. Some source files may serve other purposes, for example to provide a linker script;
*  exported header files which define the interface provided by the package;
*  online documentation, for example reference pages for each exported function;
*  some number of test cases, shipped in source format, allowing users to check that the package is working as expected on their particular hardware and in their specific configuration;
*  other XCDL metadata files describing the package to the component framework.

It is also conventional to have a per-package `ChangeLog` file used to keep track of changes to that package. This is especially valuable to end users of the package who may not have convenient access to the source code control system used to manage the master copy of the package, and hence cannot find out easily what has changed. Often it can be very useful to the main developers as well.

Any given packages need not contain all of these.

Some packages may not have any source code: it is possible to have a package that merely defines a common interface which can then be implemented by several other packages, especially in the context of device drivers; however it is still common to have some code in such packages to avoid replicating shareable code in all of the implementation packages. Similarly it is possible to have a package with no exported header files, just source code that implements an existing interface: for example an ethernet device driver might just implement a standard interface and not provide any additional functionality. Packages do not need to come with any on-line documentation, although this may affect how many people will want to use the package. Much the same applies to per-package test cases.

### Package layout

The component framework has a recommended per-package folder layout which splits the package contents on a functional basis:

    Packages/ilg/xyzw/current
    ├── .xpack.json
    ├── .xcdl.json
    ├── ChangeLog
    ├── README.md
    ├── doc
    ├── include
    ├── src
    └── tests

For example, if a package has an `include` sub-folder then the component framework will assume that all header files in and below that folder are **exported header files** and will do the right thing at build time. Similarly if there is *doc* property indicating the location of online documentation then the component framework will first look in the `doc` subfolder.

Except for the name and location of the `.xpack.json` file, this folder layout is just a guideline, it is not enforced by the component framework. For simple packages it often makes sense to have all of the files in just one directory. For example a package could just contain the files hello.cpp, hello.h, hello.html. By default hello.h will be treated as an exported header file, although this can be overridden with the includeFiles property. Assuming there is a doc property referring to hello.html and there is no doc sub-directory then the tools will search for this file relative to the package’s top-level and everything will just work. Much the same applies to hello.cpp.

## The `.xpack.json` file

### `$schema`

To facilitate versioning and validation, all XCDL .json files are fully defined by a schema file.

The current schema for the `.xpack.json` file is:

    "$schema": "https://xcdl.github.io/schemas/xpack-1-1.json",

The full and up-to-date definition of this schema is available from the separate [Schemas](https://xcdl.github.io/schemas/) repository.

### `name`

A string that must uniquely identify the project node in the local repository hierarchy. It does not need to match the GitHub repository name, although usually it is closely related.

The parent path must have at least one level, and generally defines the originator of the package (user or organization).

Syntax (string):

    "name": "string"

Example:

    "name": "/ilg/ARM/CMSIS"

### `description`

A paragraph with a reasonably detailed description of the package. As a regular paragraph, it must end with dot.

Syntax (string):

    "description": "long string"

Example:

    "description": "CMSIS (Cortex Microcontroller Software Interface Standard)."

### `repository`

The place where the package repository is located. This is helpful for people who want to contribute.

Syntax (array of objects):

    "repository":
    {
      "type": "string",
      "url": "string"
    }

Support for the `git` type is mandatory. Other types, like `svn`, might be added later.

Example:

    "repository":
    {
        "type": "git",
        "url": "https://github.com/xpacks/arm-cmsis.git"
    }

### `releases`

The list, in reverse order, of all versions of the package publicly released.

Syntax (array of objects):

    "releases": [
      {
        "version": "semver",
        "description": "long string",
        "date": "iso-date",
        "archives": [
            "url": "string"
        ],

        "repository":
        {
            "type": "git",
            "url": "string",
            "tag": "string"
        }
      },
      {
          ...
      }
    ]

The `archives` array define an ordered list of locations where the binary package can be downloaded from.

The inner `repository` object defines the location where the release sources are available; only the `tag` property is mandatory; if this location is identical with the top definition, the `type` and `url` properties may be omitted.

Example:

    "releases": [
        {
            "version": "4.5.0",
            "description": "- CMSIS-Core     4.30.0  ...",
            "date": "2015-11-12",
            "archives": [
                "http://gnuarmeclipse.sourceforge.net/xpacks/arm-cmsis/4.5.0.zip",
                "https://github.com/xpacks/arm-cmsis/archive/4.5.0.zip"
            ],

            "repository":
            {
                "tag": "4.5.0"
            }
        }
    ],

### `keywords`

An array of strings, intended to help searches identify a package.

Syntax (array of strings):

    "keywords": [
      "string1",
      "string2",
      ...
    ]

Example:

    "keywords": [
        "ARM",
        "CMSIS",
        "Cortex-M"
    ],


### `homepage`

The full URL to the project home page, either a separate web or a GitHub/SourceForge/etc project page.

Syntax (string):

    "homepage": "string"

Example:

    "homepage": "https://github.com/xpacks/arm-cmsis",

### `bugs`

The full URL to the project's issue tracker and / or the email address to which issues should be reported. These are helpful for people who encounter issues with your package.

Syntax (object):

    "bugs": [
        {
            "description": "string"
            "url": "string",
            "email": "string"
        }
    ]

Example:

    "bugs": [
        {
            "description": "All issues."
            "url": "https://github.com/xpacks/arm-cmsis/issues"
        }
    ],


### `license`

A string identifying the license for the package, so that people know how they are permitted to use it.

Syntax (string):

    "license": "string"

The license is identified by a short ID, selected from the list of [SPDX license IDs](https://spdx.org/licenses/), ideally one that is [OSI](https://opensource.org/licenses/alphabetical) approved.

If the package is licensed under multiple common licenses, use an [SPDX license expression syntax version 2.0](https://npmjs.com/package/spdx) string, like this:

    "license": "(ISC OR GPL-3.0)"

If the license hasn't been assigned an SPDX identifier, or if it is a custom license, use the following valid SPDX expression:

    "license": "SEE LICENSE IN filename"

Then include a file named `filename` at the **top** level of the package.

Finally, if you do not wish to grant others the right to use a private or unpublished package under any terms, use:

    "license": "UNLICENSED"

### `maintainers`

The maintainers are the persons who maintain the package (may be different from the persons who created the source files packaged in the package). The first maintainer is the person who created the package. The array extends at the bottom.

Syntax (array of objects):

    "maintainers": [
      {
        "name": "string",
        "email": "string",
        "url": "string"
      }
    ]

Example:

    "maintainers": [
        {
            "name": "Liviu Ionescu",
            "email": "ilg@livius.net",
            "url": "https://github.com/ilg-ul/"
        }
    ],

### `contributors`

The contributors are the persons/organisations who contributed to the content of the package. The first contributor is the person who created the source files available in the package. The array extends at the bottom.

Syntax (array of objects):

    "contributors": [
      {
        "name": "string",
        "email": "string",
        "url": "string"
      }
    ]

Example:

    "contributors": [
        {
            "name": "ARM"
        },

        {
            "name": "Liviu Ionescu",
            "email": "ilg@livius.net",
            "url": "https://github.com/ilg-ul/"
        }
    ],


### `dependencies`

Dependencies are specified in an array of objects that maps a package name to a version range. The version range is a string which has one or more space-separated descriptors. Dependencies can also be identified with a tarball or git URL.

Syntax (array of objects):

    "dependencies": [
        {
            "name": "string",
            "version": "string"
        },
      ...
    ]

The syntax for the version string is based on [semver](https://semver.org/), with the following expressions (inspired from NPM):

* `version` Must match version exactly
* `>version` Must be greater than version
* `>=version` etc
* `<version`
* `<=version`
* `~version` "Approximately equivalent to version" See semver(7)
* `^version` "Compatible with version" See semver(7)
* `1.2.x` 1.2.0, 1.2.1, etc., but not 1.3.0
* `*` Matches any version
* `""` (just an empty string) Same as *
* `version1 - version2` Same as >=version1 <=version2
* `range1 || range2` Passes if either range1 or range2 are satisfied.

Future versions may also support:

* https://.../file.tgz
* git://...
* github://user/repo
* tag
* path/path/path (???)

Example:

    "dependencies": [
        {
            "name": "ilg/STM32",
            "version": ">=1.1.1"
        },

        {
            "name": "ilg/ARM/CMSIS",
            "version": ">=4.4.0"
        }
    ]

## The `.xpackignore` file

The `.xpackignore` file is used to keep stuff out of the binary package. Unlike `git`, the XCDL tools look for this file only in the package root folder.

The syntax follow the same pattern rules as .gitignore files:

* blank lines or lines starting with # are ignored;
* standard glob patterns work;
* patterns ending with a forward slash / specify a directory;
* patterns starting it with an exclamation point ! specify a negation.

## Making a package binary distribution

Developers of XCDL packages are advised to distribute their packages in the form of XCDL binary files. Packages distributed in this format may be added to existing XCDL component repositories in a robust manner using the package administration tools. This chapter describes the format of package distribution files and details how to prepare an XCDL package for distribution in this format.

### The binary distribution format

XCDL package distribution files are zipped archives which contain both the source code and metadata. The distribution files are subject to the following rules:

1.  A metadata file must be named `.xpack.json` and must be located in the root of the archive.
2.  The package source code must be placed in one or more folders.
3.  An optional license agreement file named LICENSE.txt, or LICENSE may be placed in the root of the archive.
7.  Files in the archive must use LF line endings.
8.  Binary files may be placed in the archive, but the distribution of object code is not recommended.

### Preparing packages for distribution

TODO: define the procedure to pack the content of a package folder to an archive.

## Credits

The initial content of this page was based on *Chapter 2. Package Organization* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
