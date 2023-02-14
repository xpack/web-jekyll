---
title: The XCDL Software Requirement Specifications (outdated)
permalink: /xcdl/srs/

comments: true

date: 2015-10-25 12:00:00 +0200

---


## Introduction

### Purpose

This document is intended for software architects, designers, and developers, and should provide the necessary input during the design, implementation and maintenance of the XCDL framework.

### Scope

This document refers to the XCDL configuration definition language, the XCDL framework and the associated build process.

**The main focus of XCDL is to support multi-variant cross-building embedded system images.**

By multi-variant it should be understood:

- multiple processor architectures (like ARM Cortex-M), with multiple sub-architectures (like M3, M4, M0), multiple manufacturer families (like STM32F1, STM32F4), multiple sub-families (like STM32F10x Connectivity Line) and multiple devices (like ST STM32F107VG)
- as an extension to architectures, synthetic architectures, like POSIX, should be supported
- multiple hardware platforms (boards, board revisions)
- multiple synthetic run platforms (like OS X, GNU/Linux)
- multiple toolchains (like GCC, LLVM clang)
- multiple build platforms (like OS X, GNU/Linux, Windows)

The XCDL framework will include several tools to:

- generate the artefacts defined by various build configurations
- manage the specific metadata

The toolchains and other general purpose tools used by XCDL during the build process are not considered part of the XCDL framework.

### Definitions and acronyms

- CDL - the Configuration Definition Language, as the configuration mechanism used by eCos
- XCDL - the eXtensible Configuration Definition Language and framework, inspired by CDL
- XCDL software component - a set of source files that perform a given function, standalone or depending on other components, together with some metadata
- XCDL component metadata - additional informations added to software components to describe dependencies, requirements and constraints
- XCDL configuration tools - tools running on development machines to create and manage XCDL configurations and component metadata
- XCDL configurations - specific metadata definitions, that describe the requirements of an application, like which components are used, the values for preprocessor definitions, toolchain selection, build details, etc
- XCDL build configurations - the result of processing an XCDL configuration, usually a build folder with associated build related files (like GNU Make files); when IDEs (like Eclipse) are used, it translates to an IDE build configuration
- XCDL requirements - direct requirements, generally components that are mandatory for the build to succeed, like base classes
- XCDL constraints - in general hardware dependencies, like the presence of a certain peripheral, but dependencies to software options can also be used

### References

- [eCos](https://ecos.sourceware.org/) - *The embedded configurable operating system* by Cygnus Solutions ([Wikipedia](https://en.wikipedia.org/wiki/ECos))
- Manual: *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001, available from [eCos Documentation](https://ecos.sourceware.org/docs-3.0/).
- Book: *Embedded software development with eCos*, by Anthony J. Massa, published in 2003 at Prentice Hall, available from [Amazon](https://www.amazon.com/Embedded-Software-Development-Anthony-Massa/dp/0130354732)
- Book: *Software Build Systems: Principles and Experience*, by Peter Smith, published in 2011 at Addison Wesley, available from [Amazon](https://www.amazon.com/Software-Build-Systems-Principles-Experience/dp/0321717287)
- IEEE Std 830-1998: *IEEE Recommended Practice for Software Requirements Specifications*, published in 1998

### Overview

This document is based on IEEE Std 830-1998 recommendations, but may not follow them by the letter.

## Overall description

### Product perspective

#### Credits

The XCDL definition language is functionally inspired by eCos CDL, but has a different syntax and supports a slightly different functionality. The first version was based on Python definitions and served as an excellent prototyping platform. The final version will be XML based, and will be integrated in Eclipse.

The package management features were inspired by CMSIS Pack, and the implementation should be able to handle both CMSIS and XCDL packs.

#### Goals

The goal is to integrate XCDL and CMSIS packs in GNU ARM Eclipse plug-ins.

#### Steps

The initial versions of the XCDL framework was fully written in Python and runs on OS X and GNU/Linux.

The initial version of the Eclipse plug-in implemented the CMSIS Pack v1.2 Pack Installer functionality.

The first priority is to extend the Eclipse plug-in to:

- add a wizard to create new projects, based on existing CMSIS Pack definitions
- add support to manage the CMSIS Real Time Environment, i.e. change the referred components at any time during the lifetime of the project

The second priority is to add XCDL support to the Eclipse plug-in.

The implementation will be mainly in Java, for integration into Eclipse and possibly into Maven. If command line tools will be required, they will be written in Python.

All configuration operations shall be available from command line environments. Additional graphical versions of the tools, running standalone or integrated in Eclipse, are considered for future versions of the framework.

The build process based on the build configurations generated shall be able to run from unattended scripts, to support continuous integration.

### Product functions

The XCDL definitions should be able to describe the dependencies between various software components in order to:

- minimize the number of source files processed during the build
- generate a consistent set of preprocessor definitions
- assist XCDL tools in creating and managing configurations

### User characteristics

There are several roles for XCDL users:

- application software developer, who contributes application code to a given project
- application project manager, who creates and manages application configurations
- enterprise component developers, who create and manage private XCDL components (the equivalent of enterprise libraries) to be used in multiple applications
- open source component developers, who create and manage public XCDL component repositories, like µOS++ III.

### Constraints

The entire XCDL framework should be portable and run on Windows, OS X, and GNU/Linux.

### Assumptions and dependencies

This second version of the SRS is based on the experience of implementing the CMSIS Pack as an Eclipse plug-in, and is intended to support the development of the µOS++ III and the replacement of the C/C++ templates from the GNU ARM Eclipse plug-ins.

The first version of the SRS was based on the initial experience with the first Python prototype version, and was intended to support the development of µOS++ Second Edition.

As implementation will progress, it is possible that new features will be considered.

### Apportioning of requirements

Integration of configuration tools and of generated build configurations with IDEs like Eclipse will be considered in this version of the XCDL framework.

Possible Maven tasks to create repositories will be considered for the next versions.

## Specific requirements

### External interface requirements

<small>Q: How does the software interact with people, the system’s hardware, other hardware, and other software?</small>

The XCDL framework does not directly interact with system hardware, or with other hardware.

It does interact with people, via the Eclipse UI or via the command line interface.

It also interacts with development tools, i.e. generates files to be used by GNU Make.

Future versions might also interact with:

- Maven

#### Interactions with the application developer(s)

During application development, the most often performed operation by the application developer is the build process.

The input is:

- the XCDL configuration

The output is:

- the final application image, usually a binary file.

#### Interactions with the application project manager

The next interaction with people is the creation of the XCDL configurations.

The input is:

- one or several enterprise component repositories
- one or several open source component repositories
- the user selection.

Using the XCDL configuration tool, the project manager selects:

- the board where the application is intended to run
- one or more configuration templates referring to the components needed by the application (like minimal, network, usb, etc)
- the toolchain to be used

The project manager then:

- enables/disables various components
- sets different values to various options, like number of threads, stack sizes, etc

The output of this process is:

- the XCDL configuration.

The XCDL configuration can be later edited, either manually with a text editor, or with the XCDL configuration tools.

#### Interaction with the component developers

The component developers, who create and manage XCDL components (the equivalent of libraries), need to create, in addition to the usual source files, some XCDL component metadata to describe dependencies, requirements and constraints.

There can be enterprise or open source component repositories.

The XCDL component metadata can be edited either with a text editor, or with the XCDL configuration tools.

### Functional requirements

<small>Q: What is the software supposed to do?</small>

The next version of the Eclipse plug-in should add a wizard, to allow the creation of new C/C++ projects based on the definitions found in CMSIS packages and an editor page to change various settings related to components.

#### The XCDL metadata trees

By default, the metadata associated to various software components shall follow the same hierarchy as the folders where the components are stored. Custom hierarchies should be possible, by defining explicit parent nodes.

The tree nodes are XCDL objects, each with specific properties:

- package
- component
- option
- interface
- configuration

Nodes can have distinct status attributes:

- isLoaded
- isActive
- isEnabled
- isConfigurable

Since multiple boards can be supported by an XCDL component repository, it makes no sense to have all existing boards in use during the configuration process, but only the board required for the application. Loading a package automatically loads all parent packages, recursively. Packages not loaded are not presented in the XCDL configuration tools.

Components may have constraints, for example a certain driver may be optimised to use the DMA, but only if the peripheral supports DMA. Common constraints are related to hardware, but software constraints can be defined too. The active/inactive state is automatically computed, and a component is active if and only if all of its constraints are satisfied.

During the configuration process the user may select which components to include in the build and which components are not needed, by manually enabling/disabling components. Disabling a component automatically disables all children components. Components may have requirements, so enabling a component may automatically trigger enabling other components, recursively.

In addition to dependencies definitions, the XCDL metadata should provide some grouping definitions, to assist the XCDL tools in providing meaningful suggestions for major selections, for example when creating a new configuration the list of available boards should be presented.

### Performance requirements

<small>Q: What is the speed, availability, response time, recovery time of various software functions, etc.?</small>

Considering that the XCDL tools will usually run on development machines, which have more than average resources (RAM and CPU), the tools performances shall not be an issue.

### Design constraints

<small>Q: Are there any required standards in effect, implementation language, policies for database integrity, resource limits, operating environment(s) etc.?</small>

The Eclipse plug-in should run on Eclipse Kepler or later.

The XCDL metadata should be stored as XML in standard text files, editable with common text editors.

### Software system attributes

<small>Q: What are the portability, correctness, maintainability, security, etc. considerations?</small>

Being written in Java and Python, the XCDL framework is, at least theoretically, portable.

### Other requirements

<small>Tip: Should not describe any design or implementation details.</small>

- the XCDL framework shall not be specific to a revision control system, svn/git/hg/etc shall be accepted
- the build configs may run on identical or different hardware (different boards, different processors, different amounts of ram/flash, etc); an example of such a config was used for the Metrilog SDI-12 sensors, where the Debug config used a larger AVR than the Release.
- shall allow multiple toolchains
- shall be C/C++ centric and shall handle C/C++ dependencies automatically (obviously)
- shall provide support for testing (continuous integration)
- shall provide support for custom build steps, using external tools (for example for adding a binary checksum, custom metadata, etc)

Future versions:

- should provide as much help as possible to specific steps like flash programming, debug, profiling
- might provide support for documentation generating tools (Doxygen)
