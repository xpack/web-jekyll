---
title: Quick Start - Hello World
permalink: /vscode/quick-start/

summary: Create a simple Hello World project.
comments: false

date: 2021-04-24 24:25:00 +0300

---

The easiest way to start with the **xPack C/C++ Managed Build** extension
is to create the classical _Hello World_ project.

## Create a Hello World C++ project

Projects can be created from scratch, but, to simplify things, the process
can be automated by using a project template, and this VS Code extension
already includes a command to create a project from a template:

- open the **Command Palette** (in the **View** menu, or with the
platform specific keyboard shortcut, Ctrl+Shift+P, or Cmd+Shift+P on macOS)
- type `xpack` in the input field, to filter the list of available commands
- select the **Quick Start a Hello World project (C++, CMake)**.

![Command Quick Start]({{ site.baseurl }}/assets/images/2021/command-quick-start.png)

The project creation requires an empty folder. The xPack extension asks
the user for the location of this folder.

In this example, a folder called `tmp/hello` in the user home folder is used.

![Create Hello folder]({{ site.baseurl }}/assets/images/2021/create-folder.png)

Once the folder is selected, the xPack extension invokes `xpm init` to
create a new project based on the
[@xpack/hello-world-template](https://github.com/xpack/hello-world-template-xpack)
which is a separate source xPack.

The command is executed in a separate shell, and the console output
looks like this:

![xpm init hello quick]({{ site.baseurl }}/assets/images/2021/xpm-init-quick.png)

The result is a simple project, with:

- a `src` folder with the source file `hello-world.cpp`
- an `include` folder with the header file `hello-world.h`,
- a `meta` folder with the additional metadata for performing the build
(in this case a CMake `CMakeLists.txt` configuration file).

The same result can be obtained by running the following commands in a
terminal:

```sh
mkdir ~/tmp/hello
cd ~/tmp/hello
xpm init --template @xpack/hello-world-template@latest
```

## xPack Actions

Once the project is created, the **xPack Actions** explorer should become
visible in the bottom left part of the screen:

![xPack Actions]({{ site.baseurl }}/assets/images/2021/xpack-actions.png)

{% include tip.html content="If this does not happen automatically,
at first use it might
be necessary to enable this explorer by running the command
**Explorer: Focus on xPack Actions View**, or by Right Clicking on any
of the explorers on the bottom left corner, and enabling
**xPack Actions**." %}

Once enabled, the explorer shows two build configurations,
**Debug** and **Release**.

The explorer also shows multiple actions, which are
associated with custom sequences of commands (shown as tooltips).
There are global
actions, and actions specific to each build configuration.
Actions can be executed by clicking the 
triangular icon (▷) at the right side
of the explorer line (described by tooltip as **Run Action**).

### Tooltips

As most of other graphical objects, the xPacks Actions explorer shows
additional information as tooltips, visible after hovering with the
mouse for a few moments on the visible items.

## Satisfy dependencies

The xPack project provides cross-platform binary tools which can be
automatically installed and used by xPack aware projects.

In this example, the generated project includes development dependencies
to specific versions of **CMake** and **ninja**.

To satisfy these dependencies, click the **Install** button (described by the
tooltip as **Run Command**) in the explorer:

![xpm install]({{ site.baseurl }}/assets/images/2021/xpm-install.png)

The same result can be obtained by running the following command in the
project folder:

```sh
xpm install
```

{% include note.html content="The use of xPack binary tools is optional,
for example
GNU/Linux users may very well continue to build their projects
in the traditional way, with tools installed via the system package
manager; however, macOS and Windows users might prefer a convenient
way to install additional binary tools." %}

{% include note.html content="The binary xPacks are strictly versioned,
and, for obtaining
reproducible builds, it is recommended to lock a project to a
specific set of tools, completely unrelated to the versions used by other
projects and not depending on the (possibly changing) versions available
in the system." %}

## Perform the build

With the binary tools available, the build can be invoked by selecting
the desired configuration in the explorer (**Debug** in this case),
and clicking the triangular icon (▷) at the right side
of the **build** line (described by tooltip as **Run Action**).

![xpm run build]({{ site.baseurl }}/assets/images/2021/xpm-run-build.png)

The result is a `build/debug` folder, where CMake performed the build.

The same result can be obtained by running the following command in the
project folder:

```sh
xpm run build --config Debug
```

## Execute the Hello World application

The resulting binary file is a regular ELF, which can be started as usual
in a terminal.

As a shortcut, the project includes an `execute` action, which
invokes the `hello-world` executable:

![xpm run execute]({{ site.baseurl }}/assets/images/2021/xpm-run-execute.png)

## IntelliSense

For build system generators which create the `compile_commands.json` file
(like CMake and meson), the xPack extension automatically
adds the paths to these files in the `.vscode/c_cpp_properties.json` file,
and the VS Code C/C++ extension automatically processes them.

![IntelliSense Debug]({{ site.baseurl }}/assets/images/2021/intellisense-debug.png)

As it can be seen, the editor renders dead code in gray (actually in a
set of lighter colours), which is a good sign that the project
was configured correctly.

## Switching build configurations

The **xPack C/C++ Managed Build** extension uses the
**Microsoft C/C++** extension,
which is able to handle multiple configurations.

To test this, also build the release binaries (by clicking the `build`
action in the **Release** section of the **xPacks Actions** explorer),
then click the Debug entry shown on the bottom Status Bar, which should
open a picker to select the desired configuration:

![Switching Configurations]({{ site.baseurl }}/assets/images/2021/switch-configs.png)

{% include tip.html content="The C/C++ configuration selector is enabled only
when editing C/C++ source files." %}

After selecting **Release**, the editor will automatically update the content,
and show the debug dead code as grey:

![IntelliSense Release]({{ site.baseurl }}/assets/images/2021/intellisense-release.png)

## Closing the workspace

When closing the workspace, either by closing VS Code, or via the **File** menu,
VS Code asks the user permission to save the workspace configuration
as a file:

![Close Workspace]({{ site.baseurl }}/assets/images/2021/close-workspace.png)

This is optional, and for independent projects, it is not of much help,
so it can be skipped (click the **Don't Save** button).

However, for complex projects which comprise multiple projects, it
might be useful to group all folders as an workspace, and open all
in the same VS Code instance.

## What next?

### Create an empty project

The recommended way to start a new project is to create a simple
Hello World project, which includes the two (Debug/Release)
build configurations, each with the usual build/clean actions,
and later extend the project with the actual application code.

However, for those who prefer to start from scratch, it is possible to
create an empty project, without any build configurations and actions,
and manually add them to any custom configuration.

![Command Empty]({{ site.baseurl }}/assets/images/2021/command-empty.png)

### Create a C version of the Hello World

The project template is configurable, and can be invoked in interractive
mode, which will ask the user for different choices, including
choosing between C and C++ projects.

To do this from withon the xPack extension, select the 
**xPack: Create a Hello World project** and check the console for
the questions.
