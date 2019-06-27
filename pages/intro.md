---
permalink: /intro/
title: xPack 101

summary: A npm module with an extra xpack definition.

date: 2019-06-26 08:57:00 +0300
last_updated: 2019-06-27 19:02:00 +0300

---

## Where does the name come from?

The name, pronounced _**ɛks-pak**_, can be understood as _Universal Package_, 
or _Any Type Package_, and tries to suggest that, when compared with 
npm packages (which are basically about JavaScript), xPacks are more 
general, and not linked to a specific programming language. 

Initially the _x_ came from _eXtended_, so _eXtended Packages_ can 
be another choice.

## What exactly is an xPack?

The full definition is:

{% include callout.html content="An xPack is a folder which includes a 
`package.json` file, defining at least
the package `name`, the package `version`, and an `xpack` object, 
even empty." type="primary" %}

Given the direct inheritance from npm packages, a canonical 
definition might be:

{% include callout.html content="An xPack is a npm package with 
an additional `xpack` object defined in `package.json`." type="primary" %}

### Package formats

As for npm, a package is any of the following:

1. A folder containing a `package.json` file.
2. A gzipped tarball containing (1).
3. A URL that resolves to (2).
4. A `<name>@<version>` that is published on the registry with (3).
5. A `<name>@<tag>` that points to (4).
6. A `<name>` that has a `latest` tag satisfying (5).
7. A `git` url that, when cloned, results in (1).

## How to convert my project to an xPack?

Create a `package.json` file in the root folder of your project with at
least the following definitions:

```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "xpack": {}
}
```

The npm `package.json` has a few more fields, please read 
[Creating a package.json file](https://docs.npmjs.com/creating-a-package-json-file)
for details.

## Why would I convert my project to an xPack?

The two main reasons are:

- to automate dependencies management
- to automate path management for dependent tools

These are both simple and complicated things. To better understand 
them, please continue to read how binary and source xPacks work.

## How do binary xPacks work?

Let's assume that the 'awesome project' needs the `arm-none-eabi-gcc` 
toolchain to build,
and not any version but a specific one, like `8.2.1`; it also needs the
xPack Basic Builder, `xpbuild`.

```json
{
  "name": "my-awesome-xpack",
  "version": "1.0.0",
  "devDependencies": {
    "@xpack/xpbuild": "~1.2.3",
    "@xpack-dev-tools/arm-none-eabi-gcc": "~8.2.1"
  },
  "xpack": {}
}
```

Running `xpm install` in the project folder will first install the toolchain
in the central xPack storage (a folder in user's home`), then add a folder
`xpacks/.bin` and inside it create links (or `.cmd` stubs on Windows) to the
toolchain executables, like `xpacks/.bin/arm-none-eabi-gcc`.

Similarly for the builder, which is a Node.js CLI npm module, after 
installing the module, `npm` will
add a folder `node_modules/.bin` where a link to the `xpbuild` executable
will be created (or a `xpbuild.cmd` stub on Windows).

{% include note.html content="The `~` used in the version field is
a npm/semver convention that means either the given version,
or one with the same major/minor but a higher patch, if available." %}

When running actions like `npm run build`, the `PATH` is automatically
adjusted to `xpacks/.bin:node_modules/.bin:$PATH`, so the exact versions
of the tools required in the dependencies list will be preferred over any
existing tools with the same names that might be present in the `PATH`.

(Note: the package referred above are not yet available with 
these names, do not try to use them yet.)

## How do source xPacks work?

Even simpler. Let's assume that the 'awesome project' also needs the
µOS++ trace support, which is available as the source xPack
`@micro-os-plus/diag-trace`.

```json
{
  "name": "my-awesome-xpack",
  "version": "1.0.0",
  "dependencies": {
      "@micro-os-plus/diag-trace": "~1.0.6"
  },
  "devDependencies": {
    "@xpack/xpbuild": "~1.2.3",
    "@xpack-dev-tools/arm-none-eabi-gcc": "~8.2.1"
  },
  "xpack": {}
}
```

Running `xpm install` in the project folder will first install the
`@micro-os-plus/diag-trace` package, possibly with all other dependencies, 
recursively.

Then `xpm` will add links to all dependent packages in the `xpacks` folder, 
like `xpacks/micro-os-plus-diag-trace` (mind the linearised package name); 
now the project can refer to 
them as to any sub-folder local to the project.

