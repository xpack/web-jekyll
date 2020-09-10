---
title: How to install xpbuild
permalink: /xpbuild/install/

toc: false
comments: true
keywords:
  - xpbuild
  - xpack
  - install


date: 2019-07-04 16:49:00 +0300

---

{% include warning.html content="This page is a preview, the tool is not
yet available." %}

## Overview

`xpbuild` is a [Node.js](https://nodejs.org) CLI application available as the
npm package [`xpbuild`](https://www.npmjs.com/package/@xpack/xpbuild) from the
[`npmjs.com`](https://www.npmjs.com) public repository.

## Prerequisites

A recent [`node`](https://nodejs.org) (>=8.x), since the ECMAScript 6 class
syntax is used, and a recent [`npm`](https://docs.npmjs.com/cli/npm).

For details, please read (carefully!) the [Prerequisites]({{ site.baseurl }}/install/) page.

## `xpbuild` install

{% capture windows %}

On Windows, by default, global Node packages are installed in the
user home folder, in `%APPDATA%\npm`
(like `C:\Users\ilg\AppData\Roaming\npm`), and managing packages
does not require administrative rights.

```
C:\>npm install --global xpbuild@latest
```

The result is a pair of files in the `%APPDATA%\npm` folder:

```
C:\>dir "%APPDATA%"\npm\xpbuild*
 Volume in drive C has no label.
 Volume Serial Number is 28CE-1C06

 Directory of C:\Users\Liviu Ionescu\AppData\Roaming\npm

18/04/2018  10:40               319 xpbuild
18/04/2018  10:40               196 xpbuild.cmd
               2 File(s)            515 bytes
               0 Dir(s)  51,207,155,712 bytes free
```

If you followed the instructions in the
[Prerequisites]({{ site.baseurl }}/install/) page, you should
already have this path configured and the program should start normally:

```
C:\>xpbuild --version
0.5.0
```
{% endcapture %}

{% capture macos %}

On macOS, by default, global Node packages are installed in
`/usr/local`, and managing them requires administrative rights,
but if you followed the instructions in the
[Prerequisites]({{ site.baseurl }}/install/) page, you should
already have configured npm to use a location in the home folder.

With the environment properly set, the command to install `xpbuild` is:

```console
$ npm install --global xpbuild@latest
```

To test if xpbuild starts:

```console
$ which xpbuild
/Users/ilg/Library/npm/bin/xpbuild
$ xpbuild --version
0.5.0
```

{% endcapture %}

{% capture linux %}

On GNU/Linux, by default, global Node packages are installed in
`/usr/local`, and managing them requires administrative rights,
but if you followed the instructions in the
[Prerequisites]({{ site.baseurl }}/install/) page, you should
already have configured npm to use a location in the home folder.

With the environment properly set, the command to install `xpbuild` is:

```console
$ npm install --global xpbuild@latest
```

To test if `xpbuild` starts:

```console
$ which xpbuild
/home/ilg/opt/npm/bin/xpbuild
$ xpbuild --version
0.5.0
```

{% endcapture %}

{% include platform-tabs.html %}

## Uninstall

To remove xpbuild, the command is:

```console
$ npm uninstall --global xpbuild
```

## Miscellaneous

The official page explaining how to install `npm` in a custom
folder is [How to Prevent Permissions Errors](https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-two-change-npms-default-directory).

## `npx`

If, for any reason, you decide not to install xpbuild, you can still
benefit from it by using `npx`, as a trampoline to start `xpbuild`:

```console
$ npx xpbuild --version
0.4.3
```

However, for regular usage, this method is not efficient, since
`npx` will need to prepare the Node module
for each run, and this takes some time.


## User info

To get an initial glimpse on the program, ask for help:

```console
$ xpbuild --help
...
```
