---
permalink: /project/history/
title: Project History

comments: true

date: 2023-05-20 06:22:00 +0300

---

## The early years and the tight relation with µOS++

The history of the xPack project was deeply intertwined with
[the history of µOS++](http://micro-os-plus.github.io/project/history/)
as it was initially intended to automate building and running
multi-platform unit tests for [µOS++](http://micro-os-plus.github.io).
Later it was also used to build the binary xPacks, which validated the
concept once more.

To avoid redundancy, the text will not be replicated here, so please
read [the history of µOS++](http://micro-os-plus.github.io/project/history/)
from there; here will be listed
briefly only some of the important events:

- the [eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html),
  encountered in the early 200s,
  was the inspiration for a component based design
- in 2013, the **GNU ARM Eclipse plug-ins** (later rebranded as the
  [Eclipse Embedded CDT](https://eclipse-embed-cdt.github.io))
  was the first attempt to avoid generating make files
  by hand, but this prevented building and running unit tests in a
  scriptable environment
- in 2013, the experimental [XCDL](http://xcdl.github.io)
  (eXtended Components Definition Language) project, inspired by
  eCos CDL, implemented in Python, validated the concept
- the major weakness of XCDL was the limitation introduced by
  having the build configuration metadata as a Python code:
  it could be edited only manually, and not via a GUI based
  IDE (compared, for example, to the C/C++ settings in Eclipse CDT,
  which writes back the XML configuration file)
- in 2014, the CMSIS Packs solution was evaluated, and an Eclipse plug-in was
  created to manage them, but the solution was later found to have
  too many design issues, and was abandoned
- the [yotta](https://github.com/ARMmbed/yotta) solution was considered,
  and in late 2015 the first XCDL packs format based on yotta was tested;
  unfortunately yotta was later abandoned by Arm
- in 2017, the first release of **xpm** was available, and packages
  managed by it were named **xPacks**; **xpm** complements
  [npm](https://en.wikipedia.org/wiki/Npm_(software)) as the industry
  standard package manager for JavaScript packages, and uses the same
  [npmjs.com](https://www.npmjs.com) as the hugely popular public
  package repository
- **xpm** was extended to also support
  installing binary packages, and a new class of tools was created as
  [xPack 3rd Party Development Tools](https://github.com/xpack-dev-tools/)
- in 2022, **xpm** was used to build the binary packages; this proved that
  **the technology is standalone** with the newer versions of the tools
  being built with existing xPacks
- in 2023, with most of the tools in place, a first C/C++ project
  ([@micro-os-plus/utils-lists](https://github.com/micro-os-plus/utils-lists-xpack/))
  was fully tested via **xpm**, validating again the whole concept

## The xPack project goals

The project came to life as a practical need to find a replacement for the
Eclipse CDT managed build, that can also be used to run unit tests in a
scriptable environment.

In the beginning it looked easy, but later it proved to be quite a challenge,
and required defining sub-goals and achieving them in sequence.

By trial and error, the main aspects that need to be
addressed by such a solution were identified:

- the build (defining which files that enter the build, the compiler/linker
  options, etc)
- the project configuration (simply said managing the values of the #define
  in a consistent way)
- the tools (toolchains, debuggers, emulators, etc)

### The XCDL experimental version

The first experimental solution was [XCDL](http://xcdl.github.io),
used for µOS++ Second Edition;
basically something similar to the
[eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html)
was implemented in Python.

The result looked like this:

- https://github.com/micro-os-plus/micro-os-plus-ii/blob/master/packages/portable/core/meta/xcdl.py

The implementation was quite easy, and worked pretty well.

However several issues were identified:

- using a programming for writing by hand the configuration files was
  convenient, but it had a major drawback: since parsing Python
  is not trivial, it prevented the configuration
  being edited with a GUI tool (similar to the Eclipse settings pages);
  in other words, the configuration
  files must be in a structured format, otherwise editing them by a
  machine is problematic
- although the µOS++ SE was more or less modular, the project was
  basically a mono-repo, and writing unit tests for each module was
  difficult
- being able to run unit tests with several toolchains, not to
  mention with different versions of the same toolchain, proved
  extremely difficult, and doing this on multiple platforms
  (macOS, windows, linux) was even more difficult

The lessons learned from this experiment were:

- if a configuration needs to be edited by a machine,
  it must written in a structured format; the favourite format is **JSON**
- if each module is expected to be tested, the preferred solution
  is to use **multiple small repositories**, each with its CI tests
- if the project is split into multiple packages, a tool to automate
  installing/managing the **dependencies** is needed
- toolchains and other tools need to be **standalone & relocatable**,
  to allow multiple versions to be installed in different folders
  on the same machine; managing these multiple tools can also be
  automated with a tool

The first binary tools prepared were **arm-none-eabi-gcc**, **openocd**,
**qemu** and **windows-build-tools**; they were also used in Eclipse project;
initially they were installed manually, and Eclipse was able to
identify them in certain fixed location.

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

As for the build and configuration tools in the project, things are
work in progress.

For the build, the first idea was to rewrite the initial
Python code in JavaScript, but later a step by step approach
was considered.

In the first step the existing build system generators were used,
like CMake and meson, with several advantages:

- they allow to add tests to the µOS++ projects today, without having
  to wait for any special/future tools
- get a lot of experience on how to organise projects with such tools
- provide the users with a way to integrate my source code libraries
  into their existing projects built with CMake/meson.

To manage the multi-platform, multi-architecture, multi-version,
multi-etc tests, a tool to manage multiple build configurations was needed,
and since each configuration needs its own tools, with different
versions, it became clear that the build configurations must be
managed by the same xpm, so **xpm** was extended to handle multiple
**build configurations** and **xPack actions** were added, to automate
running sequences of commands, like cmake or meson, to build
and run the tests.

## Future plans

At this moment (mid 2023), the project is pretty advanced, but
it is not yet complete.

In the next period all the µOS++ projects will be updated to use
the multiple build configurations automated by **xpm**, and so
have everything fully tested in µOS++.

With the experience from this step, the next step is to finalise the
specs for the tool that will perform the builds and project
configurations.

The tool will probably be called `xpmake`, and it'll us json files,
like this one:

- <https://github.com/micro-os-plus/utils-lists-xpack/blob/xpack/xpack.json>

The file defines the include folders, the source files, and some
preprocessor definitions that might be enabled while building the project.

This file, together with all other similar files from the packages
that are part of the project, will provide the input data for a tree
of 'components', that can be rendered in a graphical tool like VS Code,
and so allow to configure a project in a way even more advanced than
the Eclipse CDT settings, since the hierarchical components reflect
the structure of the application, and allow to automatically manage
dependencies between components, and between configuration options.

A VS Code extension to edit the xpmake tree of components, and run
the builds directly, without CMake/meson, is planned, and this will
be a true xPack enabled tool, and will be an alternate solution to
Eclipse Embedded CDT.

But this tool should be optional, the whole functionality should also be
available from a terminal and a plain text editor.

### Conclusion

As it can be seen, the xPack project started as a way to automate
the workflow for existing open source projects,
more specifically running multiple tests for embedded
projects, which are usually more complicated than the projects themselves.

### To be continued

...
