---
title: Visual Studio Code xPack C/C++ Managed Build Extension
permalink: /vscode/

summary: Use VS Code to manage and build C/C++ projects using the xPack tools.

comments: true

date: 2021-04-22 22:25:00 +0300

---

## Features

Manage typical **multi-configuration projects** (like _Debug/Release_), but
also complex, **multi-platform**, **multi-architecture**, **multi-toolchain**
projects, with an emphasis on **modern C/C++** and **embedded** applications.

This open source project is available on
[GitHub](https://github.com/xpack/vscode-xpack-extension-ts/)
and is part of he [xPack Project](https://github.com/xpack/).

In VS Code it can be directly installed from the
[Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack)

This extension is intended as a future replacement for the managed build
system available in
[Eclipse Embedded CDT](https://projects.eclipse.org/projects/iot.embed-cdt/).

## Requirements

- [Visual Studio Code](https://code.visualstudio.com)
- a recent [xpm](https://xpack.github.io/xpm/),
which is a portable [Node.js](https://nodejs.org/) command line application;
please follow the instructions in the
[install](https://xpack.github.io/install/) page.

## Quick Start

TL;DR: **View** → **Command Palette...** →
**xPack: Quick Start a Hello World project (C++, CMake)**
(but better read the web page).

The easiest way to start with the **VS Code xPack C/C++ Managed Build**
extension is to create the classical _Hello World_ project.

Follow the steps in the
[Quick Start]({{ site.baseurl }}/vscode/quick-start/) page.
In addition to being
a fully functional project, the result will also be a good
starting point for more complex projects.

## How it works

The xPack Managed Build is neutral to the build system, and basically
can invoke any tools, old and new, but favours modern tools
(like CMake and meson) which can
generate a `compile_commands.json` file, since this
greatly simplifies the project IntelliSense configuration.

## Disclaimer

{% include note.html content="The xPack Project does not
introduce a new package format, but
inherits from the simplicity of **npm**; it adds a few more definitions
to `package.json`, but otherwise it uses exactly the same project
format as **npm**; xPacks are actually npm packages, and can be
stored in usual Git repositories, or even published on
[npmjs.com](https://www.npmjs.com/search?q=xpack)
or compatible servers." %}

## Concepts (configurations & actions)

Compared to typical CMake/meson projects, which in most cases are reduced to
a single build folder, an xPack Managed Build project is
by design defined as

> a collection of named **build configurations**

each using a separate build folder, and

> each with its own set of named **actions**

defined as sequences of commands (stored in JSON as arrays of string).

![xPack Actions]({{ site.baseurl }}/assets/images/2021/xpack-actions.png)

To avoid redundant definitions between configurations,
the actions can use generic templates, with substitutions performed by the
[LiquidJS](https://liquidjs.com) template engine, based on
user defined string **properties**.

A typical example of a project with two build configurations,
using CMake, may look like:

{% raw %}

```json
{
  "name": "hello-world",
  "version": "0.1.0",
  "description": "A Hello World project",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [
    "xpack"
  ],
  "license": "MIT",
  "config": {},
  "dependencies": {},
  "devDependencies": {
    "@xpack-dev-tools/cmake": "3.19.2-2.1",
    "@xpack-dev-tools/ninja-build": "1.10.2-2.1"
  },
  "xpack": {
    "properties": {
      "buildFolderRelativePath": "build{% if os.platform == 'win32' %}\\{% else %}/{% endif %}{{ configuration.name | downcase }}",
      "commandPrepare": "cmake -S . -B {{ properties.buildFolderRelativePath }} -G Ninja -D CMAKE_BUILD_TYPE={{ properties.buildType }} -D CMAKE_EXPORT_COMPILE_COMMANDS=ON",
      "commandBuild": "cmake --build {{ properties.buildFolderRelativePath }}",
      "commandClean": "cmake --build {{ properties.buildFolderRelativePath }} --target clean",
      "commandExecuteHello": "{{ properties.buildFolderRelativePath }}{% if os.platform == 'win32' %}\\{% else %}/{% endif %}hello-world"
    },
    "actions": {
      "prepare-all": [
        "xpm run prepare --config Debug",
        "xpm run prepare --config Release"
      ],
      "build-all": [
        "xpm run build --config Debug",
        "xpm run build --config Release"
      ],
      "clean-all": [
        "xpm run clean --config Debug",
        "xpm run clean --config Release"
      ],
      "execute-all": [
        "xpm run execute --config Debug",
        "xpm run execute --config Release"
      ],
      "test": [
        "xpm run build-all",
        "xpm run execute-all"
      ]
    },
    "buildConfigurations": {
      "Debug": {
        "properties": {
          "buildType": "Debug"
        },
        "actions": {
          "prepare": "{{ properties.commandPrepare }}",
          "build": [
            "{{ properties.commandPrepare }}",
            "{{ properties.commandBuild }}"
          ],
          "clean": "{{ properties.commandClean }}",
          "execute": "{{ properties.commandExecuteHello }}"
        }
      },
      "Release": {
        "properties": {
          "buildType": "Release"
        },
        "actions": {
          "prepare": "{{ properties.commandPrepare }}",
          "build": [
            "{{ properties.commandPrepare }}",
            "{{ properties.commandBuild }}"
          ],
          "clean": "{{ properties.commandClean }}",
          "execute": "{{ properties.commandExecuteHello }}"
        }
      }
    }
  }
}
```

{% endraw %}

With the help of `xpm`, the complete cycle of prepare/build/execute
can be invoked via:

```bash
cd <project>
xpm install
xpm run test
```

Note: this example assumes the presence of a toolchain, like GCC or clang.

## Release Notes

The latest release is **v0.x**, which,
according to [semantic versioning](https://semver.org) rules,
means it is _in initial development_ phase.

The xPack extension is functional and can be used for beta-testing,
but anything MAY
change at any time and the public API SHOULD NOT be considered stable.

More details about each release can be found in the
[releases]({{ site.baseurl }}/vscode/releases/) pages.
