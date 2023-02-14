---
title: The XCDL metadata reference (outdated)
permalink: /xcdl/reference/metadata/

comments: true

date: 2015-11-15 12:00:00 +0200

tocLevels: 1
---

> Note: This file needs to be updated for JSON.

## Introduction

This chapter contains reference information for the main XCDL objects `<option>`, `<component>`, `<package>`; and `<interface>`, followed by the various properties such as `<activeIf>` and `<sourceFile>` in alphabetical order.

## Mandatory properties

All hierarchical objects must have the following properties defined:

-   `<object name="...">` - the internal identifier of the object, unique within the set of all configuration trees used together; passed as an XML attribute

Although not mandatory, it is strongly recommended to also define the following object properties:

-   `<display>...</display>` - a short, human readable, descriptive name (a few words) of the object, to be used in the user interface during the configuration process
-   `<description>...</description>` - a long, comprehensive description of the object, to be used as reference by the user during the configuration process.

## The `<option>` object

### Purpose

Define a single configuration option.

### Syntax

    <option name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </option>

### Description

The `<option>` object is the basic unit of configurability. Generally each option corresponds to a single user choice. Typically there is a certain amount of information associated with an option to assist the user in manipulating that option, for example a textual description. There will also be some limits on the possible values that the user can choose, so an option may be a simple yes-or-no choice or it may be something more complicated such as an array size or a device name. Options may have associated constraints, so if that option is enabled then certain conditions have to satisfied elsewhere in the configuration. Options usually have direct consequences such as preprocessor `#define` symbols in a configuration header file.

`<option>` is defined as a XML element that has one name attribute and a body. Within a single configuration, names must be unique. If a configuration contained two packages which defined the same entity, any references to that entity in a `<requires>` property or any other expression would be ambiguous. It is possible for a given name to be used by two different packages if those packages should never be loaded into a single configuration. For example, architectural HAL packages are allowed to reuse names because a single configuration cannot target two different architectures. For a recommended naming convention see the Section called Package Contents and Layout in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages).

The user choice is expressed during the configuration process and is reflected in the enabled/disabled statues of the option. For options with associated values, it is also possible for the user to define a value (if missing, a default value, either implicit or defined as the property `<defaultValue>`, is applied). For these options it is also possible to define some limits on the possible values that the user can choose.

A separate class of options are the `<computed>` options, whose values cannot be set by the user, but are computed according to a given expression.

Options may have associated constraints, so if this option is enabled then certain conditions have to be satisfied elsewhere in the configuration for it to be active (the `<activeIf>` property) or it may mandate for some objects to be enabled or disabled (the `<requires>` property).

If active and enabled, `<option>` can generate preprocessor `#define` lines in a configuration header file (if the `<generatedDefinition>` property is also defined), and decide if a set of source files are included in the build process (if the `<sourceFile>` property is also defined).

### Containers

*Options* are not containers, so they cannot hold other objects (like `<option>` or `<component>`).

### Optional properties

 -   `<activeIf>` - a list of expressions to be evaluated; if all are true, the active state of this option remains true
 -   `<category>` - provides additional grouping information, to allow a configuration tool to provide appropriate selection (board \| synthetic \| root \| architecture \| family)
 -   `<computed>` - the option’s value is not directly user-modifiable, it is calculated using a suitable expression
 -   `<configurable>` - a boolean expression that provides additional information to a configuration tool, to control if this option can be enabled/disabled by the user during the configuration process
 -   `<defaultEnabled>` - a boolean expression that provides an initial value for the option enabled/disabled state
 -   `<defaultValue>` - an expression to be used as a default value for this option, when the user does not define it explicitly during the configuration process
 -   `<generatedDefinition>` - a valid C preprocessor identifier to be defined in the header file if the option is active and enabled
 -   `<generatedFile>` - the full path file name of the header where the option will generate a definition (if missing, inherited from the parent node)
 -   `<implements>` - a list of ids of the interfaces implemented by this option
 -   `<legalValues>` - a list of restrictions the value of this options must satisfy
 -   `<parent>` - provides a method to break the default hierarchy and directly specify the id of the parent of this option
 -   `<requires>` - a list of ids of other objects to be enabled when this option is enabled
 -   `<sourceFile>` - a list of source files that should be built if this option is active and enabled
 -   `<valueType>` - specify the type of the variable associated with this option (none | bool | int | float | string)
 -   `<valueFormat>` - control how the option’s value will appear in the configuration header file

### Example

    <option name="preconditions">

      <parent>infra/debug</parent>
      <display>Preconditions</display>
      <description>This option allows individual control of preconditions.
      A precondition is one type of assert, which it is
      useful to control separately from more general asserts.
      The function is OS_PRECONDITION(condition,msg).</description>

      <generatedDefinition>OS_DEBUG_INFRA_DEBUG_PRECONDITIONS</generatedDefinition>
      <defaultEnable>true</defaultEnable>
    </option>

The `<component>` object
--------------------------

### Purpose

Define a component, a collection of configuration objects.

### Syntax

    <component name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </component>


### Description

The `<component>` object is a configuration element that can contain additional options and subcomponents. A `<component>` can have the same properties as an `<option>`. There is an additional property, `<includeXcdl>` which allows configuration data to be split into multiple files, included below the current object in the configuration hierarchy.

The `<component>` object is implemented as a XML element that has one name attribute and a body. Within a single configuration, names must be unique. If a configuration contained two packages which defined the same entity, any references to that entity in a `<requires>` property or any other expression would be ambiguous. It is possible for a given name to be used by two different packages if those packages should never be loaded into a single configuration. For example, architectural HAL packages are allowed to reuse certain names because a single configuration cannot target two different architectures. For a recommended naming convention see the Section called Package Contents and Layout in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages).

Similarly to `<option>` objects, if active and enabled, `<component>` objects can generate preprocessor `#define` lines in a configuration header file, and decide if a set of source files are included in the build process.

### Containers

*Components* are containers, so it is possible for a component to include `<component>`, `<option>`, `<interface>` and `<configuration>` objects that should go below this object in the configuration hierarchy. These objects can be defined either as embedded children, or can be read from included files.

### Optional properties

 -   `<activeIf>` - a list of expressions to be evaluated; if all are true, the active state of this component remains true
 -   `<category>` - provides additional grouping information, to allow a configuration tool to provide appropriate selections (board | synthetic | root | architecture | family)
 -   `<childrenGeneratedFile>` - the full path file name of the header where the children nodes will generate a definition (if missing, inherited from the parent node)
 -   `<computed>` - the component’s value is not directly user-modifiable, it is calculated using a suitable expression
 -   `<configurable>` - a boolean expression that provides additional information to a configuration tool, to control if this component can be enabled/disabled by the user during the configuration process
 -   `<defaultEnabled>` - a boolean expression that provides an initial value for the component enabled/disabled state
 -   `<defaultValue>` - an expression to be used as a default value for this component, when the user does not define it explicitly during the configuration process
 -   `<generatedDefinition>` - a valid C preprocessor identifier to be defined in the header file if the component is active and enabled
 -   `<generatedFile>` - the full path file name of the header where the component will generate a definition (if missing, inherited from the parent node)
 -   `<implements>` - a list of ids of the interfaces implemented by this component
 -   `<includeXcdl>` - a list of XCDL metadata files to be parsed and whose objects to be included as children of the current node
 -   `<legalValues>` - a list of restrictions the value of this component must satisfy
 -   `<parent>` - provides a method to break the default hierarchy and directly specify the id of the parent of this component
 -   `<requires>` - a list of ids of other objects to be enabled when this component is enabled
 -   `<sourceFile>` - a list of source files that should be built if this component is active and enabled
 -   `<valueType>` - specify the type of the variable associated with this component (none | bool | int | float | string)
 -   `<valueFormat>` - control how the component's value will appear in the configuration header file

### Example

    <component name="useAsserts">

      <display>Use asserts</display>
      <description>If this component is enabled, assertions in the code are
      tested at run-time. Assert functions (OS_ASSERT()) are
      defined in ’include/os/infra/os_ass.h’ within the ’install’
      tree. If the component is disabled, these result in no
      additional object code and no checking of the asserted
      conditions.</description>

      <defaultEnable>true</defaultEnable>
      <includeXcdl>assert.xml</includeXcdl>
    </component>

The `<package>` object
------------------------

### Purpose

Define a package, a special component, that can be distributed separately.

### Syntax

    <package name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </package >

### Description

A `<package>` is a unit of software distribution. It is also a configuration option in that users can choose whether or not a particular package is loaded into the configuration, and which version of that package should be loaded. It is also a component in that it can contain additional components and options in a hierarchy.

A `<package>` can have most of the properties and behaviour of a `<component>`, but with some limitations (see the Unavailable properties below)

The top-level XCDL script for a package should begin with a `<package>` object.

### Containers

*Packages* are inherently containers, so they include `<component>`, `<option>`, `<interface>`, `<toolchain>` objects that should go below this object in the configuration hierarchy.

### Optional properties

 -   `<activeIf>` - a list of expressions to be evaluated; if all are true, the active state of this package remains true
 -   `<category>` - provides additional grouping information, to allow a configuration tool to provide appropriate selections (board | synthetic | root | architecture | family)
 -   `<childrenGeneratedFile>` - the full path file name of the header where the children nodes will generate a definition (if missing, inherited from the parent node)
 -   `<defaultEnabled>` - a boolean expression that provides an initial value for the package enabled/disabled state
 -   `<defaultValue>` - an expression to be used as a default value for this package, when the user does not define it explicitly during the configuration process
 -   `<generatedDefinition>` - a valid C preprocessor identifier to be defined in the header file if the package is active and enabled
 -   `<generatedFile>` - the full path file name of the header where the package will generate a definition (if missing, inherited from the parent node)
 -   `<implements>` - a list of ids of the interfaces implemented by this package
 -   `<includeXcdl>` - a list of XCDL metadata files to be parsed and whose objects to be included as children of the current node
 -   `<parent>` - provides a method to break the default hierarchy and directly specify the id of the parent of this package
 -   `<requires>` - a list of ids of other objects to be enabled when this package is enabled
 -   `<sourceFile>` - a list of source files that should be built if this package is active and enabled

### Unavailable properties

 -   `<computed>` - the package's value cannot be computed
 -   `<configurable>true</configurable>` - packages can always be enabled/disabled by the user during the configuration process
 -   `<valueType>none</valueType>` - packages do not have an associated value (might be changed to return the package version, when implemented)
 -   `<valueFormat>` - if the header definition is generated, the value will always be (1)
 -   `<legalValues>` - no restrictions can apply to package values

### Example

    <package name="infra">

      <display>Infrastructure</display>
      <description>Common types and useful macros.
      Tracing and assertion facilities.
      Package startup options.</description>

      <generatedFile>os/infra/infra.h</generatedFile>
      <generatedDefinition>OS_PACKAGE_INFRA</generatedDefinition>
      <sourceFile>startup.cpp</sourceFile>
      <sourceFile>prestart.cpp</sourceFile>
      <sourceFile>pkgstart.cpp</sourceFile>
      <sourceFile>userstart.cpp</sourceFile>

    </package>

The `<repository>` object
---------------------------

### Purpose

Define a repository, a special package.

### Syntax

    <repository name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </repository>

### Description

The `<repository>` object is the root node of a component repository. A `<repository>` can have all the properties and behaviour of a `<package>`.

### Containers

`<repository>` are inherently containers, so they include `<package>`, `<component>`, `<option>` and `<interface>` objects that should go below this object in the configuration hierarchy.

### Optional properties

 -   `<activeIf>` - a list of expressions to be evaluated; if all are true, the active state of this repository remains true
 -   `<buildSubFolder>` - a subfolder below the build folder where the files related to this repository will be stored
 -   `<category>root</category>` - provides additional grouping information, to allow a configuration tool to provide appropriate selections
 -   `<childrenGeneratedFile>` - the full path file name of the header where the children nodes will generate a definition (if missing, inherited from the parent node)
 -   `<defaultEnabled>` - a boolean expression that provides an initial value for the repository enabled/disabled state
 -   `<defaultValue>` - an expression to be used as a default value for this repository, when the user does not define it explicitly during the configuration process
 -   `<generatedDefinition>` - a valid C preprocessor identifier to be defined in the header file if the repository is active and enabled
 -   `<generatedFile>` - the full path file name of the header where the repository will generate a definition (if missing, inherited from the parent node)
 -   `<implements>` - a list of ids of the interfaces implemented by this package
 -   `<includeXcdl>` - a list of XCDL metadata files to be parsed and whose objects to be included as children of the current node
 -   `<requires>` - a list of ids of other objects to be enabled when this package is enabled
 -   `<sourceFile>` - a list of source files that should be built if this package is active and enabled
 -   `<sourcesPaths>` - a list of paths where to search for the sources files

### Unavailable properties

 -   `<computed>` - the repository's value cannot be computed
 -   `<configurable>true</configurable>` - repository can always be enabled/disabled by the user during the configuration process
 -   `<legalValues>` - no restrictions can apply to repository values
 -   `<parent>` - root nodes have no parents
 -   `<valueType>none</valueType>` - repository do not have an associated value (might be changed to return the package version, when implemented)
 -   `<valueFormat>` - if the header definition is generated, the value will always be (1)

### Example

    <repository name="µOS++">

        <display>The µOS++ SE repository</display>
        <description>All µOS++ Second Edition components are below this node.</description>

        <!-- Mark this as the root of the component repository (informative) -->
        <category>root</category>

        <!-- The list of possible relative paths where the sources can be located,
        starting from package root folder.
        This value is inherited by all children. -->
        <sourcesPath>src</sourcePath>
        <sourcesPath>.</sourcePath>

        <!-- Each component tree will generate a subfolder below the build folder. -->
        <buildSubFolder>micro-os-plus</buildSubFolder>

        <!-- The default dynamically generated header file, where all definitions that
        call for inclusions must be created. -->
        <generatedFile>include/portable/core/include/XCDL_Build_Defines.h</generatedFile>

        <!-- The folders where to search for include files during build -->

        <!-- Each repository must contribute an include path to it's root. -->
        <buildIncludeFolder>$(REPO_DIR)</buildIncludeFolder>
        <!-- In addition, the folder where the dynamically generated header files
         are stored is also used as include folder. -->
        <buildIncludeFolder>$(BUILD_DIR)/include</buildIncludeFolder>

    </repository>

The `<interface>` object
--------------------------

### Purpose

Define an interface, a functionality that can be provided by a number of different implementations.

### Syntax

    <interface name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </interface>

### Description

An `<interface>` is a special type of computed `<option>` object. It provides an abstraction mechanism that can be used to simplify XCDL expressions. An `<interface>` can have most of the properties and behaviour of an `<object>`, but with some limitations (see the Unavailable properties below)

As an example, suppose that some package relies on the presence of code that implements the standard kernel scheduling interface. However the requirement is no more stringent than this, so the constraint can be satisfied by the mlqueue scheduler, the bitmap scheduler, or any additional schedulers that may get implemented in the future. A first attempt at expressing the dependency might be:

    <requires>isEnabled('kernel/schedMlqueue') || isEnabled('kernel/schedBitmap')</requires>

This constraint is limited, it may need to be changed if a new scheduler were to be added to the system. Interfaces provide a way of expressing more general relationships:

    <requires>implementationsOf('kernel/scheduler') == 1</requires>

The interface *kernel/scheduler* is implemented by both the mlqueue and bitmap schedulers, and may be implemented by future schedulers as well. The value of an interface is the number of implementers that are active and enabled, so in a typical configuration only one scheduler will be in use and the value of the interface will be 1. If all schedulers are disabled then the interface will have a value 0 and the `<requires>` constraint will not be satisfied.

Some component writers may prefer to use the first `<requires>` constraint on the grounds that the code will only have been tested with the mlqueue and bitmap schedulers and cannot be guaranteed to work with any new schedulers. Other component writers may take a more optimistic view and assume that their code will work with any scheduler until proven otherwise.

`<interface>` is defined a XML element that has one name attribute and a body. Within a single configuration, names must be unique. If a configuration contained two packages which defined the same entity, any references to that entity in a `<requires>` property or any other expression would be ambiguous. It is possible for a given name to be used by two different packages if those packages should never be loaded into a single configuration. For example, architectural HAL packages are allowed to reuse names because a single configuration cannot target two different architectures. For a recommended naming convention see the Section called Package Contents and Layout in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages).

A commonly used constraint on interface values takes the form:

    <requires>implementationsOf('kernel/scheduler') == 1</requires>

This constraint specifies that there can be only one scheduler in the system. In some circumstances it is possible for the configuration tools to detect this pattern and act accordingly, so for example enabling the bitmap scheduler would automatically disable the mlqueue scheduler.

### Containers

*Interfaces* are not containers, so they cannot hold other objects such as `<option>` or `<component>` objects.

### Optional properties

 -   `<activeIf>` - a list of expressions to be evaluated; if all are true, the active state of this interface remains true
 -   `<category>` - provides additional grouping information, to allow a configuration tool to provide appropriate selections (board | synthetic | root | architecture | family)
 -   `<defaultEnabled>` - a boolean expression that provides an initial value for the interface enabled/disabled state
 -   `<generatedDefinition>` - a valid C preprocessor identifier to be defined in the header file if the interface is active and enabled
 -   `<generatedFile>` - the full path file name of the header where the interface will generate a definition (if missing, inherited from the parent node)
 -   `<legalValues>` - interfaces always have a small numerical value; the legalValues can be used to apply additional constraints such as an upper limit
 -   `<parent>` - provides a method to break the default hierarchy and directly specify the id of the parent of this interface
 -   `<requires>` - a list of ids of other objects to be enabled when this interface is enabled
 -   `<sourceFile>` - a list of source files that should be built if this interface is active and enabled
 -   `<valueFormat>` - control how the interface's value will appear in the configuration header file

### Unavailable properties

 -   `<computed>` - the interface's value is always computed from the number of enable and active implementators
 -   `<configurable>` - interfaces are always enabled and this cannot be changed
 -   `<defaultValue>` - meaningless since the interface's value is always computed
 -   `<implements>` - interfaces cannot implemented other interfaces
 -   `<valueType>int</valueType>` - interfaces always have integer values

### Example

    <interface name="scheduler">
      <display>Number of schedulers in this configuration</display>

      <parent>kernel</parent>
      <requires>1 == implementationsOf('kernel/scheduler')</requires>
    </interface>

The `<toolchain>` object
--------------------------

### Purpose

TBD.

### Syntax

    <toolchain name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </toolchain>

### Description

TBD

### Containers

*Toolchains* are containers, so they can hold other `<toolchain>` objects. *Toolchains* are generally hierarchical, and are placed below a `<package>` object.

### Optional properties

-   compilerObjectsExtension
-   compilerDepsOptions
-   compilerOutputOptions
-   compilerInputOptions
-   compilerWarningOptions
-   compilerMiscOptions
-   compilerDebugOptions
-   compilerOptimisationOptions
-   compilerCpu
-   compilerPreprocessorOptions
-   linkerMiscOptions
-   programNamePrefix
-   programNameSuffix
-   makeObjectsVariable
-   children
-   includeXcdl
-   platformSystem
-   parent
-   category

### Tools

-   cc
-   cpp
-   ld
-   asm

### Example

TBD

The `<configuration>` object
------------------------------

### Purpose

TBD.

### Syntax

    <configuration name="...">

        <display>...</display>
        <description>...</description>

        ... other properties ...
        ... children objects ...

    </configuration>

### Description

TBD

### Containers

*Configurations* are containers, so they can hold other `<configuration>`. `<configuration>` are generally hierarchical, and they are placed below a `<component>` related to the source files where the main() artefact code is located.

### Optional properties

-   artifactFileName
-   buildConfigurationName
-   buildFolder
-   children
-   loadPackages
-   options
-   preprocessorSymbols
-   requires
-   toolchain

### Example

TBD

The `<activeIf>` property
---------------------------

### Purpose

Allow additional control over the active state of a configuration object.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <activeIf>condition 1</activeIf>
      <activeIf>condition 2</activeIf>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<activeIf>` property is a condition to be evaluated, usually to check hardware properties; if all these expressions are true, the active state of this object is true. Multiple instances of this property are allowed.

### Default value

If missing, no additional constraints are considered, the object is active.

### Description

Configuration options or other objects may be either active or inactive. Typically this is controlled by the object's location in the overall hierarchy. Consider the option OS_DEBUG_INFRA_DEBUG_PRECONDITIONS, which exists below the component OS_DEBUG_USE_ASSERT. If the whole component is disabled then all options it contains are inactive: there is no point in enabling preconditions unless there is generic assertion support; any requirements constraints associated with preconditions are irrelevant; any `<sourceFile>` property or other build-related property is ignored.

In some cases the hierarchy does not provide sufficient control over whether or not a particular object should be active. For example, the math library could have support for floating point exceptions which is only worthwhile if the hardware implements appropriate functionality, as specified by the architectural HAL. The relevant math library configuration options should remain below the OS_PACKAGE_LIBM package in the overall hierarchy, but should be inactive unless there is appropriate hardware support. In cases like this an `<activeIf>` property is appropriate.

Another common use of `<activeIf>` properties is to avoid excessive nesting in the configuration hierarchy. If some option B is only relevant if option A is enabled, it is possible to turn A into a component that contains B. However adding another level to the hierarchy for a component which will contain just one entry may be considered excessive. In such cases it is possible for B to have an `<activeIf>` dependency on A.

`<activeIf>` takes a list of goal expressions as argument and all of the conditions have to be satisfied for the object to be active. For details of goal expression syntax see see the Section called Goal Expressions in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages). In most cases the goal expressions will be very simple, often involving just one other object, but more complicated expressions can be used when appropriate.

The `<activeIf>` and `<requires>` properties have certain similarities, but they serve a different purpose. Suppose there are two options A and B, and option B relies on functionality provided by A. This could be expressed as either *B activeIf A* or as *B requires A*. The points to note are:

-   If *B activeIf A* is used and A is disabled or inactive, then configuration (graphical) tools will generally prevent any attempt at modifying B. For example the text for B could be greyed out, and the associated check button (if B is a boolean option) would be disabled. If the user needs the functionality provided by option B then it is necessary to go to option A first and manipulate it appropriately.
-   If *B requires A* is used and A is disabled or inactive, graphical tools will still allow B to be manipulated and enabled. This would result in a new conflict which may get resolved automatically or which may need user intervention.
-   If there are hardware dependencies then an `<activeIf>` condition is usually the preferred approach. There is no point in allowing the user to manipulate a configuration option if the corresponding functionality cannot possibly work on the currently selected hardware. Much the same argument applies to coarse-grained dependencies, for example if an option depends on the presence of a TCP/IP stack then an activeIf OS_PACKAGE_NET condition is appropriate: it may be possible to satisfy the condition, but it requires the fairly drastic step of loading another package; further more, if the user wanted a TCP/IP stack in the configuration then it would probably have been loaded already.
-   If option B exists to provide additional debugging information about the functionality provided by A then again an `<activeIf>` constraint is appropriate. There is no point in letting users enable extra debugging facilities for a feature that is not actually present.
-   The configuration system’s inference engine will cope equally well with `<activeIf>` and `<requires>` properties. Suppose there is a conflict because some third option depends on B. If *B activeIf A* then the inference engine will attempt to make A active and enabled, and then to enable B if necessary. If B requires A then the inference engine will attempt to enable B and resolve the resulting conflict by causing A to be both active and enabled. Although the inference occurs in a different order, in most cases the effect will be the same.

### Example

    <!-- Do not provide extra semaphore debugging if there are no semaphores -->
    <option name="binsem">

      <parent>kernel/instrument</parent>
      <activeIf>isEnabled('kernel/synch')</activeIf>
      <generatedDefinition>OS_DEBUG_KERNEL_INSTRUMENT_BINSEM</generatedDefinition>
      ...
    </option>

    <!-- Avoid another level in the configuration hierarchy -->
    <option name="relay">

      <parent>kernel/synch/mutex/priorityInheritance/simple</parent>
      <activeIf>isEnabled('kernel/synch/mutex/priorityInheritance/simple')</activeIf>
      <generatedDefinition>OS_PACKAGE_KERNEL_SYNCH_MUTEX_PRIORITY_INHERITANCE_SIMPLE_RELAY</generatedDefinition>
      ...
    </option>

    <!-- Functionality that is only relevant if another package is loaded -->
    <option name="uitron compatibility">

      <parent>start</parent>
      <generatedDefinition>OS_PACKAGE_START_UITRON_COMPATIBILITY</generatedDefinition>
      <activeIf>isLoaded('uitron')</activeIf>
      ...
    </option>

    <!-- Check that the hardware or HAL provide the appropriate functionality -->
    <option name="break support">

      <parent>hal/debug/gdb/breakSupport</parent>
      <generatedDefinition>OS_DEBUG_HAL_DEBUG_GDB_BREAK_SUPPORT</generatedDefinition>
      <activeIf>isEnabled('hal/debug/gdb/stubsBreak')</activeIf>
      ...
    </option>

The `<category>` property
---------------------------

### Purpose

Define additional grouping information, to allow a configuration tool to provide appropriate selections.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <category>string</category>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<category>` property is a string.

### Default value

If missing no category is assigned to the current object.

### Description

Configuration tools usually should be able to provide some choices to various selections, for example to choose from the hardware platform the build is intended for. For this to work, specific packages should be marked with additional metadata, recognised by the configuration tools.

Examples of such metadata are:

-   'board' - for hardware boards
-   'synthetic' - for synthetic platforms

Other metadata can be purely informative, like the kind of the object:

-   'root'
-   'architecture'
-   'family'

It is recommended to use this extra metadata for `<package>` objects.

### Example

TBD

The `<childrenGeneratedFile>` property
----------------------------------------

### Purpose

Specify the configuration header file that will be generated for the children of a given component.

### Syntax

    <component name="...">

      <display>...</display>
      <description>...</description>

      <childrenGeneratedFile>file name</childrenGeneratedFile>

      ... other properties ...
      ... children objects ...

    </component>

The value of the `<childrenGeneratedFile>` property is a string containing a file name.

### Default value

If missing, the definition from the parent node is used, first the `<childrenGeneratedFile>` then `<generatedFile>`.

### Description

When the configuration tools generate a build tree, one of the steps is to output each objects’s configuration data to a header file. Instead of defining a `<generatedFile>` for each individual _Option_ of a _Component_, it is recommended to define the file once, in the parent _Component_, and this definition will be used for all children nodes without a `<generatedFile>`.

The name specified in a `<childrenGeneratedFile>` property will always be interpreted as relative to the build folder.

### Example

TBD

The `<computed>` property
---------------------------

### Purpose

Used if the current option’s value is not user-modifiable, but is computed using a suitable XCDL expression.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <computed>expression</computed>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<computed>` property is an expression to be evaluated each time the object is refered.

### Default value

If missing, no computed value is used.

### Description

In some cases it is useful to have a configuration option whose value cannot be modified directly by the user. This can be achieved using a `<computed>` property, which takes an XCDL expression as argument (see the Section called Ordinary Expressions in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages) for a description of expression syntax). The configuration system evaluates the expression whenever needed to generate the header line or when referred from another expression. The result depends on the object’s `<valueType>`:

 -   `<valueType>none</valueType>` - objects with this type have no value, so the computed property is not applicable
 -   `<valueType>bool</valueType>` - the expression should evaluate to a boolean value
 -   `<valueType>number</valueType>` - the expression should evaluate to a number, integer or float
 -   `<valueType>string</valueType>` - the expression should evaluate to a string

There are a number of valid uses for calculated options, and there are also many cases where some other XCDL facility would be more appropriate.

Valid uses of computed objects include the following:

-   On some target hardware a particular feature may be user-configurable, while on other targets it is fixed. For example some processors can operate in either big-endian or little-endian mode, while other processors do not provide any choice. It is possible to have an option OS_BOOL_BIGENDIAN which is calculated in some architectural HAL packages but user-modifiable in others.

-   Computed objects can provide an alternative way for one package to affect the behaviour of another one. Suppose a package may provide two possible implementations, a preferred one involving self-modifying code and a slower alternative. If the system involves a ROM bootstrap then the slower alternative must be used, but it would be inappropriate to modify the startup option in every HAL to impose constraints on this package. Instead it is possible to have a calculated option whose value is `{ OS_HAL_STARTUP == "ROM" }`, and which has appropriate consequences. Arguably this is a spurious example, and it should be a user choice whether or not to use self-modifying code with a defaultValue based on OS_HAL_STARTUP, but that is for the component writer to decide.

-   Sometimes it should be possible to perform a particular test at compile-time, for example by using a C/C++ preprocessor `#if` construct. However the preprocessor has only limited functionality, for example it cannot perform string comparisons. XCDL expressions are more powerful.

-   Occasionally a particular sub-expression may occur multiple times in a XCDL script. If the sub-expression is sufficiently complex then it may be worthwhile to have a calculated option whose value is the sub-expression, and then reference that calculated option in the appropriate places.

Alternatives to using calculated options include the following:

-   XCDL *Interfaces* are a form of computed objects intended as an abstraction mechanism. For example, an interface can be used to express the concept of any scheduler, as opposed to a specific one such as the bitmap scheduler.

### Example

    <!-- A constant on some target hardware, perhaps user-modifiable on other targets. -->
    <option name="period">

      <parent>hal/rtc</parent>
      <display>Real-time clock period</display>
      <valueType>int</valueType>
      <computed>12500</computed>
    </option>

The `<configurable>` property
-------------------------------

### Purpose

Define whether the current object can be manually changed by the user during the configuration process.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <configurable>true | false | expression</configurable>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<configurable>` property is the *true/false* constant or an expression evaluating to a boolean value.

### Default value

If missing, the default is *true*, all objects are configurable.

### Description

Most of the objects can be individually configured using the configuration (graphical) tools, but some are automatically computed and the user shouldn't be allowed to change them.

Setting `<configurable>false</configurable>` will instruct the configuration tools to no longer allow the user to enable/disable the object. For graphical tools, the object will be greyed.

Objects marked as non-configurable can still be active or inactive, this property does not affect the functional behaviour during builds, but only the behaviour of the configuration tools.

### Example

TBD

The `<defaultEnable>` property
--------------------------------

### Purpose

Define whether the current object is initially enabled or not.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <defaultEnable>true | false | expression</defaultEnable>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<defaultEnable>` property is the *true/false* constant or an expression evaluating to a boolean value.

If the value is constant, it is evaluated when parsing the file, if the value is a string, it is evaluated in a separate step that process the entire configurations trees, before processing the requirements.

### Default value

If missing, the default is *true*, all objects are enabled.

### Description

The configuration trees are usually large, and not all objects are required in a specific configuration, so the need to individually enable/disable them.

This property controls the initial state of the object, since goal expressions can enable individual objects to satisfy requirements. Objects marked as enabled can still be active or inactive.

Disabling a component or package automatically disables all children objects.

### Example

TBD

The `<defaultValue>` property
-------------------------------

### Purpose

Provide a default value for this option using an XCDL expression.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <defaultValue>expression</defaultValue>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<defaultValue>` property is a string containing an expression to be evaluated each time the object is referred.

### Default value

If missing the default object value depends on the object state, active objects have the value 1/true and non active objects have the value 0/false.

### Description

The `<defaultValue>` property usually allows to define the default value for the object, in case no other value is set during configuration.

The arguments to the `<defaultValue>` property should be an XCDL expression, see the Section called Ordinary Expressions in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages) for the syntactic details. In many cases a simple constant value will suffice.

However it is also possible for an object’s default value to depend on other objects. For example the common HAL package provides some support functions that are needed by the kernel, but are unlikely to be useful if the kernel is not being used.

If the kernel is loaded then this HAL option is automatically enabled, although the user can still disable it explicitly should this prove necessary. If the kernel is not loaded then the option is disabled, although it can still be enabled by the user if desired. `<defaultValue>` expressions can be more complicated than this if appropriate, and provide a very powerful facility for component writers who want their code to “just do the right thing” in a wide variety of configurations.

An object can have at most one `<defaultValue>` property, and it is illegal to have both a `<computed>` and a `<defaultValue>` property in one body. If an object does not have either a `<defaultValue>` or a `<computed>` property and it does not have the `<valueType>` none then the configuration tools will assume a default value expression of 1/true if the object is active and 0/false otherwise.

On occasion it is useful to have a configuration object A which has both a `<requires>` constraint on some other object B and a `<defaultValue>` expression of B. If option B is not enabled then A will also be disabled by default and no conflict arises. If B is enabled then A also becomes enabled and again no conflict arises. If a user attempts to enable B but not A then there will be a conflict. Users should be able to deduce that the two options are closely interlinked and should not be manipulated independently except in very unusual circumstances.

### Example

    <option name="threadSupport">

      <parent>hal/debug/gdb</parent>
      <display>Include GDB multi-threading debug support</display>
      <description>This option enables some extra HAL code which is needed
      to support multi-threaded source level debugging.</description>

      <generatedDefinition>OS_DEBUG_HAL_DEBUG_GDB_THREAD_SUPPORT</generatedDefinition>
      <requires>isEnabled('kernel/debug/gdb/threadSupport')</requires>
      <defaultValue>valueOf('kernel/debug/gdb/threadSupport')</defaultValue>

    </option>

The `<generatedDefinition>` property
--------------------------------------

### Purpose

Define the name of the header variable to be generated.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <generatedDefinition>name</generatedDefinition>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<generatedDefinition>` property is a string containing a C/C++ preprocessor identifier.

### Default value

If missing, no header definition is generated for this object.

### Description

In order for a header definition to be generated, the full path of the include file where it will be added and the name of the preprocessor symbol is needed. The file name is provided by `<generatedFile>` and the preprocessor symbol by `<generatedDefinition>`.

The name must be a valid C/C++ preprocessor identifier: a sequence of upper or lower case letters, digits or underscores, starting with a non-digit character; identifiers beginning with an underscore should normally be avoided because they may clash with system packages or with identifiers reserved for use by the compiler.

Within a single configuration, names must be unique. If a configuration contained two packages which defined the same entity `OS_INTEGER_SOME_OPTION`, any references to that entity in a `<requires>` property or any other expression would be ambiguous. It is possible for a given name to be used by two different packages if those packages should never be loaded into a single configuration. For example, architectural HAL packages are allowed to reuse certain names because a single configuration cannot target two different architectures. For a recommended naming convention see the Section called Package Contents and Layout in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages).

For active and enabled objects, if the `<generatedDefinition>` property is defined, a line with the following structure will be generated in the file pointed by the `<generatedFile>` property:

     #define <name> <value>

The format of the value is defined by the `<valueFormat>` property.

For objects with type string, a second line should be generated, with the value concatenated to the name (if the resulting string can somehow be represented as a C/C++ preprocessor identifier):

     #define <name>_<value>

### Example

TBD

The `<generatedFile>` property
--------------------------------

### Purpose

Specify the configuration header file that will be generated for a given component, usually a package.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <generatedFile>file name</generatedFile>

      ... other properties ...
      ... children objects ...

    </option>

The value of the generatedFile property is a string containing a file name.

### Default value

If missing, the definition from the parent node is used, first the `<childrenGeneratedFile>`, then the `<generatedFile>`.

### Description

When the configuration tools generate a build tree, one of the steps is to output each objects’s configuration data to a header file. For example the kernel’s configuration data gets output to *include/xcdl/kernel.h*. This allows each package’s source code to `#include` the appropriate header file and adapt to the choices made by the user.

If multiple nodes use the same file, it is recommended to define the file only once, in the parent node, using `<childrenGeneratedFile>`.

The name specified in a `<generatedFile>` property will always be interpreted as relative to the build folder.

### Example

    <package name="arm">

      <display>ARM architecture</display>
      <parent>hal</parent>
      <hardware/>
      <generatedFile>os/hal/hal_arm.h</generatedFile>
       ...
    </package>

The `<implements>` property
-----------------------------

### Purpose

Inform the framework that one or more general interfaces are implemented.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <implements>interface 1</implements>
      <implements>interface 2</implements>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<implements>` property is a list of ids of interfaces the object implements. Multiple instances of this property are allowed.

### Default value

If missing it is assumed that the current object does not implement any interface.

### Description

The XCDL interface concept provides an abstraction mechanism that can be useful in many different circumstances. Essentially an interface is a computed option whose value is the number of active and enabled objects which implement that interface. For example the `interface('kernel/scheduler')` has a value corresponding to the number of schedulers in the system, typically just one.

The implements property takes a single argument, which should be a list of ids of the implemented interfaces (an object may implement multiple interfaces). These interface may be defined in the same package as the implementor or in some other package. In the latter case it may sometimes be appropriate for the implementor or the implementor’s package to have a `<requires>` property for the package containing the interface.

It is possible for an object to implement a given interface multiple times, but only distinct implementor ids are counted.

### Example

    <option name="schedMlqueue">

      <parent>kernel</parent>
      <display>Multi-level queue scheduler</display>

      <generatedDefinition>OS_PACKEGE_KERNEL_SCHED_MLQUEUE</generatedDefinition>
      <defaultEnable>true</defaultEnable>
      <implements>kernel/scheduler</implements>
      ...
    </option>

The `<includeXcdl>` property
------------------------------

### Purpose

Include additional configuration information from another XCDL definitions file.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <includeXcdl>file 1</includeXcdl>
      <includeXcdl>file 2</includeXcdl>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<includeXcdl>` property is a file name containing other XCDL definitions. Multiple properties are allowed.

### Default value

If missing, no additional XCDL files are parsed as children of the current object.

### Description

It is possible to define all the configuration options and sub-components for a given package in a single CDL script, either by nesting them in the appropriate command bodies, by extensive use of the parent property, or by some combination of these two. However for large packages this is inconvenient and it is better to split the raw configuration data over several different files. The `<includeXcdl>` property can be used to achieve this. It takes a list of filenames as argument. If the package follows the directory layout conventions then the configuration tools will look for the specified file in the meta sub-directory of the package, otherwise it will look for the file relative to the package’s top-level directory.

The `<includeXcdl>` property can only occur in the body of an `<component>` or `<package>` object.

### Example

    <component name="OS_PACKAGE_UITRON_TASKS">

      <display>Tasks</display>
      <description>uITRON Tasks are the basic blocks of multi-tasking
      in the uITRON world; they are threads or lightweight
      processes, sharing the address space and the CPU.
      They communicate using the primitives outlined above.
      Each has a stack, an entry point (a C or C++ function),
      and (where appropriate) a scheduling priority.<description>

      <valueType>none</valueType>
      <includeXcdl>tasks.xml</includeXcdl>
    </component>

The `<legalValues>` property
------------------------------

### Purpose

Impose constraints on the possible values for an option.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <legalValues>...</legalValues>
      <legalValues>...</legalValues>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<legalValues>` property is a string containing the restrictions. Multiple instances of this property are allowed.

### Default value

If missing, no value based constraints are imposed.

### Description

Options with the number or string valueType can have an arbitrary sequence of characters as their data. In nearly all cases some restrictions have to be imposed, for example the data should correspond to a number within a certain range, or it should be one of a small number of constants. The legalValues property can be used to impose such constraints. The arguments to the property should be an XCDL list expression, see the Section called List Expressions in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages) for the syntactic details. Common examples include:

    <legalValues>0 to 0x7fff</legalValues>
    <legalValues>9600, 19200, 38400</legalValues>
    <legalValues>"RAM", "ROM"</legalValues>

The `<legalValues>` property can only be used for objects with the number or string types, since it makes little sense to further constrain a boolean object.

### Example

    <option name=stdDefaultOffset">

      <parent>libc/time</parent>
      <display>Default Standard Time offset</display>
      <description>This option controls the offset from UTC in
                     seconds when in local Standard Time. This
                     value can be positive or negative. It
                     can also be set at run time using the
                     os_libc_time_setzoneoffsets() function.</description>

      <generatedDefinition>OS_INTEGER_LIBC_TIME_STD_DEFAULT_OFFSET</generatedDefinition>
      <valueType>int</valueType>
      <legalValues>-90000 to 90000</legalValues>
      <defaultValue>0</defaultValue>
    </option>

The `<parent>` property
-------------------------

### Purpose

Control the location of an option in the configuration hierarchy.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <parent>...</parent>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<parent>` property is a string containing the id of the parent object.

### Default value

If missing (the usual case), the surrounding object is considered the natural parent of this object. If none, the package object in the parent folder is used.

### Description

Configuration objects live in a hierarchy of packages and components. By default a given object’s position in the hierarchy is a simple consequence of its position within the XCDL scripts, based on its position in the folder's hierarchy. Packages are generally placed at the top-level of the configuration. Any `<component>` or `<option>` objects that are defined at the same level as the `<package>` object in a package’s top-level XCDL script are placed immediately below that package in the hierarchy (TBI). Any `<option>` or `<component>` objects that are defined in the body of a `<package>` or `<component>` command, or that are read in as a result of processing a component’s `<includeXcdl>` property, will be placed immediately below that `<package>` or `<component>` in the hierarchy.

In some circumstances it is useful to specify an alternative position in the hierarchy for a given object. For example it is often convenient to re-parent device driver packages below `OS_PACKAGE_IO` in the configuration hierarchy, thus reducing the number of packages at the top level of the hierarchy and making navigation easier. The parent property can be used to achieve this.

The parent property takes a single argument, which should be the id of a `<package>` or `<component>`.

Although the `<parent>` property affects an object's position in the overall hierarchy and hence whether or not that object is active, a re-parented object still belongs to the package that defines it (?!?!?!). By default any `#define`’s will be exported to that package’s configuration header file. Any `<sourceFile>` properties can only reference source files present in that package, and it is not directly possible to cause some file in another package to be built by re-parenting (???).

As a special case, if an empty string is specified for the parent then the object is placed at the top of the hierarchy, ahead of any packages which are not explicitly re-parented in this way. This facility is useful for configuration options such as global preferences and default compiler flags.

### Example

    <component name="trace">

      ...

      <component name="assert buffer">

        <display>Buffered tracing</display>
        <description>An output module which buffers output from tracing and
        assertion events. The stored messages are output when an
        assert fires, or OS_TRACE_PRINT() (defined in
        <os/infra/os_trac.h>) is called. Of course, there will
        only be stored messages if tracing per se (OS_DEBUG_USE_TRACING) is enabled above.</description>

        <generatedDefinition>OS_DEBUG_INFRA_DEBUG_TRACE_ASSERT_BUFFER</generatedDefinition>
        <defaultEnable>true</defaultEnable>
        <activeIf>isEnabled('use tracing')</activeIf>
        ...
      </component>

      <option name="size">

        <display>Trace buffer size</display>
        <description>The size of the trace buffer. This counts the number of
        trace records stored. When the buffer fills it either
        wraps, stops recording, or generates output.</description>

        <parent>trace/assert buffer</parent>
        <valueType>int</valueType>
        <defaultValue>32</defaultValue>
        <legalValues>5 to 65535</legalValues>
      </option>

    <component>

The `<requires>` property
---------------------------

### Purpose

List constraints that the configuration should enforce/satisfy if a given option is active and enabled.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <requires>expression 1</requires>
      <requires>expression 2</requires>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<requires>` property is a string containing expressions to be evaluated as boolean. Multiple instances of this property are allowed.

### Default value

If missing, no additional requirements will be enforced/checked.

### Description

Configuration objects are not independent. For example the C library can provide thread-safe implementations of certain functions, but only if the kernel is present, if the kernel provides multi-threading, and if the kernel options related to per-thread data are enabled. It is possible to express such constraints using `<requires>` properties.

The arguments to a `<requires>` property should constitute a list of goal expressions, as described in the Section called List Expressions in [XCDL packages]({{ site.baseurl }}/xcdl/guide/packages). Most goal expressions are relatively simple because the constraints being described are simple, but complicated expressions can be used when necessary. If the object is active and enabled then all these constraints should be satisfied, and any goal expressions which evaluate to 0/false will result in conflicts being raised. It is possible for users to ignore such conflicts and attempt to build the current configuration anyway, but there is no guarantee that anything will work. If an object is inactive or disabled then its `<requires>` constraints will be ignored.

The configuration system contains an inference engine which can resolve many types of conflicts automatically. For example, if option A is enabled and requires an option B that is currently disabled then the inference engine may attempt to resolve the conflict by enabling B. However this will not always be possible, for example there may be other constraints in the configuration which force B to be disabled at present, in which case user intervention is required.

### Example

    <component name="serialA">

      <parent>powerpc/cogent</parent>
      <display>Cogent PowerPC serial port A driver</display>

      <generatedDefinition>OS_PACKAGE_IO_SERIAL_POWERPC_COGENT_SERIAL_A</generatedDefinition>
      <valueType>none</valueType>
      <defaultEnable>false</defaultEnable>
      <requires>(isEnabled('kernel/interruptsChain') || !isEnabled('io/serial/powerpc/cogent/serialB'))</requires>
      ...
    </component>

The `<sourceFile>` property
-----------------------------

### Purpose

List the source files that should be built if this option is active and enabled.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <sourceFile>file 1</sourceFile>
      <sourceFile>file 2</sourceFile>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<sourceFile>` property is a file name containing source code to be included in the build. Multiple instances of this property are allowed.

### Default value

If missing, no source files will be added to the build.

### Description

The `<sourceFile>` property allows component developers to specify source files which should be compiled.

Details of the build process including such issues as compiler flags and the order in which things happen can be found in [The build process]({{ site.baseurl }}/xcdl/guide/build-process/).

The `<sourceFile>` properties can occur in any of `<option>`, `<component>`, `<package>` or `<interface>` objects. A `<sourceFile>` property has effect if and only if the object that contains it is active and enabled. Typically the body of a package will define any source files that need to be built irrespective of individual options, and each component, option, and interface will define source files that are more specific. The `<sourceFile>` property can list any number of source files. It is possible for a given source file to be specified in `<sourceFile>` properties for several different objects, in which case the source file will get built if any of these objects are active and enabled.

If the package follows the directory layout conventions then the configuration tools will search for the specified source files first in the src subdirectory of the package, then relative to the package directory itself.

Note: A shortcoming of the current specification of `<sourceFile>` properties is that there is no easy way to specify source files that should be built unless an option is enabled. It would sometimes be useful to be able to say: “if option A is enabled then compile file x.c, otherwise compile file y.c. There are two simple ways of achieving this:

-   Always compile y.c, typically by listing it in the body of the `<package>`, but use `#ifndef A` to produce an empty object file if option A is not enabled. This has the disadvantage that the file always gets compiled and hence for some configurations builds will take longer than necessary.

-   Use a computed option whose value is !A, and have a `<sourceFile>` y.c property in its body. This has the disadvantage of adding another calculated option to the configuration.

Note: Currently it is not possible to control the priority of a `<sourceFile>` property, in other words the order in which a file gets compiled relative to other build steps. This functionality might prove useful for complicated packages and should be added.

### Example

    <package name="infra">

      <display>Infrastructure</display>
      <description>Common types and useful macros.
            Tracing and assertion facilities.
            Package startup options.</description>

      <generatedDefinition>OS_PACKAGE_INFRA</generatedDefinition>
      <sourceFile>startup.cpp</sourceFile>
      <sourceFile>prestart.cpp</sourceFile>
      <sourceFile>pkgstart.cpp</sourceFile>
    </package>

The `<valueType>` property
----------------------------

### Purpose

Specify the type of the value associated with a configuration object.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <valueType>type</valueType>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<valueType>` property can be one of the following strings:

-   'enabled'
-   'none'
-   'bool'
-   'int'
-   'float'
-   'string'

### Default value

If missing, the default is *none*, except for interfaces (where the type is always a non-modifiable *int*) and for packages (where the type is *string*, and corresponds to the version of the package).

### Description

The state of an XCDL configuration option is a somewhat complicated concept. This state determines what happens when a build tree is generated: it controls what files get built and what `#define`’s end up in configuration header files. The state also controls the values used during expression evaluation. The key concepts are:

-   An object may or may not be loaded into the current configuration. However it is still possible for packages to reference objects which are not loaded, in a `<requires>` constraint or other expression. If an object is not loaded then it will have no direct effect on the build process, and 0/false will be used for expression evaluation.

-   Even if an object is loaded it may still be inactive. Usually this is controlled by the object's location in the configuration hierarchy. If an object's parent is active and enabled then the option will normally be active. If the parent is either inactive or disabled then the object will be inactive. For example, if kernel timeslicing is disabled then `isEnabled('kernel/sched/timeslice/ticks')` is false and must have no effect. The `<activeIf>` property can be used to specify additional constraints. If an object is inactive then it will have no direct effect on the build process, in other words it will not cause any files to get built or `#define`’s to be generated. For the purposes of expression evaluation an inactive object has `isActive('...') == false`, `isEnabled('...') == false` and `valueOf(...)` returns 0/false.

-   An object may be enabled or disabled. Most object are simple selections, for example a particular function may get inlined or it may involve a full procedure call. If an object is disabled then it has no direct effect on the build process, and for the purposes of expression evaluation `isEnabled('...') == false` and it has a `valueOf('...')` 0/false.

-   An object may also have additional data associated with it, for example a numerical value used to control the size of an array, or a string used to define a greeting message.

Most objects are simple selections and do not have any additional data associated to them. For certain objects it makes sense to have the ability to disable that object or to enable it and associate data as well. Finally, when constructing an option hierarchy it is occasionally useful to have objects which serve only as placeholders. The `<valueType>` property can be used to control all this. There are several possible values. It should be noted that the inactive state of an option takes priority over the enabled state: if an object is inactive then it is automatically not enabled, so no `#define`’s will be generated and any build-related properties such as `<sourceFile>` will be ignored.

Object with the `<configurable>` property set to *false* are not configurable (or not writeable), which means that the user cannot change neither the boolean part nor the data part in the configuration tools.

-   enabled - is intended mainly for completeness, and is rarely needed. Objects with this type do not have any additional data associated with them, so there is no way for users to modify the option. For the purposes of expression evaluation an active object with type *enabled* has the value *true*. For active objects, normal `#define` processing will take place, so typically a single `#define` will be generated using the object `<generatedDefinition>` and a value of (1). Similarly build-related properties such as `<sourceFile>` will take effect.

-   none - is intended primarily for placeholder components in the hierarchy, although it can be used for other purposes. Objects with this type do not have any additional data associated with them. If active, such options can be manually enabled/disabled by the user (using the graphical or command line tools). For the purposes of expression evaluation an enabled object with type *none* has the value *true*. For enabled objects, normal `#define` processing will take place, so typically a single `#define` will be generated using the object `<generatedDefinition>` and a value of (1). Similarly build-related properties such as `<sourceFile>` will take effect.

-   bool - have a boolean data associated with them which can be edited by the user. For the purposes of expression evaluation an enabled object with type *bool* has the value *true* or *false*. For enabled objects, normal `#define` processing will take place, so typically a single `#define` will be generated using the object `<generatedDefinition>` and a value of *true/false*. Similarly build-related properties such as `<sourceFile>` will take effect.

-   int - have an integer data associated with them. For the purposes of expression evaluation an enabled object with type int has the value of the integer number associated. For enabled objects, normal `#define` processing will take place, so typically a single `#define` will be generated using the object `<generatedDefinition>` and an integer value. Similarly build-related properties such as `<sourceFile>` will take effect.

-   float - have a float data associated with them. For the purposes of expression evaluation an enabled object with type float has the value of the float number associated. For enabled objects, normal `#define` processing will take place, so typically a single `#define` will be generated using the object `<generatedDefinition>` and a float value. Similarly build-related properties such as `<sourceFile>` will take effect.

-   string - have a string associated with them. For the purposes of expression evaluation an enabled object with type string has the value of the associated string. For enabled objects, normal `#define` processing will take place, and two `#define` lines will be generated using the object `<generatedDefinition>` and the string value (if the string is empty the symbol name will be extended with _EMPTY_ instead of the value). Similarly build-related properties such as `<sourceFile>` will take effect.

Regular objects (`<option>`, `<component>`, `<package>`) have the *none* type by default, but this can be changed as desired. Interfaces have the *int* type, and this cannot be changed, since the value of an interface is a count of the number of active and enabled interfaces. Packages have the *string* type, and this cannot be changed, since the value of a package is the version.

### Example

TBD

The `<valueFormat>` property
------------------------------

### Purpose

Control how an option’s value will appear in the configuration header file.

### Syntax

    <option name="...">

      <display>...</display>
      <description>...</description>

      <valueFormat>format</valueFormat>

      ... other properties ...
      ... children objects ...

    </option>

The value of the `<valueFormat>` property is a string containing a format specification.

### Default value

The defaults, according to `<valueType>`, are intended to surround the value by parenthesis or double quotes:

-   none - '(%s)'
-   bool - '(%s)'
-   int - '(%d)'
-   float - '(%f)'
-   string - '"%s"'

### Description

For active and enabled objects, the configuration tools will normally generate one or two `#define` lines in the package’s configuration header file. These take the following forms:

     #define <name> <value>
     #define <name>_<value>

The `<valueFormat>` property can be used to control exactly what appears as the value for the first of these `#define` lines.

The second `#define` will be generated only if is a valid C/C++ preprocessor symbol results, and is not affected by the `<valueFormat>` property.

The C formatting syntax is used.

### Example

To format a 32bit hex value, use:

    <valueFormat>(0x%08X)</valueFormat>

Credits
-------

The initial content of this page was based on *Chapter 5. CDL Language Specification* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
