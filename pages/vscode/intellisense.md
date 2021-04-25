---
title: IntelliSense (the project indexer)
permalink: /vscode/intellisense/

summary: "IntelliSense is a general term for various code editing features including: code completion, parameter info, quick info, and member lists."
comments: false

date: 2021-04-25 14:34:00 +0300

---

## The VS Code indexer

VS Code provides a very elaborate code indexer, called
[IntelliSense](https://code.visualstudio.com/docs/editor/intellisense).

It works by parsing the source files and creating an internal representation
of the code.

With C/C++, for this process to be accurate, it needs to know **exactly** how
the compiler is invoked for each source file, more specifically it
needs to know:

- the include folders
- the preprocessor definitions
- the compile options

Managed build systems, like the [Eclipse CDT](https://www.eclipse.org/cdt/),
having a good control over the
entire project settings, can pass accurate configuration to the internal
indexer.

When using external builders, which store the project settings in
custom text files not parseable by editors/IDEs (`make` files
being the common example), the users must provide the
indexer details again, which is not only redundant, but also difficult
to keep consistent.

To avoid this, more advanced external system build generators
(like CMake/meson) can automatically provide the indexer configuration
in a file called `compile_commands.json`.

## `compile_commands.json`

The `compile_commands.json` files are created by the system build generator
for each build, and list the full command lines required to compile
all project files.

For the simple Hello World project, with a single source file,
it may look like:

```json
[
{
  "directory": "/Users/ilg/tmp/hello/build/debug",
  "command": "/Library/Developer/CommandLineTools/usr/bin/c++ -DDEBUG -I/Users/ilg/tmp/hello/include -g -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -std=gnu++17 -o CMakeFiles/application.dir/Users/ilg/tmp/hello/src/hello-world.cpp.o -c /Users/ilg/tmp/hello/src/hello-world.cpp",
  "file": "/Users/ilg/tmp/hello/src/hello-world.cpp"
}
]
```

The VS Code C/C++ extension knows how to parse these files to extract the
list of include folders, preprocessor definitions
and everything else needed to configure IntelliSense properly.

There must be one such file in each build folder,
for each build configuration.

These files are created by the system build generator during the
setup/configure/prepare step, when the project configuration is
processed, and usually remain unchanged during subsequent builds.

If the project structure changes, for example when files are
added/removed/moved
around, this step must be repeated, not only to update the builder
specific files, but also to update the indexer configuration.

## `c_cpp_properties.json`

These files are used by the VS Code C/C++ extension to store the IntelliSense
configuration. There must be one such file in each workspace folder.

The exact location is `${workspaceFolder}/.vscode/c_cpp_properties.json`.

For simple projects, such a file looks like:

```json
{
  "configurations": [
    {
      "name": "Debug",
      "configurationProvider": "ms-vscode.cmake-tools",
      "compileCommands": "${workspaceFolder}/build/debug/compile_commands.json"
    },
    {
      "name": "Release",
      "configurationProvider": "ms-vscode.cmake-tools",
      "compileCommands": "${workspaceFolder}/build/release/compile_commands.json"
    }
  ],
  "version": 4
}
```

{% include note.html content="The current version of the xPack
extension uses the CMake configuration provider. Future
versions may switch to a different provider." %}

The xPack extension generates/updates these files to match the
existing build configurations defined in all projects.

## Use separate workspace folders for projects

Since VS Code distinguishes only between workspace folders, and does
not distinguish between multiple project folders,
it is recommended to avoid opening parent folders with multiple projects.

Instead, for multi-project cases, create a workspace and add all
projects to it (via menu **File** → **Add Folder to Workspace...**),
then save the entire
set of folders as a `<project>-code.workspace` file
(via menu **File** → **Save Workspace As...**); VS Code can later open
all projects at once.

The workspace file is a JSON with the paths to workspace folders. If all
those folders are children of the workspace, all paths are relative, and
the file is portable, which means it can be stored in repositories.

{% include note.html content="The xPack extensions does its best to cope with
multiple projects in a folder, but, for IntelliSense to work, it needs
to create a `.vscode/c_cpp_properties.json` file in the top
workspace folder. This file contains absolute paths and **should not** be
stored in repositories." %}
