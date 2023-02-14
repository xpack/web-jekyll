---
title: The XCDL metadata (outdated)
permalink: /xcdl/guide/metadata/

comments: true

date: 2015-11-15 12:00:00 +0200

---

> Note: This file needs to be updated for JSON.

The XCDL definitions are a key part of the XCDL component framework. All packages must come with at least one XCDL file, to describe that package to the framework. The information in that file includes details of all the configuration options and how to build the package. Implementing a new component or turning some existing code into an XCDL component always involves writing corresponding XCDL. This chapter provides a description of the XCDL language. Detailed information on specific parts of the language can be found in [Reference]({{ site.baseurl }}/xcdl/reference/metadata/) page.

Language overview
-----------------

XCDL originated as a representation in XML of the original eCos CDL definitions, then several changes were performed and the format was changed to JSON.

A very simple XCDL file would look like this:

    <package name="errors">

      <display>Common error code support</display>
      <description>This package contains the common list of error and
      status codes. It is held centrally to allow
      packages to interchange error codes and status
      codes in a common way, rather than each package
      having its own conventions for error/status
      reporting. The error codes are modelled on the
      POSIX style naming e.g. EINVAL etc. This package
      also provides the standard strerror() function to
      convert error codes to textual representation.</description>

      <sourceFile>strerror.cpp</sourceFile>
      <generatedFile>os/error.h</generatedFile>
      <generatedDefinition>OS_PACKAGE_ERROR</generatedDefinition>

    </package>

This describes a single package, the error code package, which does not have any sub-components or configuration options. The package has a name, *[errors]*, which can be referenced in other XCDL files using e.g. `<requires>isEnabled('errors')</requires>`. There will also be a `#define` for this package in a configuration header file. In addition to the package name, this file provides a number of properties for the package as a whole. The `<display>` property provides a short description. The `<description>` property involves a rather longer one, for when users need a bit more information. The `<sourceFile>` and `<header*>` properties list the consequences of this package at build-time. The package appears to lack any online documentation.

Packages could be even simpler than this. If the package only provides an interface and there are no files to be compiled then there is no need for a compile property. Alternatively if there are no exported header files, or if the exported header files should go to the top-level of the install/include directory, then there is no need for an `<generatedFile>` property. Strictly speaking the `<description>` and `<display>` properties are optional as well, although application developers would not appreciate the resulting lack of information about what the package is supposed to do.

However many packages tend to be a bit more complicated than the error package, containing various subcomponents and configuration options. These are also defined in the XCDL files and in much the same way as the package. For example, the following excerpt comes from the infrastructure package:

    <component name="traceBuffer">

      <display>Buffered tracing</display>
      <description>An output module which buffers output from tracing and
      assertion events. The stored messages are output when an
      assert fires, or OS_TRACE_PRINT() (defined in
      <os/infra/os_trac.h>) is called. Of course, there will
      only be stored messages if tracing per se (OS_DEBUG_USE_TRACING)
      is enabled above.</description>

      <defaultEnable>true</defaultEnable>
      <activeIf>isEnabled('debug/useTracing')</activeIf>
      <generatedDefinition>OS_DEBUG_INFRA_DEBUG_TRACE_ASSERT_BUFFER</generatedDefinition>

      <option name="size">

        <display>Trace buffer size</display>
        <description>The size of the trace buffer. This counts the number of
        trace records stored. When the buffer fills it either
        wraps, stops recording, or generates output.</description>

        <valueType>int</valueType>
        <defaultValue>32</defaultValue>
        <legalValues>5 to 65535</legalValues>
        <generatedDefinition>OS_DEBUG_INFRA_DEBUG_TRACE_BUFFER_SIZE</generatedDefinition>

      </option>

      ...

    </component>

Like a `<package>`, a `<component>` has a name and a body. The body contains various properties for that component, and may also contain subcomponents or options. Similarly an `<option>` has a name and a body of properties. This example lists a number of new properties: `<defaultValue>`, `<activeIf>`, `<valueType>` and `<legalValues>`. The meaning of most of these should be fairly obvious. The next sections describe the various XCDL objects and properties.

XCDL objects
------------

There are several XCDL-related objects which can occur at the top-level of a XCDL file: `<package>`, `<component>`, `<option>` and `<interface>`. These correspond to the basic building blocks of the language. All of these take the same basic form:

    <package name="...">
      ...
    </package>

    <component name="...">
      ...
    </component>

    <option name="...">
       ...
    </option>

    <interface name="...">
      ...
    </interface>

All objects have a mandatory name and, inside their body, a list of properties and an optional list of children objects. All children names must be unique within a given parent. Addressing objects is similar to addressing files in a file system using forward slash separated paths. Paths may be absolute or relative. In addition relative paths may be incomplete, like `isEnabled('traceBuffer/size')`, as long as the uniqueness of the sub-path is assured.

The various XCDL objects live in a hierarchy. There is no upper bound on how far components can be nested, but it is rarely necessary to go more than three or four levels deeper than the package level. Since the naming convention used for referring objects incorporates bits of the hierarchy, this has the added advantage of keeping the names down to a more manageable size.

The hierarchy serves two purposes. It allows options to be controlled en masse, so disabling a component automatically disables all the options below it in the hierarchy. It also permits a much simpler representation of the configuration in the graphical configuration tool, facilitating navigation and modification.

Each package has one top-level XCDL file meta/xcdl.xml. The first object in the top-level file should be `<package>` and there should be only one `<package>` object per package.

By default, an object is placed added to the children list of the top level object defined in the parent folder, so the objects hierarchy follows the file system folders hierarchy, but it is possible to override this using a parent property. This is generally useful for separately distributed packages, to attach in a convenient location in the hierarchy. Components, options and interfaces can also be re-parented, but this is less common.

Components can also contain options and other XCDL objects, in fact that is what distinguishes them from options. These can be defined in the body of the `<component>`:

    <component name="stdio">

      <generatedDefinition>OS_PACKAGE_LIBC_STDIO</generatedDefinition>

      <component name="floating point">

        <generatedDefinition>OS_PACKAGE_LIBC_STDIO_FLOATING_POINT</generatedDefinition>
        ...
      </component>

      <option name="thread safe streams">

        <generatedDefinition>OS_PACKAGE_LIBC_STDIO_THREAD_SAFE_STREAMS</generatedDefinition>
        ...
      </option>

    </component>

Nesting options inside the bodies of components like this is fine for simple packages with only a limited number of configuration options, but it becomes unsatisfactory as the number of options increases. Instead it is possible to split the XCDL data into multiple XCDL file, on a per-component basis. The `<includeFile>` property should be used for this. For example, in the case of the C library all stdio-related configuration options could be put into `stdio.xml`, and the top-level XCDL file `libc.xml` would contain the following:

    <package name="libc">
      ...
      <component name="stdio">
        ...
        <includeFile>stdio.xml</includeFile>
      </component>

    </package>

The objects `component('floating point')` and the `option('thread safe streams')` can then be placed at the top-level of stdio.xml. It is possible to have some options nested in the body of a `<component>` object and other options in a separate file accessed by the `<includeFile>` property. In such a case the nested options would be processed first, and then the other file would be read in. A file specified by a `<includeFile>` property should only define new options, components or interfaces: it should not contain any additional properties for the current component.

It is possible for a component’s XCDL file to have a sub-component which also has a `<includeFile>` property, and so on. In practice excessive nesting like this is rarely useful. It is also possible to ignore the XCDL language support for constructing hierarchies automatically and use the parent property explicitly for every single option and component. Again this is not generally useful.

XCDL properties
---------------

Each package, component, option, and interface has a list of string properties, which provide the component framework with information about how to handle each option. For example there is a property for a descriptive text message which can be displayed to a user who is trying to figure out just what effect manipulating the option would have on the target application. There is another property for the default value, for example whether a particular option should be enabled or disabled by default.

All of the properties are optional, and it is legal (although of little use) to define a configuration option which has an empty body. However some properties are more optional than others: users will not appreciate having to manipulate an option if they are not given any sort of description or documentation.

Because different properties serve very different purposes, their syntax is not as uniform as the top-level objects. Some properties take no arguments at all. Other properties take a single argument such as a description string. In some cases it may be needed to define a list of arguments for a property (such as the `<sourceFile>` property which specifies the file that should be compiled if a given option is active and enabled). In these cases the property will be repeated for each value. The syntax of the property string value depends on the property, and can be anything, from names, texts, integer values, file/folder paths, etc. The `<activeIf>`, `<computed>`, `<defaultValue>`, `<legalValues>` and `<requires>` properties take various expressions.

Many of the properties can be used in any of `<package>`, `<component>`, `<option>` or `<interface>`. Other properties are more specific. The `<includeFile>` property is only relevant to `<component>` objects. The `<generatedFile>`, `<hardware>` properties apply to a package as a whole, so can only occur in the body of a `<package>` object. The `<computed>`, `<defaultValue>`, `<legalValues>` and `<valueType>` properties are not relevant to packages, as will be explained later. The `<computed>` and `<defaultValue>` properties are also not relevant to interfaces.

This section lists the various properties, grouped by purpose. Each property also has a full reference page in [The XCDL language specification]({{ site.baseurl }}/xcdl/guide/metadata/). Properties related to values and expressions are described in more detail in the Section called Values and Expressions. Properties related to header file generation and to the build process are described in [The build process]({{ site.baseurl }}/xcdl/guide/build-process/).

### Information-providing properties

Users can only be expected to manipulate configuration options sensibly if they are given sufficient information about these options. There are three properties which serve to explain an option in plain text: the `<display>` property gives a textual alias for an option, which is usually more comprehensible than something like *[time zones]*; the `<description>` property gives a longer description, typically a paragraph or so; the `<doc>` property specifies the location of additional online documentation related to a configuration option. In the context of a graphical tool the `<display>` string will be the primary way for users to identify configuration options; the `<description>` paragraph will be visible whenever the option is selected; the online documentation will only be accessed when the user explicitly requests it.

    <package name="uitron">

      <display>uITRON compatibility layer</display>
      <description>eCos supports a uITRON Compatibility Layer, providing
      full Level S (Standard) compliance with Version 3.02 of
      the uITRON Standard, plus many Level E (Extended) features.
      uITRON is the premier Japanese embedded RTOS standard.</description>
      <doc>ref/ecos-ref.a.html</doc>

      <generatedDefinition>OS_PACKAGE_UITRON</generatedDefinition>

    </package>

All three properties take a single argument. For display and description this argument is just a string. For doc it should be a pointer to a suitable HTML file, optionally including an anchor within that page. If the directory layout conventions are observed then the component framework will look for the HTML file in the package’s doc subfolder, otherwise the `<doc>` filename will be treated as relative to the package’s top-level directory.

### The configuration hierarchy

There are two properties related to the hierarchical organization of components and options: `<parent>` and `<includeFile>`.

The `<parent>` property can be used to move a XCDL entity somewhere else in the hierarchy. The most common use is for packages, to avoid having all the packages appear at the top-level of the configuration hierarchy. For example an architectural HAL package such as SH is placed below the common HAL package using a parent property.

    <package name="sh">

      <display>SH architecture</display>

      <parent>hal</parent>
      ...
    </package>

The `<parent>` property can also be used in the body of a `<component>`, `<option>` or `<interface>`, but this is less common. However care has to be taken since excessive re-parenting can be confusing. Care also has to be taken when re-parenting below some other package that may not actually be loaded in a given configuration, since the resulting behaviour is undefined.

The `<includeFile>` property can only be used in the body of a `<component>` object. The property takes a single filename as argument, and this should be another XCDL file containing additional options, subcomponents and interfaces that should go below the current component in the hierarchy. If the directory layout conventions are observed then the component framework will look for the specified file relative to the meta subdirectory of the package, otherwise the filename will be treated as relative to the package’s top-level directory.

    <component name="stdio">

      <display>Standard input/output functions</display>
      <description>This enables support for standard I/O functions from <stdio.h>.</description>

      <requires>isEnabled('io')</requires>
      <requires>isEnabled('io/haldiag/serial')</requires>

      <valueType>bool</valueType>
      <defaultValue>true</defaultValue>
      <includeFile>stdio.xml</includeFile>
      <generatedDefinition>OS_PACKAGE_LIBC_STDIO</generatedDefinition>

    </component>

### Value-related properties

There are seven properties which are related to option values and state: `<valueType>`, `<computed>`, `<defaultValue>`, `<legalValues>`, `<activeIf>`, `<implements>`, and `<requires>`. More detailed information can be found in the section called Values and Expressions.

In the context of configurability, the concept of an option’s value is somewhat non-trivial. First an option may or may not be loaded: it is possible to build a configuration which has the math library but not the kernel; however the math library’s XCDL file still reference kernel options, for example *[libm/threadSafeCompatMode]* has a <requires> constraint on *[kernel/threadsData]*. Even if an option is loaded it may or may not be active, depending on what is happening higher up in the hierarchy: if the C library’s `component('libc/stdio')` is disabled then some other options such as `option('libc/stdio/buffsize')` become irrelevant. In addition each option has both a boolean enabled/disabled flag and a data part. For many options only the boolean flag is of interest, while for others only the data part is of interest. The <valueType> property can be used to control this:

-   `<valueType>enabled</valueType>` <br>
This type indicates that neither the boolean nor the data parts are user-modifiable: if active, the option is enabled and the data is always set to true. The most common use for this is to have a component that just acts as a placeholder in the hierarchy, allowing various options to be grouped below it.

-   `<valueType>none</valueType>` <br>
This type indicates that only the boolean part is user-modifiable: if active, the option can be enabled/disabled and the data always follow the isEnabled() value. The most common use for this is to have a component that just acts as a placeholder in the hierarchy, allowing various options to be grouped below it. To make the option non user-configurable, use `<configurable>false</configurable>`.

-   `<valueType>bool \| int \| float \| string</valueType>` <br>
Both the boolean and the data part of the option are user-modifiable. To make the boolean part non user-configurable, use `<configurable>false</configurable>`. To make the data part non user-configurable, use `<computed>true</computed>`.

For more details of XCDL flavors and how a flavour affects expression evaluation, and other consequences, see the Section called Values and Expressions.

The `<valueType>` property cannot be used for a package because packages always have the *string* type. Options and components have the *none* type by default, since most configuration choices are simple yes-or-no choices. Interfaces have the *int* type by default.

The `<configurable>` property can disable the change of the boolean part in the interface, so the option cannot be enabled/disabled by the user.

The `<computed>` property can be used for options which should not be user-modifiable, but which instead are fixed by the target hardware or determined from the current values of other options. In general calculated options should be avoided, since they can be confusing to users who need to figure out whether or not a particular option can actually be changed. There are a number of valid uses for calculated options, and quite a few invalid ones as well. The reference packages should be consulted for further details. The property takes an ordinary XCDL expression as argument, for example:

    <!-- A constant on some target hardware, perhaps user-modifiable on other targets. -->
    <option name="period">

      <display>Real-time clock period</display>

      <valueType>int</data>
      <computed>12500</calculated>
      <generatedDefinition>OS_INTEGER_HAL_RTC_PERIOD</generatedDefinition>

    </option>

The `<computed>` property cannot be used for packages or interfaces. The value of a package always corresponds to the version of that package which is loaded, and this is under user control. Interfaces are implicitly calculated, based on the number of active and enabled implementers.

The `<defaultValue>` property is similar to `<computed>`, but only specifies a default value which users can modify. Again this property is not relevant to packages or interfaces. A typical example would be:

    <option name="threadSupport">

      <display>Include GDB multi-threading debug support</display>

      <parent>hal/gdb</parent>
      <generatedDefinition>OS_DEBUG_HAL_DEBUG_GDB_THREAD_SUPPORT</generatedDefinition>
      <requires>isEnabled('kernel/debug/gdb/threadSupport')</requires>
      <defaultValue>valueOf('kernel/debug/gdb/threadSupport')</defaultValue>
        ...
    </option>

The `<legalValues>` property imposes a constraint on the possible values of the data part of an option. Hence it is only applicable to options with the data or booldata flavors. It cannot be used for a package since the only valid value for a package is its version number. The arguments to the `<legalValues>` property should constitute a XCDL list expression.

    <component name="libc">

      ...

      <option name="stdDefaultOffset">

        <display>Default Standard Time offset</display>

        <generatedDefinition>OS_INTEGER_LIBC_TIME_STD_DEFAULT_OFFSET</generatedDefinition>
        <valueType>int</valueType>
        <legalValues>-90000 to 90000</legalValues>
        <defaultValue>0</defaultValue>
        ...
      </option>
    </component>

The `<activeIf>` property does not relate directly to an option’s value, but rather to its active state. Usually this is controlled via the configuration hierarchy: if the *[libc/stdio]* component is disabled then all options below it are inactive and do not have any consequences. In some cases the hierarchy does not provide sufficient control, for example an option should only be active if two disjoint sets of conditions are satisfied: the hierarchy could be used for one of these conditions, and an additional `<activeIf>` property could be used for the other one. The arguments to `<activeIf>` should constitute a XCDL goal expression.

    <!--  Do not provide extra semaphore debugging if there are no semaphores -->
    <option name="binsem">

      <parent>kernel/instrument</parent>
      <generatedDefinition>OS_DEBUG_KERNEL_INSTRUMENT_BINSEM</generatedDefinition>
      <activeIf>isEnabled('kernel/synch')</activeIf>
      ...
    </option>

The `<implements>` property is related to the concept of XCDL interfaces. If an option is active and enabled and it implements a particular interface then it contributes 1 to that interface’s value.

    <package name="edb7xxx">

      <parent>net/drivers/eth</parent>

      <display>Cirrus Logic ethernet driver</display>

      <implements>net/drivers/if</implements>
      ...
    </package>

The <requires> property is used to impose constraints on the user’s choices. For example it is unreasonable to expect the C library to provide thread-safe implementations of certain functions if the underlying kernel support has been disabled, or even if the kernel is not being used at all.

    <option name="perThreadErrno">

      <parent>libc</parent>
      <display>Per-thread errno</display>
      <doc>ref/ecos-ref.15.html</doc>

      <generatedDefinition>OS_PACKAGE_LIBC_PER_THREAD_ERRNO</generatedDefinition>
      <requires>isEnabled('kernel/threadsData')</requires>
      <defaultEnable>true</defaultEnable>
      ...
    </option>

The arguments to the `<requires>` property should be a XCDL goal expression.

### Generating the configuration header files

When creating or updating a build tree the component framework will also generate configuration header files, one per package. By default it will generate a `#define` for each option, component or interface that is active and enabled that defines a `<generatedDefinition>`. For options with the data or booldata flavors the `#define` will use the option’s data part, otherwise it will use the constant 1. Typical output would include:

    #define OS_PACKAGE_LIBC_TIME_POSIX (1)
    #define OS_INTEGER_LIBC_TIME_DST_DEFAULT_STATE (-1)

There are several properties which can be used to control the header file generation process: `<generatedFile>`, `<generatedDefinition>`, `<valueFormat>`.

The component framework will generate a configuration header file based on the `<generatedFile>` property. If this property is not defined for the current object, the `<parent>` property is used.

    <package name="sparclite">

      <display>SPARClite architecture</display>

      <parent>hal</parent>
      <hardware/>
      <generatedFile>hal_sparclite.h</generatedFile>
      <generatedDefinition>OS_PACKAGE_HAL_SPARCLITE</generatedDefinition>
      ...
    </package>

The `<valueFormat>` property can be used to control how the value part of the default `#define` gets formatted. For example a format string of "0x%04x" could be used to generate a four-digit hexadecimal number.

### Controlling what gets built

There are several properties which affect the build process: `<sourceFile>`.

Most of the source files that go into a package should simply be compiled with the appropriate compiler, selected by the target architecture, and with the appropriate flags, with an additional set defined by the target hardware and possible modifications on a per-package basis. The `<sourceFile>` property is used to list these source files:

    <package name="errors">

      <display>Common error code support</display>

      <sourceFile>strerror.cpp</sourceFile>
      ...
    </package>

The arguments to the `<sourceFile>` property should be one source file. Typically most of the sources will be needed for the package as a whole, and hence they will be listed in several `<sourceFile>` properties in the object body. Some sources may be specific to particular configuration options, in other words there is no point in compiling them unless that option is enabled, in which case the sources should be listed in a compile property in the corresponding `<option>`, `<component>` or `<interface>` body.

Some packages may have more complicated build requirements, for example they may involve a special target such as a linker script which should not end up in the usual library, or they may involve special build steps for generating an object file. The `<make>` and `<make_object>` properties provide support for such requirements, for example:

    <package name="am33">

      <display>MN10300 AM33 variant</display>
      <parent>hal/mn10300</parent>
      ...
      <make>
        <PREFIX>/lib/target.ld: <PACKAGE>/src/mn10300_am33.ld
        $(CC) -E -P -Wp,-MD,target.tmp -DEXTRAS=1 -xc $(INCLUDE_PATH) \
        $(CFLAGS) -o $@ $<
        @echo $@ ": \\" > $(notdir $@).deps @tail +2 target.tmp >> $(notdir $@).deps @echo >> $(notdir $@).deps
        @rm target.tmp</make>
    </package>

(not implemented)

For full details of custom build steps and the build process generally, see [The build process]({{ site.baseurl }}/xcdl/guide/build-process/).

The `<generatedFile>` property relates to an object’s exported header files. To avoid any mistakes, this property must be explicitly defined:

    <package name="infra">

      <display>Infrastructure</display>

      <generatedFile>os/infra.h</generatedFile>
      ...
    </package>

The various header definition exported by the infrastructure, will now end up in the os/infra.h folder.

### Miscellaneous properties

The `<hardware>` property is only relevant to packages. Some packages such as device drivers and HAL packages are hardware-specific, and generally it makes no sense to add such packages to a configuration unless the corresponding hardware is present on your target system. Typically hardware package selection happens automatically when you select your target. The `<hardware>` property should be used to identify a hardware-specific package, and does not take any arguments.

    <package name="mips">

      <display>MIPS architecture</display>

      <parent>hal</parent>
      <hardware/>
      <generatedFile>os/hal/hal_mips.h</generatedFile>
      ...
    </package>

Option naming convention
------------------------

TBD

Values and expressions
----------------------

It is fairly reasonable to expect that enabling or disabling a configuration option such as `option('kernel/threads data')` in some way affects its value. This will have an effect on any expressions that reference this option such as `<requires>option('kernel/threads data')</requires>`. It will also affect the consequences of that option: how it affects the build process and what happens to any constraints that `option('kernel/threads data')` may impose (as opposed to constraints on this option imposed by others).

In a language like C the handling of variables is relatively straightforward. If a variable x gets referenced in an expression such as if (x != 0), and that variable is not defined anywhere, then the code will fail to build, typically with an unresolved error at link-time. Also in C a variable x does not live in any hierarchy, so its value for the purposes of expression evaluation is not affected by anything else. C variables also have a clear type such as int or long double.

In XCDL things are not so straightforward.

Option values
-------------

There are four factors which go into an option’s value:

1.  An option is part of a package that may or may not be loaded
2.  If the parent package is loaded, the option may or may not be active
3.  Even if the option is active, it may or may not be enabled
4.  If the option is in a loaded package, is active and enabled, then it will have some associated data which constitutes its value.

### Is the option **loaded**?

At any one time a configuration will contain only a subset of all possible packages. In fact it is impossible to combine certain packages in a single configuration. For example architectural HAL packages should contain a set of options defining endianness, the sizes of basic data types and so on (many of which will of course be constant for any given architecture). Any attempt to load two architectural HAL packages into a configuration will fail because of the resulting name clash. Since XCDL expressions can reference options in other packages, and often need to do so, it is essential to define the resulting behaviour.

One complication is that the component framework does not know about every single option in every single package. Obviously it cannot know about packages from arbitrary third parties which have not been installed. If a XCDL expression contains a reference to some `option('kernel/sched timeslice')` then the component framework will only know about this option if the kernel package is actually loaded into the current configuration.

Any options which are not in the current configuration are handled as follows:

1.  Any references to that option will evaluate to 0/false, so `valueOf('...') == 0/false`, `isLoaded('...') == false`, `isActive('...') == false`, `isEnabled('...') == false`.
2.  An option that is not loaded has no consequences on the build process. It cannot directly result in any `#define`’s in a configuration header file, nor in any files being compiled. This is only reasonable: if the option is not loaded then the component framework has no way of knowing about any compile or similar properties. An option that is not loaded can have indirect consequences by being referenced in XCDL expressions.
3.  An option that is not loaded cannot impose any constraints on the rest of the configuration. Again this is the only reasonable behaviour: if the option is not loaded then any associated requires or `<legalValues>` properties will not be known.

### Is the option **active**?

The next issue to consider is whether or not a particular option is active. Configuration options are organized in a hierarchy of components and sub-components. For example the C library package contains a `component('libc/stdio')` containing all the options related to standard I/O. If a user disables the component as a whole then all the options below it become inactive: it makes no sense to disable all stdio functionality and then manipulate the buffer sizes.

Inactive is not quite the same as disabled, although the effects are similar. The value of an inactive option is preserved. If the user modifies a buffer size option, then disables the whole stdio component, the buffer size value remains in case the stdio component is re-enabled later on. Some tools such as the graphical configuration tool will treat inactive options specially, for example such options may be greyed out.

The active or inactive state of an option may affect other packages. For example a package may use the `sprintf()` function and require support for floating point conversions, a constraint that is not satisfied if the relevant option is inactive. It is necessary to define exactly what it means for an option to be inactive:

1.  An option is inactive if its parent is either inactive or disabled. For example if `component('libc/stdio')` is disabled then all the options and sub-components become inactive; since `component('libc/stdio/floating point')` is now inactive, `component('libc/stdio/floating point/printf')` is inactive as well.
2.  Options may also be inactive as a result of an `<activeIf>` property. This is useful if a particular option is only relevant if two or more disjoint sets of conditions need to be satisfied, since the hierarchical structure can only cope with at most one such set.
3.  If an option is inactive then any references to that option in XCDL expressions will evaluate to 0/false. So `valueOf('...') == 0/false`, `isActive('...') == false`, `isEnabled('...') == false`.
4.  An option that is inactive has no consequences on the build process. No `#define` will be generated. Any compile or similar properties will be ignored.
5.  An option that is inactive cannot impose any constraints on the rest of the configuration. For example `option('libc/stdio/floating point/printf')` has a dependency `<requires>isEnabled('libm')</requires>`, but if all of the stdio functionality is disabled then this constraint is ignored (although of course there may be other packages which have a dependency on `package('libm')`).

### Is the option **enabled**? What is the option value?

The majority of configuration options are boolean in nature, so the user can either enable or disable some functionality. Some options are different. For example `valueOf('libc/stdio/bufsize')` is a number, and `valueOf('libc/stdio/default console')` is a string corresponding to a device name. XCDL has to cope with this variety, and define the exact behaviour of the system in terms of constraints and build-time consequences.

In XCDL the value of an option consists of two parts. There is a boolean part, controlling whether or not the option is enabled, that can be accessed with `isEnabled('...')`. There is also a data part, providing additional information and accessed with `valueOf('...')`. For most options one of these parts is fixed, as controlled by the option’s `<valueType>` property:

|valueType|isEnabled()|valueOf() when enabled|valueOf() when disabled|
|---------|-----------|----------------------|-----------------------|
|enabled|isActive()|isEnabled(), not modifiable|false|
|none|User-modifiable|isEnabled(), not modifiable|false|
|bool|User-modifiable|User-modifiable|false|
|int|User-modifiable|User-modifiable|0|
|float|User-modifiable|User-modifiable|0.0|
|string|User-modifiable|User-modifiable|"" (empty)|

The effects of the boolean and data parts are as follows:

1.  If an option is inactive, or disabled by the user, in other words if the boolean part is false, then `isEnabled('...') == false` and `valueOf('...')` is 0/false/"". The data part is not relevant. The type *enabled* specify that the option is always enabled, and the user cannot disable it.
2.  If an option is enabled then any references to `valueOf('...')` in XCDL expressions will evaluate to the option’s data part, user-modifiable or fixed. For type *enabled*, this data part is fixed to the constant *true*. For type *none*, or when the type is not defined, `valueOf('...')` will return `isEnabled('...')`, modifiable by the user.
3.  If a component or package is disabled then all sub-components and options immediately below it in the hierarchy are inactive. By a process of recursion this will affect all the nodes in the subtree.
4.  If an option is disabled then it can impose no constraints on the rest of the configuration, in particular `<requires>` and `<legalValues>` properties will be ignored. If an option is enabled then its constraints should be satisfied, or the component framework will report various conflicts. Note that the `<legalValues>` constraint only applies to the data part of the option’s value, so it is only useful with the *int, float, string* types. Options with type *enabled* are always enabled so their constraints always have to be satisfied (assuming the option is active).
5.  If an option is disabled then it has no direct consequences at build-time, in particular `<generatedDefinition>` and `<sourceFile>` properties will be ignored: no `#define` will be generated, no files will get compiled, and so on. If an option is active and enabled then all the consequences take effect. The option name and data part are used to generate the `#define` in the appropriate configuration header file, subject to various properties such as `<valueFormat>`, but the data part has no other effects on the build system.

Setting `<configurable>false</configurable>` prevents the user to manually change the enable/disable status of an option (the checkbox will be disabled in the interface). Setting the `<computed>` property prevents the user to manually change the value of an option (the text control will be disabled in the interface).

By default all options and components have the type *none*: most options are simple selections, so making this the default allows for slightly more compact XCDL files. Packages have the type *string*, where the data part always corresponds to the version of the package that is loaded into the configuration: changing this value corresponds to unloading the old version and loading in a different one.

### Some examples

The following definitions, can be used to illustrate how values and flavors work in practice:

    <package name="libc">
      <component name="rand">

        <valueType>none</valueType>
        <defaultEnable>false</defaultEnable>

        <sourceFile>stdlib/rand.cpp</sourceFile>
        <generatedDefinition>OS_PACKAGE_LIBC_RAND</generatedDefinition>

        <option name="perThread">
          <generatedDefinition>OS_PACKAGE_LIBC_PER_THREAD_RAND</generatedDefinition>
          <requires>isEnabled('kernel/perThreadData')</requires>
          <defaultEnable>false</defaultEnable>
        </option>

        <option name="seed">
          <generatedDefinition>OS_INTEGER_LIBC_RAND_SEED</generatedDefinition>
          <valueType>int</valueType>
          <legalValues>0 to 0x7FFFFFFF</legalValues>
          <defaultValue>1</defaultValue>
        </option>

        <option name="traceLevel">
          <generatedDefinition>OS_INTEGER_LIBC_RAND_TRACE_LEVEL</generatedDefinition>
          <valueType>int</valueType>
          <legalValues>0 to 1</legalValues>
          <defaultValue>0</defaultValue>
        </option>
      </component>
    </package>

TODO
----

-   clarify/add support to define library files, linker scripts, header files, include folders
-   clarify the link between XCDL configurations and Eclipse configurations
-   clarify/add support to define the artefact type as library/executable; also consider for static/shared libraries
-   clarify the additional properties needed for <package>, to make it compatible with CMSIS Pack
-   clarify/add support to define boards

Credits
-------

The initial content of this page was based on *Chapter 3. The CDL Language* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
