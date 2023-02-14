---
title: CMSIS Pack remarks and criticism (outdated)
permalink: /xcdl/criticism/cmsis/

comments: true

date: 2015-10-25 12:00:00 +0200

---

## The good parts

CMSIS Pack is an important step forward towards the standardisation of ARM Cortex-M system software, hardware description and documentation.

It provides silicon vendors with a great method to describe their chips in a structured way, from the full list of device names down to register level. These are all very useful information, since they are the basis for advanced tools, like project creation wizards (requiring the actual list of available devices and their associated header files and build details) and debugger register viewers (requiring detailed knowledge on the actual peripherals available in a chip variant and their full register definitions, down to bit level).

## The bad parts

The advantage of being a great tool for silicon vendors is probably its worse disadvantage, since (at least the current version, v1.3) CMSIS Pack seems intended mainly to silicon vendors, and not to general software distribution (like eCos CDL).

The second major disadvantage (partly understandable by its origins) is the deep bias towards µVision, a proprietary tool by Keil, which limits (and sometimes even voids) its usefulness in open environments, like GCC and Eclipse.

### Excessively complicated design

Apparently started as a µVision feature, and, as such, inheriting µVision oddities, the CMSIS Pack design evolved unevenly in different directions, and lacking the elegance of a consistent design, up to a point where it can even be considered over-engineered.

### Non-portable examples

Apart for µVision users, which do not use Eclipse anyway, with the current version of the CMSIS Packs, the many existing CMSIS examples are... useless, at large. :-(

The provided examples cannot be used to automatically create ready to build new C/C++ Eclipse projects, requiring many manual configuration changes, usually out of reach for beginners.

For this to be possible, the following (portable) details are required in the definition of an example:

-   the list of source files
-   the list of header files
-   the list of include holders
-   an optional list of preprocessor definitions

One possible solution would be to define the content of an example as one or more components, with full details regarding the files and include folders, and, instead of mandating the presence of a proprietary project definition, allow each tool to create the project required to build the example.

Hopefully future CMSIS Pack versions will be improved, to make the examples more portable and available for Eclipse/GCC based tools.

### Lack of GCC assembly files

At the date of writing this, only a very few packages were updated to include the GCC assembly startup files (.S), so most of the packages are not yet ready for inclusion in projects built with GCC.

### Lack of linker scripts

Not only that GCC support in the CMSIS Packs is scarce, but the linker scripts are completely missing.

### Simplistic repository index

The recommended method to access the packages from a web site is via a very simple index, plus the full package description. This method generates a lot of network traffic, and parsing the very large xml files, containing full device descriptions only to get a summary of the package is wasteful.

### Low configurability features

Compared to eCos, CMSIS Pack addresses only a very limited range of configurability options, generating a single, fixed name, header file (RTE_Config.h) generally intended to inform the source code only if a package is present or not, and does not go deeper, at component level.

The CMSIS alternative is a mechanism to allow a controlled edit of header files, using additional definitions embedded as comments.

Although functional, these additional definitions may interfere with embedded documentation, like Doxygen, further reducing the files readability.

### Fixed file naming schemes

CMSIS Pack requires the package files to follow a very rigid naming scheme: VENDOR.PACKNAME.VERSION.pack, and also requires the presence of a description file, named VENDOR.PACKNAME.pdsc to be present both inside the archive and on the server where the package is published.

### Fixed object hierarchies

Actually the CMSIS components are not really organised hierarchically, they are just tagged with various attributes, like class, group, subgroup, variant, version, and referring to them requires all relevant attributes.

Also packages have a flat structure, there are no methods to define hierarchies of packages.

### No package dependencies

Packages are currently fully independent, and there are no dependencies between them, so if a package requires another package, the second one also needs to be manually installed, there is no way to chain install all required packages.

### Windows only tools

The package validation tool, and all other provided tools are non portable, and run only on Windows.

### No special support for tests

Although tests might be considered a special genre of examples, building and running tests usually requires more details to be configured.

eCos CDL encourages to define tests for each package, and provides an automated mechanism to build and run all available tests at once.

PDSC schema oddities
--------------------

### Non-POSIX paths

Although the specs allow the use of standard POSIX paths (and, as far as I was told, MDK accepts them), all Keil packages, and all Keil documentation pages, do not miss the opportunity to show their Microsoft-ish origin, and represent all paths using the Windows back-slash separator:

```xml
<compile header="Device\Include\stm32f4xx.h"  define="STM32F40_41xxx"/>
```

Perhaps a more visually pleasant solution would have been to use the standard POSIX slash separator:

```xml
<compile header="Device/Include/stm32f4xx.h"  define="STM32F40_41xxx"/>
```

### `<books>`

Here is an unfortunate example from the STM32F4-Discovery board:

```xml
<book category="overview"  name="https://www.st.com/web/catalog/tools/FM116/SC959/SS1532/LN1199/PF252419" title="STM32F4-Discovery Web Page"/>
<book category="setup"     name="Documents\DM00037368.pdf" title="Getting Started"/>
<book category="schematic" name="Documents\stm32f4discovery_sch.zip" title="Schematics"/>
<book category="manual"    name="Documents\DM00039084.pdf" title="User Manual"/>
<book category="other"     name="Documents\stm32f4discovery_gerber.zip" title="Gerber Files"/>
```

First, none of the above is actually a book, all are various documentation files (web page, manuals, schematics, etc), so the name `<books>` is poorly chosen.

Second, the **name** attribute refers to anything else but the document name, which is eventually defined as **title**.

And third, the document location makes no difference between local and remote documents, requiring the inspection of the attribute value to better identify the document.

Perhaps a more appropriate definitions would have been:

```xml
<document category="overview"  title="STM32F4-Discovery Web Page" url="https://www.st.com/web/catalog/tools/FM116/SC959/SS1532/LN1199/PF252419"/>
<document category="setup"     title="Getting Started" file="Documents/DM00037368.pdf"/>
<document category="schematic" title="Schematics" file="Documents/stm32f4discovery_sch.zip"/>
<document category="manual"    title="User Manual" file="Documents/DM00039084.pdf"/>
<document category="other"     title="Gerber Files" file="Documents/stm32f4discovery_gerber.zip"/>
```

### `<algorithm>`

The **name** attribute does not define any name, but a special .FLM file:

```xml
<algorithm  name="Flash\STM32F4xx_1024.FLM" start="0x08000000" size="0x100000" default="1"/>
```

To be consistent with <debug>:

```xml
<debug      svd="SVD\STM32F41x.svd"/>
```

perhaps a **flm** attribute would have been more appropriate, or at least a generic **file** attribute.

```xml
<algorithm  flm="Flash\STM32F4xx_1024.FLM" start="0x08000000" size="0x100000" default="1"/>
```
