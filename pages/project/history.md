---
permalink: /project/history/
title: Project History

comments: true

date: 2023-05-20 06:22:00 +0300

---

## The early years and the tight relation to µOS++

The history of the **xPack** project was deeply intertwined with
[the history of µOS++](http://micro-os-plus.github.io/project/history/),
as it was initially intended to **automate building** and running
**multi-platform unit tests** for [µOS++](http://micro-os-plus.github.io).
Later it was also used to build the binary xPacks, which further
validated the concept.

To avoid redundancy, the full story is not replicated here, so please
read [the history of µOS++](http://micro-os-plus.github.io/project/history/)
before continuing; the brief list of the important events is:

- [eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html)
  was the inspiration for a component based design (early 2000s)
- in 2013, the **GNU ARM Eclipse plug-ins** (later rebranded as the
  [Eclipse Embedded CDT](https://eclipse-embed-cdt.github.io))
  was the first attempt to find a solution that avoids generating **make**
  files by hand, but this prevented building and running unit tests in
  a scriptable environment
- in 2013, the experimental [XCDL](http://xcdl.github.io)
  (eXtended Components Definition Language) project, inspired by
  eCos CDL, implemented in Python, validated the concept
  {% include note.html content="The major weakness of XCDL was the
  limitation introduced by
  having the build configuration metadata as a Python code:
  **it could be edited only manually**, and not via a GUI based
  IDE (compared, for example, to the C/C++ settings in Eclipse CDT,
  which writes back the XML configuration file)" %}
- in 2014, the **CMSIS Packs** solution was evaluated, and an
  Eclipse plug-in was
  created to manage them, but the solution was later found to have
  too many design issues, and was abandoned
- in 2015, the [yotta](https://github.com/ARMmbed/yotta) solution was
  considered, and the first XCDL packs based on yotta were tested;
  for various reasons, **yotta** was later abandoned by Arm
  {% include note.html content="As yotta was
  strongly influenced by **npm**, the npm ecosystem was considered
  a good starting point for a future solution." %}
- in 2017, the first release of **xpm** was available, as a complementary
  solution to **npm**, and packages
  managed by it were named **xPacks**; **xpm** complements
  [npm](https://en.wikipedia.org/wiki/Npm_(software)) as the industry
  standard package manager for JavaScript packages, and uses the same
  [npmjs.com](https://www.npmjs.com) as the hugely popular public
  package repository
- in 2019, **xpm** was extended to also support
  installing binary packages, and a new class of tools was created as
  [xPack 3rd Party Development Tools](https://github.com/xpack-dev-tools/)
- in 2022, **xpm** was used to build the binary packages; this proved that
  **the technology is standalone**, with the newer versions of the tools
  being built with existing xPacks
- in 2023, with most of the tools in place, a first C/C++ project
  ([@micro-os-plus/utils-lists](https://github.com/micro-os-plus/utils-lists-xpack/))
  was fully tested via **xpm**, validating again the whole concept

## The xPack project goals

The project came to life as a practical need to find a replacement for the
Eclipse CDT managed build, with the additional requirement
to be able to run unit tests in a scriptable environment.

{% include note.html content="In the beginning it looked easy,
but later it proved to be quite a challenge,
and required defining sub-goals and achieving them in sequence." %}

By trial and error, the main aspects that need to be
addressed by such a solution were identified as:

- the **build** (defining which files enter the build, the compiler/linker
  options, etc)
- the **project configuration** (e.g. managing the values of the #define
  in a consistent way)
- the **tools** (toolchains, debuggers, emulators, etc)

## The XCDL experimental version

The first experimental solution was [XCDL](http://xcdl.github.io),
which was used in the µOS++ Second Edition;
basically some of the
[eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html)
functionality was implemented in Python.

The result looked like this:

- [meta/xcdl.py](https://github.com/micro-os-plus/micro-os-plus-ii/blob/master/packages/portable/core/meta/xcdl.py)

The implementation was quite easy, and worked pretty well.

However several issues were identified:

- using configuration files written in a programming language was
  convenient, but it had a major drawback: since parsing Python
  is not trivial, it prevented the configuration
  being edited with a GUI tool (similar to the Eclipse settings pages);
  in other words, **the configuration
  files must be in a structured format**, otherwise editing them by a
  machine is problematic
- although the µOS++ SE was more or less modular, the project was
  basically a **mono-repo**, and **writing unit tests for each module was
  difficult**
- running unit tests with several toolchains, not to
  mention with different versions of the same toolchain, proved
  extremely difficult, and doing this on multiple platforms
  (macOS, windows, linux) was even more difficult

The lessons learned from this experiment were:

- if a configuration needs to be edited by a machine,
  it must be written in a **structured format**,
  **JSON** being the favourite
- if each module is expected to be tested, it is better
  to use **multiple small repositories**, each with its CI tests
- if the project is split into multiple packages, a tool to automate
  installing/managing the **dependencies** is a great addition
- toolchains and other tools need to be **standalone & relocatable**,
  to allow multiple versions to be installed in different folders
  on the same machine; managing these multiple tools can also be
  automated with a tool

## Binary xPacks

The first binary tools prepared were **arm-none-eabi-gcc**, **openocd**,
**qemu** and **windows-build-tools**; they were also used in Eclipse project;
initially they were installed manually, and Eclipse was able to
identify them in certain fixed location.

## npm/xpm

While searching for a solution to automate installing different
source packages, a solution that looked pretty close to the needs
was **npm**, so most of the concepts were adopted, and the tool
was extended
to handle the C/C++ linear dependencies; this is how **xpm** was created.

Later **xpm** was extended to automate installing the toolchains and
other binary archives.

As of now, there are toolchains for Arm, AArch64, RISC-V and native
(GCC & clang), that run on Windows, Linux, macOS; it is probably fair
to say that
the tools part of the project is covered properly, and fully automated.

## Build system generators

As for the build and configuration tools in the project, things are
work in progress.

For the build, the first idea was to rewrite the initial
Python code in JavaScript, but later a step by step approach
was considered.

In the first step the existing build system generators were used,
like **CMake** and **meson**, with several advantages:

- they allow to add tests to the µOS++ projects immediately,
  without having to wait for any special/future tools
- they are a good chance to get a lot of experience on how to organise
  projects with such tools
- they provide the users a direct way to integrate the µOS++
  source code libraries
  into their existing projects built with CMake/meson.

To manage the multi-platform, multi-architecture, multi-version,
multi-etc tests, a tool to manage **multiple build configurations**
was needed,
and since each configuration needs its own tools, with different
versions, it became clear that the build configurations must be
managed by the same tool, so **xpm** was extended to handle multiple
**build configurations**; later, **xPack actions** were added, to automate
running sequences of commands, like cmake or meson, to build
and run the tests.

## Future plans

At the moment of writing this (mid 2023), the project is pretty advanced,
but it is not yet complete.

Soon all the
[µOS++ projects](https://github.com/micro-os-plus)
will be updated to use
the multiple build configurations automated by **xpm**, and so
have everything fully tested in µOS++.

With the experience from this step, the next step is to finalise the
specs for the **xPack Project Builder** that will perform the
builds and manage the project configurations.

The tool will probably be called **xpmake**,
and will use json files, with a content similar to this one:

- [xpack.json](https://github.com/micro-os-plus/utils-lists-xpack/blob/xpack/xpack.json)

As it can be seen, this file defines the **include folders**,
the **source files**, and some
**preprocessor definitions** that might be enabled while
building the project.

This file, together with all other similar files from the packages
that are part of the project, will provide the input data for a tree
of **components**, that can be rendered in a graphical tool like **VS Code**,
thus allowing to configure a project in a way similar,
possibly even more advanced, than
the **Eclipse CDT** settings, since the hierarchical components reflect
the logical structure of the application, and allow to automatically
manage dependencies between components, and between configuration
options.

Additions to the **VS Code xPack extension** are planned,
to edit the tree of xPack CDL components, and run
the builds directly, without CMake/meson; this will
be a true xPack enabled tool, and will be an alternate solution to
Eclipse Embedded CDT.

But the use of this tool should be **optional**, the whole functionality
should also be
available from a terminal and a plain text editor.

## Conclusions

As it can be seen, the xPack project originated from **the need to automate
the workflow for existing open source projects**,
especially the execution of multiple tests for embedded
projects, which often poses more challenges than developing
the projects themselves.

## To be continued...
