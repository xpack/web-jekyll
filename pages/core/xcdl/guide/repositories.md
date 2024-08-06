---
title: XCDL component repositories (outdated)
permalink: /xcdl/guide/repositories/

comments: true

date: 2015-11-16 12:00:00 +0200

---

Generally a component repository is a collection of packages managed by the component framework.

## The local component repository

All development tools using XCDL packages include a local component repository. Similarly to the CMSIS Pack repository, this is a local folder structure where all installed packages are located. The component framework comes with an administration tool that allows new packages or new versions of a package to be installed, old packages to be removed, and so on. Each package has its own folder hierarchy within the component repository. Keeping several packages in a single folder is illegal.

To better accommodate the package separation for multi-vendor cases, the local folder hierarchy start with a folder with the vendor/originator name.

    Packages/
    ├── ARM
    ├── ilg
    ├── Keil
    ├── Nuvoton
    ├── lwIP
    └── wolfSSL

Below each vendor there are hierarchies of packages. Unrelated packages are all stored just below the vendor folder.

    Packages
    ├── ARM
    │   └── CMSIS
    ├── Keil
    │   ├── ARMCortex_DFP
    │   ├── MDK-Middleware
    │   ├── STM32F0xx_DFP
    │   ├── STM32F1xx_DFP
    │   ├── STM32F2xx_DFP
    │   ├── STM32F3xx_DFP
    │   ├── STM32F4xx_DFP
    │   ├── STM32L0xx_DFP
    │   ├── STM32L1xx_DFP
    │   ├── STM32NUCLEO_BSP
    │   ├── STM32W1xx_DFP
    │   └── V2M-MPS2_CMx_BSP
    ├── lwIP
    │   └── lwIP
    └── wolfSSL
        └── CyaSSL

### Read-only

Unless explicitly requested for development reasons, after unpacking, the administrative tools change the protection bits of the component files to read-only, to prevent inadvertent changes while using the components.

## Binary packages

To save space and to simplify management, each XCDL package may be packed into a ZIP archive and distributed via a web server, with each archive having its own URL.

The component framework should be able to download these archives, unpack them and add their content to the local component repository.

## Source packages

To simplify package development, the component framework should be able to add to the local component repository the original development folders, exactly as they are stored in their revision control systems (like Git).

### Read-write

Contrary to the other files in the local repository, these files installed via source packages are not set to read-only.

## Local versioning

Below each package directory there can be one or more subfolders, named after the package versions. This is a requirement of the component framework: it must be possible for users to install multiple versions of a package and select which one to use for any given application. This has a number of advantages to users: most importantly it allows a single component repository to be shared between multiple users and multiple projects, as required; also it facilitates experiments, for example it is relatively easy to try out the latest version of some package and see if it makes any difference. There is a potential disadvantage in terms of disk space. However since XCDL packages generally consist of source code intended for small embedded systems, and given typical modern disk sizes, keeping a number of different versions of a package installed will usually be acceptable. The administration tool can be used to remove versions that are no longer required.

    Packages/ilg
    └── xyzw
        ├── 3.20.3
        ├── 3.20.4
        ├── 4.1.0
        └── current

The version *current* is special. Typically it corresponds to the very latest version of the package when using Git like source packages, i.e. versions that were not frozen in a release.

All other subfolders of a package correspond to specific releases of that package. The component framework allows users to select the particular version of a package they want to use, but by default the most recent one will be used (by convention, this is the top-most version defined in the package XCDL metadata file).

## Remote repositories

Remote repositories are actually table of contents, listing all package available in a repository, with their full URLs and just enough information to build a brief outline of the package.

These files, currently named *content.xml* are managed by the administration tool. The various configuration tools read in these files when they start-up to obtain information about the various packages that have been installed.

For repositories of other types, like CMSIS Pack, which do not provide a *content.xml* file, the component framework provides a specific way of browsing the repository definition files and composing an equivalent *content.xml*, later cached locally.

An example of such file is presented below:

    <?xml version="1.0" encoding="UTF-8"?>

    <root version="1.1">
      <repository name="Keil">
        <description>Keil CMSIS packs repository</description>
        <properties>
          <property name="type">cmsis.repo</property>
          <property name="repo.url">http://www.keil.com/pack/index.idx</property>
          <property name="generator">GNU ARM Eclipse Plug-ins</property>
          <property name="date">20140620141046</property>
        </properties>
        <packages>
          <package name="CMSIS">
            <description>CMSIS (Cortex Microcontroller Software Interface Standard)</description>
            <versions>
              <version name="4.1.0">
                <description>- CMSIS-Driver   2.02  (incompatible update)</description>
                <properties>
                  <property name="type">cmsis.pack</property>
                  <property name="vendor.name">ARM</property>
                  <property name="pack.name">CMSIS</property>
                  <property name="version.name">4.1.0</property>
                  <property name="archive.url">http://www.keil.com/pack/ARM.CMSIS.4.1.0.pack</property>
                  <property name="archive.name">ARM.CMSIS.4.1.0.pack</property>
                  <property name="archive.size">62260982</property>
                  <property name="dest.folder">ARM/CMSIS/4.1.0</property>
                  <property name="pdsc.name">ARM.CMSIS.pdsc</property>
                  <property name="date">2014-06-12</property>
                </properties>
                <outline>
                  <devicefamily name="ARM Cortex M0">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  <devicefamily name="ARM Cortex M0 plus">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  <devicefamily name="ARM Cortex M3">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  <devicefamily name="ARM Cortex M4">
                    <property name="vendor.name">ARM</property>
                    <property name="vendor.id">82</property>
                  </devicefamily>
                  ...
                  <board name="uVision Simulator">
                    <description>uVision Simulator</description>
                    <property name="vendor.name">Keil</property>
                  </board>
                  <component name="CMSIS / CORE">
                    <description>CMSIS-CORE for Cortex-M, SC000, and SC300</description>
                  </component>
                  <component name="Device / Startup">
                    <description>System and Startup for Generic ARM Cortex-M0 device</description>
                  </component>
                  <component name="Device / Startup / C Startup">
                    <description>System and Startup for Generic ARM Cortex-M0 device</description>
                  </component>
                  ...
                  <example name="DSP_Lib Class Marks example (uVision Simulator)">
                    <description>DSP_Lib Class Marks example</description>
                    <property name="example.name">DSP_Lib Class Marks example</property>
                  </example>
                  <example name="DSP_Lib Convolution example (uVision Simulator)">
                    <description>DSP_Lib Convolution example</description>
                    <property name="example.name">DSP_Lib Convolution example</property>
                  </example>
                  ...
                </outline>
                <external>
                  <board name="uVision Simulator">
                    <property name="vendor.name">Keil</property>
                  </board>
                </external>
              </version>
              <version name="4.0.0">
                <description>- CMSIS-Driver   2.00  Preliminary (incompatible update) ...</description>
                <properties>
                  <property name="type">cmsis.pack</property>
                  <property name="vendor.name">ARM</property>
                  <property name="pack.name">CMSIS</property>
                  <property name="version.name">4.0.0</property>
                  <property name="archive.url">http://www.keil.com/pack/ARM.CMSIS.4.0.0.pack</property>
                  <property name="archive.name">ARM.CMSIS.4.0.0.pack</property>
                  <property name="archive.size">0</property>
                  <property name="dest.folder">ARM/CMSIS/4.0.0</property>
                  <property name="pdsc.name">ARM.CMSIS.pdsc</property>
                </properties>
              </version>
              <version name="3.20.4">
                <description>- CMSIS-RTOS 4.74 (see revision history for details) ...</description>
                <properties>
                  <property name="type">cmsis.pack</property>
                  <property name="vendor.name">ARM</property>
                  <property name="pack.name">CMSIS</property>
                  <property name="version.name">3.20.4</property>
                  <property name="archive.url">http://www.keil.com/pack/ARM.CMSIS.3.20.4.pack</property>
                  <property name="archive.name">ARM.CMSIS.3.20.4.pack</property>
                  <property name="archive.size">52095025</property>
                  <property name="dest.folder">ARM/CMSIS/3.20.4</property>
                  <property name="pdsc.name">ARM.CMSIS.pdsc</property>
                </properties>
              </version>
              ...
            </versions>
          </package>
        </packages>
      </repository>
    </root>

## Credits

The initial content of this page was based on *Chapter 2. Package Organization* of *The eCos Component Writer’s Guide*, by Bart Veer and John Dallaway, published in 2001.
