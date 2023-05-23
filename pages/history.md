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
multi-platform unit tests for µOS++.

### The encounter with eCos CDL

In the first years of the 2000s I was involved with a project
running on the [Intel i960](http://en.wikipedia.org/wiki/I960) CPU,
which also required a multi-threaded system.

To implement it, I chose [eCos](http://ecos.sourceware.org), which was the
first major RTOS available as open source and with a permissive license.

There were many remarkable things to be noted about **eCos**, but
relevant for this story is that eCos came with an elaborate
mechanism for managing project configurations, the
[eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html),
which used [TCL](https://en.wikipedia.org/wiki/Tcl) scripts to
define the configuration metadata.

{% include note.html content="eCos CDL is the reason behind
the use of a component based design for the planned
xPack Project Builder (tentatively called `xpmake`)." %}

By that time, `vi` and `make` appeared to be my friends, but the
experience of manually maintaining the make files turned into a
nightmare.

### The µOS++ first edition

In the second half of the 2000s decade, I was searching for a solution
to write firmware for simple aviation instruments, running on
AVR-class microcontrollers. With eCos too heavy for resource restrained
devices, I decided to reimplement the
[Zilog Z80](http://en.wikipedia.org/wiki/Z80) scheduler written in
the late 90s for a commercial product, to run on the
[Atmel AVR8](http://en.wikipedia.org/wiki/AVR8) microcontroller,
and in 2007 I had the first functional version of
[µOS++](https://github.com/micro-os-plus/micro-os-plus-i).

### The Eclipse encounter

Given the bad experience I had with manually maintaining **make** files,
it is no surprise that when I first met Eclipse, and discoverd
[CDT](https://github.com/eclipse-cdt/),
I immediately started to searched for a solution to use it for µOS++.

### GNU ARM Eclipse

The initial use of Eclipse CDT was quite difficult, since direct support for
embedded toolchains was not available.

At the same time I started to play with the new
[Arm Cortex-M](https://en.wikipedia.org/wiki/ARM_Cortex-M) devices,
which looked very promising, given how ease it is to implement the
context switching code and the scheduler timer.

{% include note.html content="The GNU ARM Eclipse was born,
as a solution that greatly simplified
the build process for µOS++, given the CDT managed build system,
which automatically generated the make files." %}

### The testing dead-end

The initial enthusiasm of using Eclipse for building µOS++ applications
was soon
shaded by **the difficulties of building and running tests in a scriptable
environment**.

It must be mentioned that Eclipse CDT advertises a way of
running headless builds, but it proved unreliable, so the only
way of running test was manually, as regular Eclipse projects, which
was very inconvenient.

{% include note.html content="With µOS++ already used in some
projects, I was afraid that the lack of proper testing will eventually
bite; it did not, but each release still came with a good load of
stress." %}

### µOS++ SE and the XCDL experimental version

The need for a second edition of µOS++ become obvious while
using it for several commercial projects, and active work
started in early 2013, after the
[XCDL](http://xcdl.github.io) (eXtended Components Definition Language)
project, implemented in Python, become functional.

The major criticism of the first edition was the lack of support for
[Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration) and
[Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development),
requirements more and more expected for modern projects.

Starting from scratch, the first version of a unit testing infrastructure
was implemented on the macOS synthetic platform.

The new system was renamed
[µOS++ SE](https://github.com/micro-os-plus/micro-os-plus-ii) as the
**Second Edition**.

The µOS++ SE project wiki was created, initially
hosted in the SourceForge project web space, then moved to a private
domain due to major SourceForge shortcomings.

{% include note.html content="The experience with the XCDL component
based configuration and build
system was considered a success, and it validated the concept." %}

The major weakness was the limitation introduced by
having the build configuration metadata as a Python code:
it could be edited only manually, and not via a GUI based
IDE (compared, for example, to the C/C++ settings in Eclipse CDT,
which writes back the XML configuration file).

### µOS++ third edition with more and more testing

In 2014 work on µOS++ IIIe officially started with the creation of a new
Git repository [micro-os-plus](https://github.com/micro-os-plus)
and a new [web](http://micro-os-plus.github.io).

Compared to the previous edition, testing was much more thorough,
using the **CMSIS OS Validator** and several stress tests. The majority
of tests were performed via the synthetic POSIX platform on macOS
and Linux; another fair share of the tests were performed via QEMU
on the emulated STM32F4DISCOVERY, and only a very small were performed
on physical hardware.

But, as the number of tests and their complexity grew,
the problem of automating these test became worse and worse.

{% include note.html content="I ended with the tests split
across multiple projects, each with multiple
Eclipse projects, each with different prerequisites and workflows to build
and invoke the tests, up to the point when everything became un-manageable." %}

### The XCDL packages and the migration to GitHub

Further research concluded that CMSIS Packs alone are not enough,
and a more elaborate solution is necessary; initially the
[yotta](https://github.com/ARMmbed/yotta) solution was considered,
and in late 2015 the first XCDL packs format based on yotta was tested.

In December 2015 the project was migrated to GitHub and restructured as
proto-xPacks, stored as separate sub-projects.

Unfortunately yotta was later abandoned by Arm, and another solution was
needed.

### The npm/xpm era

While searching for a new solution to automate the tests for
the µOS++ projects, I discovered
[npm](https://en.wikipedia.org/wiki/Npm_(software)) as the industry
standard package manager for JavaScript packages, and the
[npmjs.com](https://www.npmjs.com) as the hugely popular public
repository, with millions of packages and billions of downloads.

I contacted Isaac Schlueter, its author, and asked if it is acceptable to
use the repository for non-JavaScript packages; he replied that unless
I do something really stupid like storing my photo library there,
nobody will chase down my packages.

{% include note.html content="This was a very kind answer,
and it was the turning point
in the xPack project, which became part of the node/npm ecosystem." %}

On April 2017 the first release of **xpm** was ready, and packages
managed by it were named **xPacks**.

### The binary xPacks

In the initial design, the xPacks were intended to store C/C++ source
files, and they worked just fine.

However, while **xpm** was used to automate testing, it was noted that
tests need to run with multiple toolchains, even multiple
versions of the same
toolchain, and these tools can also be defined as `devDependencies`
(development dependencies).

{% include note.html content="**xpm** was extended to also support
installing binary packages, and a new class of tools was created as
[xPack 3rd Party Development Tools](https://github.com/xpack-dev-tools/)." %}

### The xPack Build Box (XBB) nightmare

Building the multi-platform binary packages proved a very difficult
task. The challenge was how to address the contradiction between having to
build the very latest projects that run on very old
versions of the corresponding operating systems (Windows, GNU/Linux
and macOS).

The initial solution was to start with a Docker image of an old release
(Ubuntu 12, to also provide support for RedHat 7), and compile from
sources the required new versions of the compilers and other
development tools.
Unfortunately this was not possible directly, and an extra step was needed,
to compile a bootstrap with some slightly older versions, and with them
to compile the most recent versions.

This got more and more complicated, and the Docker image grew to
4-5 GB; the build took many hours to complete,
especially for the Raspberry Pi OS images.

The solution was functional, it allowed to build all GCC toolchains,
native and cross for Arm & RISC-V, but maintenance for the Docker
images proved close to _mission impossible_, and after the second
release it was evident that this is a dead end and a
new solution is needed.

### The XBB breakthrough

In the last months of 2022, work on a new XBB release started, and was
completed in February 2023, with XBB v5.0.0.

The new solution was a big improvement, since it used completely
standard Ubuntu 18 images, without any customisations, and all modern
tools were installed with **xpm** as existing binary xPacks.

This was a major milestone in the life of xPack project, since it
proved two things:

- that **the technology is standalone** with the newer versions of the tools
being built with existing xPacks
- that the **xpm** workflow is **generic enough** to be usable not only for
small embedded projects, but for complex tools, like compilers.

{% include note.html content="With this milestone reached, the problem of
binary dependencies required for
µOS++ was considered solved. The light at the end of the tunnel was real,
xPacks will eventually automate testing for the µOS++ projects." %}

### The utils-list source code xPack

With most of the tools in place, the
[@micro-os-plus/utils-lists](https://github.com/micro-os-plus/utils-lists-xpack/)
project was selected to be fully tested using the new tools.

The result was a very large set of tests, running both on the native
platform (gcc and clang), and on lots of embedded platforms
(Arm **Cortex-M0 & M7**, **Cortex A15 & A72**, **RISC-V 32/64**), running on
QEMU. I doubt that there are many projects so thoroughly tested
on so many platforms and build tools.

{% include note.html content="This was finally in line with the
expectations. There are good chances
that the automation provided by xPacks will allow me to sleep well
after each µOS++ release."%}

## The xPack project goals

The project came to life as a practical need to find a replacement for the
Eclipse CDT managed build, that can also be used to run unit tests in a
scriptable environment.

In the beginning it looked easy, but proved to be quite a challenge,
and required defining sub-goals and achieving them in sequence.

By trial and error, I identified three main aspects that need to be
addressed by such a solution:

- the build (defining which files that enter the build, the compiler/linker
  options, etc)
- the project configuration (simply said managing the values of the #define
  in a consistent way)
- the tools (toolchains, debuggers, emulators, etc)

### The XCDL experimental version

My first experiment was XCDL, used for µOS++ SE;
basically I implemented in Python something similar to the
[eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html).

The result looked like this:

- https://github.com/micro-os-plus/micro-os-plus-ii/blob/master/packages/portable/core/meta/xcdl.py

The implementation was quite easy, and worked pretty well.

However I identified several issues:

- using a programming for writing by hand the configuration files was
  convenient, but it had a major drawback: it prevented the configuration
  being edited with a GUI tool (similar to the Eclipse settings pages),
  since parsing Python is not trivial; in other words, the configuration
  files must be in a structured format, otherwise editing them by a
  machine is problematic
- although the µOS++ SE was more or less modular, the project was
  basically a mono-repo, and writing unit tests for each module was
  difficult
- being able to run unit tests with several toolchains, not to
  mention with different versions of the same toolchain, proved
  extremely difficult, and doing this on multiple platforms
  (macOS, windows, linux) was even more difficult

The things that I learned from this experiment were:

- if a configuration needs to be edited by a machine,
  it must use a structured format; the favourite format is json
- if each module is expected to be tested, the preferred solution
  is to use multiple small repositories, each with its CI tests
- if the project is split into multiple packages, a tool to automate
  installing/managing the dependencies is needed
- toolchains and other tools need to be standalone & relocatable,
  to allow multiple versions to be installed in different folders
  on the same machine; managing these multiple tools can also be
  automated with a tool

The first binary tools I prepared were arm-none-eabi-gcc, openocd,
qemu and windows-build-tools; they were also used in Eclipse project;
initially they were installed manually, and Eclipse was able to
identify them in certain fixed location.

While searching for a solution to automate installing different
source packages, I discovered `npm`, and thought it is pretty
close to my needs, so I adopted most of the concepts, and extended
them to handle the C/C++ linear dependencies; so **xpm** was created.

Later I extended xpm to automate installing the toolchains and
other binary archives.

As of now, there are toolchains for Arm, AArch64, RISC-V and native
(GCC & clang), that run on Windows, Linux, macOS; I would say that
the tools part of the project is covered properly, and fully automated.

As for the build and configuration tools in the project, things are
work in progress.

For the build, I first considered to rewrite the initial Python code
in JavaScript, but later I decided for a step by step approach.

In the first step I would use existing build system generators,
like CMake and meson, with several advantages:

- be able to add tests to my projects today, without having to wait
  for any special/future tools
- get a lot of experience on how to organise projects with such tools
- provide the users with a way to integrate my source code libraries
  into their existing projects built with CMake/meson.

To manage the multi-platform, multi-architecture, multi-version,
multi-etc tests, I needed a tool to manage multiple build configurations,
and since each configuration needs its own tools, with different
versions, it became clear that the build configurations must be
managed by the same xpm, so I extended xpm to handle multiple
build configurations and I added xPack actions, to automate
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
my work, more specifically running multiple tests for embedded
projects, which are usually more complicated than the projects themselves.

### To be continued

...
