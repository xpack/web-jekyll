---
title: The build process (outdated)
permalink: /xcdl/guide/build-process/

comments: true

date: 2015-10-25 12:00:00 +0200

---

Note: this page is still based on the Python version!

Some XCDL properties describe the consequences of manipulating configuration options. There are two main types of consequences.

-   Typically enabling a configuration option results in one or more `#define`’s in a configuration header file, and properties that affect this include `<generatedHeader>`, `<generatedDefinition>`, `<valueFormat>` and `<childrenGeneratedHeader>` (*define*, *define_proc* and *no_define*).
-   Enabling a configuration option can also affect the build process, primarily determining which files are used in the built. Properties related to the build process include `<sourceFile>` and make.

This chapter describes the whole build process, including details such as compiler flags and custom build steps.

Part of the overall design of the XCDL component framework is that it can interact with at least two different build systems. The most obvious of these is *GNU make*: the component framework can generate one or more makefiles, and the user can then build the various packages simply by invoking `make`. The second build system supported is Eclipse CDT: it should be possible to incorporate part of the component framework into an Eclipse plug-in to generate CDT projects using XCDL components and to later mange them.

However it should also be possible to use XCDL components in environments : the component framework can be queried about what is involved in building a given configuration, and this information can then be fed into the desired build system. Component writers should be aware of this possibility. Most packages will not be affected because the compile property can be used to provide all the required information, but care has to be taken when writing custom build steps.

## Build tree generation

It is necessary to create an XCDL configuration before anything can be built. With some tools such as the graphical configuration tool this configuration will be created in memory, and it is not essential to produce an .xcdlconfig.xml file first (although it is still very desirable to generate such a configuration file at some point, to allow the configuration to be re-loaded later on). With other tools the file is generated first, for example using ecosconfig new, and then a build tree is generated using ecosconfig tree. The savefile contains all the information needed to recreate a configuration.

An XCDL build actually involves three separate trees. The component repository acts as the source tree, and for application developers this should be considered a read-only resource. The build tree is where all intermediate files, especially object files, are created. In some instances there may also be an install tree where the result of the build end up. Following a successful build it is possible to take just the install tree and use it for developing an application: none of the files in the component repository or the build tree are needed for that. The build tree will be needed again only if the user changes the configuration. However the install tree does not contain copies of all of the documentation for the various packages, instead the documentation is kept only in the component repository.

By default the build tree, the install tree, and the configuration file all reside in the same directory tree. This is not a requirement, both the install tree and the configuration can be anywhere in the file system.

It is worth noting that the component framework does not separate the usual make and make install stages. A build always populates the install tree, and any make install step would be redundant.

The install tree will always begin with two directories, include for the exported header files and lib for the main library libtarget.a and other files such as the linker script. In addition there will be a subdirectory include/pkgconf containing the configuration header files, which are generated or updated at the same time the build tree is created or updated. More details of header file generation are given below. Additional include subdirectories such as sys and cyg/kernel will be created during the first build, when each package’s exported header files are copied to the install tree. The install tree may also end up with additional subdirectories during a build, for example as a result of custom build steps.

The component framework does not define the structure of the build tree, and this may vary between build systems. It can be assumed that each package in the configuration will have its own directory in the build tree, and that this directory will be used for storing the package’s object files and as the current directory for any build steps for that package. This avoids problems when custom build steps from different packages generate intermediate files which happen to have the same name.

Some build systems may allow application developers to copy a source file from the component repository to the build tree and edit the copy. This allows users to experiment with small changes, for example to add a couple of lines of debugging to a package, without having to modify the master copy in the component repository which could be shared by several projects or several people. Functionality such as this is transparent to component writers, and it is the responsibility of the build system to make sure that the right thing happens.

Note: There are some unresolved issues related to the build tree and install tree. Specifically, when up- dating an existing build or install tree, what should happen to unexpected files or directories? Suppose the user started with a configuration that included the math library, and the install tree contains header files include/math.h and include/sys/ieeefp.h. The user then removed the math library from the configuration and is updating the build tree. It is now desirable to remove these header files from the install tree, so that if any application code still attempts to use the math library this will fail at compile time rather than at link time. There will also be some object files in the existing libtarget.a library which are no longer appropriate, and there may be other files in the install tree as a result of custom build steps. The build tree will still contain a directory for the math library, which no longer serves any purpose. However, it is also possible that some of the files in the build tree or the install tree were placed there by the user, in which case removing them automatically would be a bad idea. At present the component framework does not keep track of exactly what should be present in the build and install trees, so it cannot readily determine which files or library members are obsolete and can safely be removed, and which ones are unexpected and need to be reported to the user. This will be addressed in a future release of the system.

## Configuration Header File Generation

Configuration options can affect a build in two main ways. First, enabling a configuration option or other CDL entity can result in various files being built and added to a library, thus providing functionality to the application code. However this mechanism can only operate at a rather coarse grain, at the level of entire source files. Hence the component framework also generates configuration header files containing mainly C preprocessor `#define` directives. Package source code can then `#include` the appropriate header files and use `#if`, `#ifdef` and `#ifndef` directives to adapt accordingly. In this way configuration options can be used to enable or disable entire functions within a source file or just a single line, whichever is appropriate.

The configuration header files end up in the include/pkgconf subdirectory of the install tree. There will be one header file for the system as a whole, pkgconf/system.h, and there will be additional header files for each package, for example pkgconf/kernel.h. The header files are generated when creating or updating the build and install trees, which needs to happen after every change to the configuration.

The component framework processes each package in the configuration one at a time. The exact order in which the packages are processed is not defined, so the order in which `#define`’s will end up in the global pkgconf/system.h header may vary. However for any given configuration the order should remain consistent until packages are added to or removed from the system. This avoids unnecessary changes to the global header file and hence unnecessary rebuilds of the packages and of application code because of header file dependency handling.

Within a given package the various components, options and interfaces will be processed in the order in which they were defined in the corresponding CDL scripts. Typically the data in the configuration headers consists only of a sequence of `#define`'s so the order in which these are generated is irrelevant, but some properties such as define_proc can be used to add arbitrary data to a configuration header and hence there may be dependencies on the order. It should be noted that re-parenting an option below some other package has no effect on which header file will contain the corresponding `#define`: the preprocessor directives will always end up in the header file for the package that defines the option, or in the global configuration header.

There are six properties which affect the process of generating header files: define_header, no_define, de- fine_format, define, if_define, and define_proc.

The define_header property can only occur in the body of a cdl_package command and specifies the name of the header file which should contain the package’s configuration data, for example:

```xml
<package name="somePackage">
    define_header xyzzy.h
</package>
```

Given such a define_header property the component framework will use the file pkgconf/xyzzy.h for the package’s configuration data. If a package does not have a define_header property then a suitable file name is constructed from the package’s name. This involves:

1.  All characters in the package name up to and including the first underscore are removed. For example CYGPKG_KERNEL is converted to KERNEL, and CYGPKG_HAL_ARM is converted to HAL_ARM.
2.  Any upper case letters in the resulting string will be converted to lower case, yielding e.g. kernel and hal_arm.
3.  A .h suffix is appended, yielding e.g. kernel.h and hal_arm.h.

Because of the naming restrictions on configuration options, this should result in a valid filename. There is a small possibility of a file name class, for example CYGPKG_PLUGH and CYGPKG_plugh would both end up trying to use the same header file pkgconf/plugh.h, but the use of lower case letters for package names violates the naming conventions. It is not legal to use the define_header property to put the configuration data for several packages in a single header file. The resulting behaviour is undefined.

Once the name of the package’s header file has been determined and the file has been opened, the various components, options and interfaces in the package will be processed starting with the package itself. The following steps are involved:

TODO: add them

## Building µOS++

TBD

## Building Test Cases

TBD

## Credits

The initial content of this page was based on *Chapter 4. The Build Process* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
