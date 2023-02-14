---
title: Scratchpad (outdated)
permalink: /xcdl/work/scratchpad/

comments: true

date: 2015-10-25 12:00:00 +0200

---

These are notes on various decisions that need to be made, with the available choices, with pros and cons.

## .json vs .xml

JSON has two main disadvantages when used for configuration:

- does not allow comments
- usual parsers do not generate a DOM that, when serialized, creates the original file, so if updated by a tool, the formatting is not preserved.

## make vs. Python

Two candidates for the build systems are considered:

-   make
-   something based on Python, like SCons

**make** pros:

-   well-known
-   available on all platforms (separate install on Windows, but available)

**make** cons:

-   considered not very efficient by some

Python pros:

-   extending the build process is very powerful

Python cons:

-   may face acceptance problems, like SCons

When used only as an internal builder, probably it does not matter how the build is performed. It was easier to start pyXCDL with make files, and performance was not a problem.

However, for writing recipes, like for BitBake, an object oriented approach in Python might have advantages.

## Python2 vs Python3

This is no longer an issue, there are no reasons for not using it.

-   the project is new, there is no legacy code (pyXCDL need not be used as is, it can be ported)
-   python3 is available on all platforms

## Self contained packages vs. recipes

It looks like there are two ways of handling dependencies on external packages:

1.  when xcdl packages are created
2.  when the user downloads the packages

The initial approach considered that packages contain original code, and their content should be self contained.

Experience proved that many packages contain code from other sources, like vendor libraries, and sometimes these libraries need patches.

Maintaining these patches requires a separate branch in the repository, and periodic merges into the master branch.

For libraries distributed as archives, an automated procedure to update this separate branch would be useful.

The BitBake alternative is to delay the original archive fetch to the moment when the XCDL package is installed on the user machine, and to run a procedure there to prepare the actual package content.

This might save some space in the package repository, which need not include huge vendor libraries, but keep only recipes, but has the disadvantages that forwards the responsibility of a correct fetch to the user (the archive server must be available, the user computer needs to have enough space to store all initial archives, as the patched ones).

The recommended way is 1, to process the archive when the package is created, but the specifications should also allow 2, even if not implemented in the first version.

## Package content & build scenarios

There are several possibilities to create a package:

1.  original local code: the entire code resides in the project;
2.  original external code: some code is downloaded from an archive, a repository, in BitBake style; no patches;
3.  patched external code: the original code resides in a separate branch, merged to the master.

In all cases, only a selection of the files are packed in the final package, based on a MANIFEST file.

For 2 & 3, it is possible to pack only the recipe and ask the package manager to prepare the actual package.

## Recipes moments in time

There are 3 different moments when recipes are important:

-   when the XCDL package is created;
-   when the XCDL package is installed on the user machine;
-   when components are used to build a library or to be compiled in an application.

The package can be create with a simple zip selecting the required files, but can also mean downloading archives or source code, applying patches or generating dynamic content. This mechanism, together with the recipe to put together a collection of packages in a repository, will probably use Maven and be integrated into Eclipse.

Installing the package in the user development machine usually means unzip-ing the package, but can also mean downloading archives or source code, applying patches or generating dynamic content, so an advanced mechanism should also be available on the user development machine. These recipes should be integrated into the Packs Manager, but should also be available from a scriptable environment.

## Packs Manager vs. scriptable environment

Installing the packs is normally done by a GUI based Packs Manager (currently part of GNU ARM Eclipse plug-ins).

However it should be possible to build project in a headless environment, and in this case the projects should include enough information to allow the build tools to also identify and download the required packages, in similar to BitBake.
