---
title: XCDL templates preprocessor syntax proposal (outdated)
permalink: /xcdl/work/preprocessor/

comments: true

date: 2015-10-25 12:00:00 +0200

---

## Challenge

Define a template based preprocessing mechanism to be used to generate source files in a wizard (mainly C/C++).

## Requirements

* interfere as little as possible with the native file source language
* do not interfere with other tools, like Doxygen
* be as simple as possible to process
* syntax must be as standard as possible

## Embed metadata inside comments

The natural implementation for the first requirement is similar to that used by Doxygen, i.e. insert the preprocessing metadata as standard comments.

The direct consequence is that the template files are regular source files, they do not introduce a new syntax.

This has two major advantages:

* the template files can be edited with current editors, and do not interfere with syntax colouring;
* the template files can be reformatted with existing formatters.

## Inspiration

Although there are many other similar solutions, none that I know meets the above requirements.

### Jekyll

The [Jekyll](https://jekyllrb.com) static web generator uses the [Liquid](https://shopify.github.io/liquid/) metadata, which comes in two types: tags (for flow control) and object/filters (for inserting content).

```txt
{% raw  %}{% if user %}
  hello("{{ user.name }}!");
{% endif %}
  url="{{ url | append: ".html" }}";{% endraw %}
```

Embedding this metadata into C/C++ comments would look like this:

```txt
{% raw  %}//@XCDL {% if user %}
  hello("{{ user.name }}!");
//@XCDL {% endif %}
  url="{{ url | append: ".html" }}";{% endraw %}
```

The syntax remains relatively easy to read, but the Liquid tags still introduce a new language, that needs to be parsed and processed.

### Jinja2

The default syntax of [Jinja2](https://jinja.pocoo.org/docs/dev/) matches Django syntax in many ways, and it also very similar to the syntax of [Liquid](https://shopify.github.io/liquid/) metadata, so it will not be repeated here.

### ST CubeMX

CubeMX uses `.ftl` files with a complex script syntax, somehow inspired by xml; tags may come in pairs (`[if]`, `[/if]`), and substitutions are encoded like macros (`${argument.name}`).

```txt
[#ftl]
[#-- macro generateConfigModelCode --]

[#macro generateConfigModelCode configModel inst nTab index]
[#if configModel.methods??] [#-- if the pin configuration contains a list of LibMethods--]
    [#assign methodList = configModel.methods]
[#else]
    [#if configModel.methods??]
        [#assign methodList = configModel.libMethod]
    [/#if]
[/#if]
[#assign writeConfigComments=false]
[#if methodList?? ]
[#list methodList as method]
    [#if method.status=="OK"][#assign writeConfigComments=true][/#if]
[/#list]
[#if writeConfigComments]
[#if configModel.comments??] #t#t/**${configModel.comments?replace("#t","#t#t")} #n#t#t*/[/#if]
[/#if]
... ${argument.name} ...
```

The syntax controls the details of the expansion to the latest details, including generating tabs and new lines (`#t`, `#n`), so the template s are not really source files, and embedding the metadata as comments doesn't make much sense.

(The files are in the `db/templates` folder; on macOS this is located below `STM32CubeMX.app/Contents/Resources`).

### Infineon DAVE

In DAVE 4 templates are stored as `.tmpl` files and use full [Groovy](https://www.groovy-lang.org) scripts (which look very familiar to Java programmers).

```.java
package Model.Common;

out.print("""
/*******************************************************************************
 Copyright (c) 2014, Infineon Technologies AG                                 **
 All rights reserved.                                                         **
*******************************************************************************/

/*******************************************************************************
 * @brief This function initializes the Apps Init Functions.
 *
 * @param[in]  None
 *
 * @return  DAVE_STATUS_t <BR>
 *
 * <b>Reentrant: No </b><BR>
 *
 ******************************************************************************/

DAVE_STATUS_t DAVE_Init(void)
{
  DAVE_STATUS_t init_status;

  init_status = DAVE_STATUS_SUCCESS;

 """);

def appsList = daveEnv.project.getTopLevelApps();
def apps = [];
def appName
def instanceLabel

 for (def app : appsList ) {
    if(app.initProvider) {
      apps.add(app);
    }
 }
out.print("""

/** @Initialization of Apps Init Functions */

""");
 for (def app : apps ) {
   appName = app.getClass().getSimpleName()
   instanceLabel = app.getInstanceLabel()
out.print("""
  if (init_status == DAVE_STATUS_SUCCESS)
  {
    /**  Initialization of ${appName} App instance ${instanceLabel} */
    init_status = (DAVE_STATUS_t)${appName}_Init(&${instanceLabel});
  }
""");

}
out.print("""

  return init_status;
} /**  End of function DAVE_Init */
""");
```

The actual content is included with triple quote strings and substitutions are performed on the way, using the `${appName}` syntax.

By using a fully fledged script language, the template engine is very powerful.

However, embedding the C/C++ code as strings in Groovy is quite hard to read.

Templates can be found in `Infineon\D_LibraryStore_4.1\DeviceFeatures\pack\2.0.0\CE_Templates\TLE`

### Freescale Processor Expert

The late Processor Expert is probably the grand-dad of all component code-generating solutions. It was designed as the ultimate solution, and indeed it provides lots of features, but at the cost of a very high complexity. (for an overview, please read this [article](https://mcuoneclipse.com/2015/10/18/overview-processor-expert/)).

There are many XML file with lots of definitions.

The templates are `.drv` files, and the syntax looks like:

```txt
%-
%INTERFACE
%define! Settings Common\FAT_FileSystemSettings.Inc
%define! Abstract Common\FAT_FileSystemAbstract.Inc
%include Common\Header.h

#ifndef __%'ModuleName'_H
#define __%'ModuleName'_H

/* MODULE %ModuleName. */
/* Wrappers to FatFS types and constants */
#define %'ModuleName'%.FATFS            FATFS
#define %'ModuleName'%.DIR              DIR
#define %'ModuleName'%.FIL              FIL
#define %'ModuleName'%.FILINFO          FILINFO
#define %'ModuleName'%.FS_READONLY      _FS_READONLY
#define %'ModuleName'%.USE_LFN          _USE_LFN
#define %'ModuleName'%.MAX_LFN          _MAX_LFN
#define %'ModuleName'%.FS_REENTRANT     _FS_REENTRANT
#define %'ModuleName'%.MAX_SS           _MAX_SS
#define %'ModuleName'%.FS_RPATH         _FS_RPATH
#define %'ModuleName'%.FRESULT          FRESULT
#define %'ModuleName'%.DRESULT          DRESULT

%ifdef SharedModules
/* Include shared modules, which are used for whole project */
  %for var from IncludeSharedModules
#include "%'var'.h"
  %endfor
%endif
/* Include inherited beans */
%ifdef InhrSymbolList
  %for var from InhrSymbolList
#include "%@%var@ModuleName.h"
  %endfor
%endif
...
%-************************************************************************************************************
%-BW_METHOD_BEGIN RenameFile
%ifdef RenameFile
%define! ParsrcFileName
%define! PardstFileName
%define! Pario
%define! RetVal
%include Common\FAT_FileSystemRenameFile.Inc
/*!
 * \brief Renames a file
 * \param[in] srcFileName Source/existing file name
 * \param[in] dstFileName Destination/new file name
 * \param[in] io IO handler for output
 * \return Error code, ERR_OK for success.
 */
uint8_t %'ModuleName'%.%RenameFile(const uint8_t *srcFileName, const uint8_t *dstFileName, const %@Shell@'ModuleName'%.StdIOType *io)
{
  %'ModuleName'%.FRESULT fres;

  if (%'ModuleName'%.isWriteProtected((uint8_t*)"")) {
    %@Shell@'ModuleName'%.SendStr((unsigned char*)"disk is write protected!\r\n", io->stdErr);
    return ERR_FAILED;
  }
  fres = %'ModuleName'%.rename((char*)srcFileName, (char*)dstFileName);
  if(fres!=FR_OK) {
    FatFsFResultMsg((unsigned char*)"rename failed", fres, io);
    return ERR_FAILED;
  }
  return ERR_OK;
}

%endif %- RenameFile
%-BW_METHOD_END RenameFile
%-************************************************************************************************************
```

As far as I can tell, Processor Expert implements some kind of objects, named components, described by a template. This template can be instantiated for specific devices, like USART1, USART2, etc. People I respect consider that once the components are written, using them is quite convenient. The real challenge is to write these components, and this process can be done only with Processor Expert.

The syntax is quite complex, with commands similar to the C preprocessor (`%ifdef name`), but also with complex substitutions, like `%@Shell@'ModuleName'%.name(...)`.

The components can be found in the `C:\ProgramData\Processor Expert\PEXDRV_PE5_3` folder.

### AC6 System Workbench

The STM32 System Workbench currently does not use templates.

### Eclipse CDT template wizard

The Eclipse CDT template mechanism uses several _processes_, mainly to copy files and to change the project configuration (add symbol definitions, folders, etc).

Like most other things in Eclipse, the definitions reside in a very verbose xml file. Preprocessing is basic, only macro substitutions. Conditional execution is limited to one level, and the implementation is not very fortunate.

### Apache FreeMarker

[FreeMarker](https://freemarker.org) is another nice Apache Java project.

The templates are written in FTL (FreeMarket Template Language), which has an XML-like syntax, for example:

```xml
<#if animals.python.protected>
  Pythons are protected animals!
</#if>
```

Substitutions are encoded as `${...}` and the data comes from a data-model which is a collection of Java objects.

The language has a large number of tags, but it cannot compete with a true scripting language.

Although it probably can handle any format, most examples in the FreeMarker documentation refer to generating HTML or XML output, which might be an indication of its intended audience.

## Scripting proposal

It looks like using some kind of scripting language is inevitable. Defining a custom one, even inspired by an existing solution, is possible, but implementing it requires significant efforts.

With the omnipresent JavaScript, a simpler solution might be to implement the scripting part in JavaScript.

The DAVE idea to have the entire template as a script is interesting, but an even better option might be to generate this script.

So, the current proposal to be used by the XCDL preprocessor is to convert the entire template file into JavaScript, and to execute it.

## JavaScript implementations

Executing JavaScript inside another program might be a problem, but mature JavaScript implementations are now available for most platforms and languages, for example:

* [Go Otto](https://github.com/robertkrimen/otto)
* [Java Rhino](https://github.com/mozilla/rhino)

## Possible syntax solutions

Assuming the tags will be encoded as comments, the simplest solution would be to prefix the lines with a specific comment:

* `//@XCDL`

To simplify things even further, there should be no other non-spaces before this separator.

## JavaScript

With the choice for JavaScript and this simple syntax, the process to convert the templates to JavaScript is relatively straightforward: process line by line, identify `//@XCDL`, pass the tags as-is, and encode all other source line in an output call.

For example:

```txt
//@XCDL if (variable==="value") {
... C/C++ lines ...
//@XCDL }
```
translates into:

```.js
if (variable==="value") {
o("... C/C++ lines ...\n");
}
```

where `o(str)` is a function that outputs the string to the destination file.

Substitutions are can be identified and processed by the JavaScript, or can be optimised by generating a JavaScript code that converts the values to strings and outputs them.

```txt
#define VARIABLE ($(value+1))
```

can be translated to:

```txt
o("#define VARIABLE (");o(String(value+1));o(")\n");
```

## Examples

With these conventions, the first sample would look like:

```txt
//@XCDL if (defined('user')) {
hello ("$(user.name)!");
//@XCDL }
url = "$(url+'.html'))";
```

As expected, this is perfectly legal C syntax. The JavaScript code uses a function `defined()` that checks if an object is defined, and, if so, expands the `name` attribute of this object.

A more complex example would generate the `main.c`/`main.cpp` files in the STM32F4 template:

```.cpp
//
// This file is part of the GNU ARM Eclipse distribution.
// Copyright (c) 2016 Liviu Ionescu.
//
// ----------------------------------------------------------------------------
#include <stdio.h>
#include "diag/trace.h"
//@XCDL   if (content==="blinky") {

//@XCDL     if (fileExtension==="c") {
#include "timer.h"
#include "blink_led.h"
//@XCDL     } else if (fileExtension==="cpp") {
#include "timer.h"
#include "blink_led.h"
//@XCDL     } // fileExtension
//@XCDL   } // content

// ----------------------------------------------------------------------------
//
//@XCDL   if (content==="blinky") {
//@XCDL     if (syscalls==="none") {
// Standalone $(shortChipFamily) led blink sample (trace via $(trace)).
// In debug configurations, demonstrate how to print a greeting message
// on the trace device. In release configurations the message is
// simply discarded.
//
// Then demonstrates how to blink a led with 1 Hz, using a
// continuous loop and SysTick delays.
//@XCDL     } else if (syscalls==="retarget") {
// $(shortChipFamily) led blink sample (trace via $(trace)).
// In debug configurations, demonstrate how to print a greeting message
// on the trace device. In release configurations the message is
// simply discarded.
//
// To demonstrate POSIX retargetting, reroute the STDOUT and STDERR to the
// trace device and display messages on both of them.
//
// Then demonstrates how to blink a led with 1 Hz, using a
// continuous loop and SysTick delays.
//
// On DEBUG, the uptime in seconds is also displayed on the trace device.
//@XCDL     } else if (syscalls==="semihosting") {
// Semihosting $(shortChipFamily) led blink sample (trace via $(trace)).
// In debug configurations, demonstrate how to print a greeting message
// on the trace device. In release configurations the message is
// simply discarded.
//
// To demonstrate semihosting, display a message on the standard output
// and another message on the standard error.
//
// Then demonstrates how to blink a led with 1 Hz, using a
// continuous loop and SysTick delays.
//
// On DEBUG, the uptime in seconds is also displayed on the trace device.
//@XCDL     } // syscalls
//@XCDL   } else if (content==="empty") {
//@XCDL     if (syscalls==="none") {
// Standalone $(shortChipFamily) empty sample (trace via $(trace)).
//@XCDL     } else if (syscalls==="retarget") {
// $(shortChipFamily) empty sample (trace via $(trace)).
//@XCDL     } else if (syscalls==="semihosting") {
// Semihosting $(shortChipFamily) empty sample (trace via $(trace)).
//@XCDL     } // syscalls
//@XCDL   } // content
//
// Trace support is enabled by adding the TRACE macro definition.
// By default the trace messages are forwarded to the $(trace) output,
// but can be rerouted to any device or completely suppressed, by
// changing the definitions required in system/src/diag/trace_impl.c
// (currently OS_USE_TRACE_ITM, OS_USE_TRACE_SEMIHOSTING_DEBUG/_STDOUT).
//
//@XCDL   if "$(content==="blinky") {
// The external clock frequency is specified as a preprocessor definition
// passed to the compiler via a command line option (see the 'C/C++ General' ->
// 'Paths and Symbols' -> the 'Symbols' tab, if you want to change it).
// The value selected during project creation was HSE_VALUE=$(hseValue).
//
// Note: The default clock settings take the user defined HSE_VALUE and try
// to reach the maximum possible system clock. For the default 8 MHz input
// the result is guaranteed, but for other values it might not be possible,
// so please adjust the PLL settings in system/src/cmsis/system_$(CMSIS_name).c
//
//@XCDL     if (fileExtension==="c") {
// ----- Timing definitions ---------------------------------------------------
// Keep the LED on for 2/3 of a second.
#define BLINK_1S_TICKS  (TIMER_FREQUENCY_HZ)
#define BLINK_ON_TICKS  (TIMER_FREQUENCY_HZ * 2 / 3)
#define BLINK_OFF_TICKS (TIMER_FREQUENCY_HZ - BLINK_ON_TICKS)
//@XCDL     } else if (fileExtension==="cpp") { */
// Definitions visible only within this translation unit.
//@XCDL // This hack is required to avoid confusing the formatter.
$("namespace")
  {
  // ----- Timing definitions -----------------------------------------------

  // Keep the LED on for 2/3 of a second.
  constexpr timer::ticks_t BLINK_1S_TICKS = timer::FREQUENCY_HZ;
  constexpr timer::ticks_t BLINK_ON_TICKS = timer::FREQUENCY_HZ * 2 / 3;
  constexpr timer::ticks_t BLINK_OFF_TICKS = timer::FREQUENCY_HZ - BLINK_ON_TICKS;
  }
//@XCDL     } // fileExtension
//@XCDL   } // content

// ----- main() ---------------------------------------------------------------
// Sample pragmas to cope with warnings. Please note the related line at
// the end of this function, used to pop the compiler diagnostics status.
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wmissing-declarations"
#pragma GCC diagnostic ignored "-Wreturn-type"

int
main (int argc, char* argv[])
{
//@XCDL   if (content==="blinky") {
//@XCDL     if (syscalls==="retarget") {
  // By customising __initialize_args() it is possible to pass arguments,
  // for example when running tests with semihosting you can pass various
  // options to the test.
  // trace_dump_args(argc, argv);
//@XCDL     } else if (syscalls==="semihosting") {
  // Show the program parameters (passed via semihosting).
  // Output is via the semihosting output channel.
  trace_dump_args (argc, argv);
//@XCDL     } // syscalls

  // Send a greeting to the trace device (skipped on Release).
  trace_puts ("Hello ARM World!");

//@XCDL     if (syscalls==="retarget") {
  // The standard output and the standard error should be forwarded to
  // the trace device. For this to work, a redirection in _write.c is
  // required.
  // Send a message to the standard output.
  puts ("Standard output message.");

  // Send a message to the standard error.
  fprintf (stderr, "Standard error message.\n");
//@XCDL     } else if (syscalls==="semihosting") {
  // Send a message to the standard output.
  puts ("Standard output message.");

  // Send a message to the standard error.
  fprintf (stderr, "Standard error message.\n");
//@XCDL     } // syscalls

  // At this stage the system clock should have already been configured
  // at high speed.
  trace_printf ("System clock: %u Hz\n", SystemCoreClock);

//@XCDL     if (fileExtension==="c") {
  timer_start ();

  blink_led_init ();

  uint32_t seconds = 0;

  // Infinite loop
  for (int i = 0;; i++)
  {
    blink_led_on ();
    timer_sleep (i == 0 ? BLINK_1S_TICKS : BLINK_ON_TICKS);

    blink_led_off ();
    timer_sleep (BLINK_OFF_TICKS);

    ++seconds;
    // Count seconds on the trace device.
    trace_printf ("Second %u\n", seconds);
  }
//@XCDL     } else if (fileExtension==="cpp") {
  timer tm;
  tm.start ();

  blink_led led;

  // Perform all necessary initialisations for the LED.
  led.powerUp ();

  uint32_t seconds = 0;

  // Infinite loop
  for (int i = 0;; i++)
  {
    led.turnOn ();
    timer_sleep (i == 0 ? BLINK_1S_TICKS : BLINK_ON_TICKS);

    led.turnOff ();
    tm.sleep (BLINK_OFF_TICKS);

    ++seconds;
    // Count seconds on the trace device.
    trace::printf ("Second %u\n", seconds);
  }
//@XCDL     } // fileExtension
  // Infinite loop, never return.
//@XCDL   } else if (content==="empty") {
  // At this stage the system clock should have already been configured
  // at high speed.
  // Infinite loop
  while (1)
    {
      // Add your code here.
    }
//@XCDL   } // content */
}

#pragma GCC diagnostic pop

// ----------------------------------------------------------------------------
```
