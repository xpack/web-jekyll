---
title: XCDL rationals (outdated)
permalink: /xcdl/guide/rationals/

comments: true

date: 2015-11-16 12:00:00 +0200

---

## Why XCDL? (for the impatient)

### The very short answer

Well, if children can build complex toys from LEGO bricks, why couldn't we build software from components in a similar way?

### Rationals

Simple reasons behind the XCDL component framework design:

* for better performance (size, optimisation, etc) libraries are not the solution, and compile time configuration is preferred;

* it is crazy that although the software author knows very well

  * where the source folders are,
  * where the include folders are,
  * which are the custom compile options,

  most of the time users still need to enter these setting manually in their development tools, each time they create a new project that uses that piece of software.

### Proposal

Why not pack together the actual source code with some simple and portable metadata, to automate the project creation, ease further updates and generally help automate project management?

### Compliance levels

There may be multiple compliance levels, from simple to complex, each adding more metadata for supporting more functionality:

1. pack the sources into an archive and add a minimal package metadata, to define dependencies on other packages;
1. add metadata to define which are the source folders, the include folders, and the custom compile options;
1. add metadata to group source files in related components, structured in a virtual hierarchy, with dependencies and conditions when these components are active/enabled;
1. add metadata to define configuration options, also to be shown as nodes in the virtual hierarchy, with dependencies and formulas to compute option values with knowledge about the entire build environment;
1. add metadata and templates to dynamically generate source files with content adapted to various configuration selections and options;
1. possibly more!

### Benefits

The main beneficiaries of the XCDL component framework are software developers, and benefits are multifold, during the project creation, during project lifecycle, and improved testability.

#### Simplified project creation

With proper metadata available, project creation is reduced to several clicks to select the main characteristics of the project; all required files will be pulled in by the dependencies, and all the usual project settings (source folders, include folders, compile options) will be automatically set by the XCDL project wizard.

#### Simplified updates management

If, during the lifetime of the project, other features that were not initially selected are needed (for example more device drivers, more application libraries, etc), the developer can invoke the XCDL project wizard and enable/disable further components and change any options; in the end the wizard will recompute all dependencies and update the project to use the new definitions.

The same is true when new package versions are released (for example STM releases a new version of the HAL for the STM32F4 family and the stm32f4-hal xPack is updated); the developer can choose to stick to a given version, or upgrade to the latest version; the wizard will recompute all dependencies and update the project to use the new definitions.

#### Improved testability

With all metadata available in the packages, and the full configuration also saved as metadata, it is very easy to recreate the project from a script, and integrate the project build into a Continuous Integration systems (like GitHub Actions, or Jenkins/Hudson), greatly simplifying the definition and use of unit tests.


## Why XCDL? (the long version)

As the complexity of embedded system grows, it is more and more difficult to put together multiple components with lots of dependencies and configuration options.

To address this problem, XCDL defines and implements a component framework, as a set of metadata and a collection of tools specifically designed to support **multi-variant cross-building embedded system images** based on reusable components. This component framework is extensible, allowing additional components to be added to the build system at any time.

Although designed to meed the requirements of building embedded applications, XCDL should be generic enough to be used to build regular applications/libraries too.

### Multi-variant

In the XCDL context, _multi-variant_ covers the following:

* multiple processor architectures (like ARM Cortex-M), with multiple sub-architectures (like M3, M4, M0), multiple manufacturer families (like STM32F1, STM32F4), multiple sub-families (like STM32F10x Connectivity Line) and multiple devices (like ST STM32F107VG);
* as an extension to architectures, synthetic architectures, like POSIX, can also be considered targets, mainly used to run test cases;
* multiple hardware platforms (boards, board revisions);
* multiple synthetic POSIX platforms (like OS X, GNU/Linux, MSYS2 under Windows);
* multiple toolchains (like GCC, LLVM clang)
* multiple build platforms (like OS X, GNU/Linux, Windows)

## Why manage dependencies?

Automatic dependencies management is the first and foremost feature of the XCDL component framework.

Properly defined components, with accurate dependencies, allow to automatically create projects with all required source files and headers, and with all required compile and link options properly set. For example if a configuration refers to the STM32F4-DISCOVERY board, this will refer to the STM32F407VG processor, which will refer to the STM32F4 startup code, which will refer to the CMSIS CORE headers, so all required pieces will fit together without user intervention.

## Why configurability?

The XCDL component framework places a great deal of emphasis on configurability.

### Reusability

The fundamental goal is to allow large parts of embedded applications to be constructed from generic reusable software components, which need to be adjusted to fit together and to meet existing constraints.

### Memory constraints

Many embedded applications have to work with limited memory, to keep down manufacturing costs. The component framework must allow users to configure the components so that any unnecessary functionality gets removed, for RAM (and sometimes Flash) usage to be kept to a minimum.

### Debugging

Embedded systems tend to be difficult to debug. The reusable components can provide debugging assistance in various ways. Allowing users to control which debugging features are enabled for any given application build is very desirable.

## Approaches to configurability

The purpose of configurability is to control the behaviour of components and the relationships between components. The component writer includes as many different behaviours as possible, but has no way of knowing in advance exactly how a particular component will end up being used. When an application uses a component there must be some way of specifying the desired behaviour.

### Run-time

One way to control the behaviour is at **run time**. There is of course a major disadvantage in terms of the size of the final application image: the code that gets linked with the application has to provide support for all possible behaviour cases, even if the application does not require it.

### Link-time

Another approach is to control the behaviour at **link time**, typically by using inheritance in an object-oriented language and linking only one instance of the implementation.

### Compile-time

The XCDL component framework allows the behaviour of components to be controlled at an even earlier time: when the component source code gets compiled.

In theory, **compile-time** configurability should give the best possible results in terms of code size, because it allows code to be controlled at the individual statement level rather than at the function or object level. **The overall result is that the final application image contains only the code and data that is really needed for the application to work, and nothing else**.

Compile-time configurability is not intended to replace the other approaches but rather to complement them.

There will be times when run-time selection of behaviour is desirable: for example an application may need to be able to change the baud rate of a serial line, and the system must then provide a way of doing this at run-time. There will also be times when link-time selection is desirable.

## Credits

The initial content of this page was based on *Chapter 1. Overview* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
