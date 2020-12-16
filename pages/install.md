---
title: How to install the xPack tools
permalink: /install/

toc: false
comments: true
keywords:
  - npm
  - xpack
  - install

node_version: 12.14.0
npm_version: 6.14.7

date: 2017-10-09 14:14:00 +0300

---

## Overview

All Core Tools are [Node.js](https://nodejs.org) CLI application
available from the
[npmjs.com](https://www.npmjs.com) public repository and are installed
via **npm** which uses Node.

## Prerequisites

A recent [Node.js](https://nodejs.org) (>=**10.x**), since the ECMAScript 6 class
syntax is used, and some dependencies may also require new features.

```console
$ node --version
v{{ page.node_version }}
```

If this is your first encounter with **npm**, you need to install the
[Node.js](https://nodejs.org) JavaScript run-time. The process is
straightforward and does not pollute the system locations significantly;
there are two Node versions, **LTS** (**Long Term Service**) and
**Current**; generally it is safer to use LTS, especially on Windows.

![The Node Download page]({{ site.baseurl }}/assets/images/2019/nodejs-org.png)

The general procedure is to download the package suitable for your
platform and install it as usual.
The result is a binary program named `node` (that can be used to execute
JavaScript code from the terminal), and a link named `npm`, pointing to
the `npm-cli.js` script, which is part of the Node module that implements
the npm functionality (on Windows instead of soft links,
`.cmd` stubs are used).

{% include tip.html content="The usual method is to install Node with
administrative rights;
however, the prefered method is to install it
in a custom location in the home folder, using a version
manager or by directly unpacking the archive distributions.
Regardless how and where it is installed, the `node`
executable must be in the curent path." %}

{% capture version_manager %}
## `nvm` install (node version manager)

Node.js can be installed manually, but for a greater flexibility, on POSIX
platforms
it is possible to automate this process by using nvm,
which not only simplifies the install procedure, but also allows advanced
users to install multiple versions of Node.js in parallel.
For details, see the
[Using a Version Manager to install Node.js and npm](https://docs.npmjs.com/getting-started/installing-node#using-a-version-manager-to-install-nodejs-and-npm)
page.
{% endcapture %}

{% capture manual_install %}
## Manual install
{% endcapture %}

{% capture node_install %}
### `node` install
{% endcapture %}

{% capture npm_update %}
## `npm` update
{% endcapture %}

{% capture tl_dr %}

## TL;DR

If you know what you're doing, copy paste the following into a terminal:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
exit
```

and in new terminal:

```
nvm install --lts node
nvm use node
node --version
nvm install-latest-npm
npm --version
npm install --global xpm@latest
```

{% endcapture %}
{% capture windows %}

{{ manual_install }}

{{ node_install }}

Download the **Windows Installer (.msi)** from the Node.js
[download](https://nodejs.org/en/download/) page and install it as usual,
with administrative rights.

{% include tip.html content="If you are using a 64-bit machine, download the `node-v*-x64.msi` file." %}

The result is a folder like `C:\Program Files\nodejs`, added to the
system path since it includes the `node.exe` binary.

```
C:\>where node.exe
C:\Program Files\nodejs\node.exe
C:\>node --version
v{{ page.node_version }}
```

{{ npm_update }}

A version of **npm**, usually a bit older, comes packed with Node.

```
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
6.4.1
```

It is recommended to update it to the latest version:

```
C:\>npm install --global npm@latest
C:\Users\ilg\AppData\Roaming\npm\npm -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npm-cli.js
C:\Users\ilg\AppData\Roaming\npm\npx -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npx-cli.js
+ npm@{{ page.npm_version }}
added 435 packages from 816 contributors in 72.64s
```

Surprisingly, checking the version usually shows the old version:

```
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
6.4.1
```

This is because on Windows, by default, global node packages are
installed in the
user home folder, in `%APPDATA%\npm`
(like `C:\Users\ilg\AppData\Roaming\npm`);
and this path **is not** in the default environment.

```
C:\>echo %Path%
```

It must be added manually in front of the current path:

```
C:\>set Path=%APPDATA%\npm;%Path%
```

To make this setting persistent, also issue the following:

```
C:\>setx Path "%APPDATA%\npm;%Path%"
```

{% include note.html content="Please note the syntax differences, no equal
sign and double quotes, specific to `setx` but harmful to `set`." %}

{% include note.html content="These commands are valid when using the
`cmd.exe` terminal; for PowerShell or other terminals, please adjust
the syntax to match their specifics." %}

After this, the new version of the program should be visible:

```
C:\>npm --version
{{ page.npm_version }}
```

## Git

Although not mandatory for using the xPack tools alone, on Windows
it is recommended to
also install the [Git for Windows](https://git-scm.com/download/win) package.

The xPack Core Tools can run either in the Windows `cmd.exe` terminal,
or in the Git shell terminal.

{% endcapture %}

{% capture macos %}

{{ tl_dr }}

{{ version_manager }}

In short, [nvm](https://github.com/nvm-sh/nvm) changes the install
location to `~/.nvm` and allows to install multiple instances of node
in the `~/.nvm/versions/node` folder.

If you have a previous version of npm installed with a local prefix,
remove it:

```console
$ sudo rm -rf /usr/local/lib/node-modules /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npm
$ rm -rf ~/Library/npm ~/opt/npm
$ npm config delete prefix
```

Also remove `${HOME}/Library/npm/bin` or `${HOME}/opt/npm/bin` from the PATH.

When everything is clean, run the install script:

```console
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```

This will install the version manager in `~/.nvm`, and add a few lines to
the shell profile, for example to `.bash_profile` on older versions.

{% include warning.html content="Please note that macOS Catalina no
longer uses bash, and the current npm install script does not
support zsh yet, so the two lines must be manually added to `.zprofile." %}

To install the latest node, after updating the shell profile, open a new
terminal (to make use of the new environment variables) and issue the
following:

```console
$ nvm install --lts node
Downloading and installing node v{{ page.node_version }}...
Downloading https://nodejs.org/dist/v12.13.0/node-v12.13.0-darwin-x64.tar.gz...
######################################################################## 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Creating default alias: default -> lts/* (-> v12.13.0)

$ nvm ls
->     v12.13.0
         system
default -> lts/* (-> v12.13.0)
node -> stable (-> v12.13.0) (default)
stable -> 12.13 (-> v12.13.0) (default)
iojs -> N/A (default)
unstable -> N/A (default)
lts/* -> lts/erbium (-> v12.13.0)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.16.2 (-> N/A)
lts/dubnium -> v10.17.0 (-> N/A)
lts/erbium -> v12.13.0

$ nvm use node
Now using node v12.13.0 (npm v6.12.1)

$ node --version
v12.13.0

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!
/Users/ilg/.nvm/versions/node/v12.13.0/bin/npm -> /Users/ilg/.nvm/versions/node/v12.13.0/lib/node_modules/npm/bin/npm-cli.js
/Users/ilg/.nvm/versions/node/v12.13.0/bin/npx -> /Users/ilg/.nvm/versions/node/v12.13.0/lib/node_modules/npm/bin/npx-cli.js
+ npm@6.13.0
added 2 packages from 2 contributors, removed 2 packages and updated 15 packages in 3.293s
* npm upgraded to: v6.13.0

$ which npm
/Users/ilg/.nvm/versions/node/v12.13.0/bin/npm
```

{% include note.html content="Please note that this will install the latest
**LTS** version; to install the very latest **Current** version, remove
the `--lts` option." %}

To explicitly install a previous version and to switch to it:

```console
$ nvm install 10
Downloading and installing node v10.17.0...
Downloading https://nodejs.org/dist/v10.17.0/node-v10.17.0-darwin-x64.tar.gz...
######################################################################## 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v10.17.0 (npm v6.11.3)

$ nvm ls
nvm ls
->     v10.17.0
       v12.13.0
         system
default -> lts/* (-> v12.13.0)
node -> stable (-> v12.13.0) (default)
stable -> 12.13 (-> v12.13.0) (default)
iojs -> N/A (default)
unstable -> N/A (default)
lts/* -> lts/erbium (-> v12.13.0)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.16.2 (-> N/A)
lts/dubnium -> v10.17.0
lts/erbium -> v12.13.0

$ nvm use 10
Now using node v10.17.0 (npm v6.11.3)

$ node --version
v10.17.0

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!
/Users/ilg/.nvm/versions/node/v10.17.0/bin/npm -> /Users/ilg/.nvm/versions/node/v10.17.0/lib/node_modules/npm/bin/npm-cli.js
/Users/ilg/.nvm/versions/node/v10.17.0/bin/npx -> /Users/ilg/.nvm/versions/node/v10.17.0/lib/node_modules/npm/bin/npx-cli.js
+ npm@6.13.0
added 3 packages from 2 contributors, removed 3 packages and updated 20 packages in 3.081s
* npm upgraded to: v6.13.0

$ which npm
/Users/ilg/.nvm/versions/node/v10.17.0/bin/npm
```

At any time, to switch between any of the installed versions,
use `nvm use <version>`.

{% endcapture %}

{% capture linux %}

{{ tl_dr }}

{% include note.html content="The official Node.js distribution no
longer provides Intel 32-bit images. The version manager is still able
to install node, by compiling it from sources, but the process takes
quite a while." %}

{% include note.html content="Arm binaries are supported, currently
in both 32/64-bit variants." %}

{{ version_manager }}

In short, [nvm](https://github.com/nvm-sh/nvm) changes the install
location to `C:\Users\<user>\AppData\Roaming\npm` and allows to install
multiple instances of node
in the `~/.nvm/versions/node` folder.

If you have a previous version of npm installed with a local prefix,
remove it:

```console
$ sudo rm -rf /usr/local/lib/nodejs
$ rm -rf ~/opt/npm
$ npm config delete prefix
```

Also remove `${HOME}/opt/npm/bin` from the PATH.

When everything is clean, run the install script:

```console
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```

This will install the version manager in `~/.nvm`, and add a few lines to
the shell profile, for example to `.bash_profile` on most
distributions.

To install the latest node, after updating the shell profile, open a new
terminal (to make use of the new environment variables) and issue the
following:

```console
$ nvm install --lts node
Downloading and installing node v12.13.0...
Downloading https://nodejs.org/dist/v12.13.0/node-v12.13.0-linux-x64.tar.xz...
####################################################################################################################### 100.0%
Computing checksum with sha256sum
Checksums matched!
Creating default alias: default -> lts/* (-> v12.13.0)

$ nvm ls
->     v12.13.0
         system
default -> lts/* (-> v12.13.0)
node -> stable (-> v12.13.0) (default)
stable -> 12.13 (-> v12.13.0) (default)
iojs -> N/A (default)
unstable -> N/A (default)
lts/* -> lts/erbium (-> v12.13.0)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.16.2 (-> N/A)
lts/dubnium -> v10.17.0 (-> N/A)
lts/erbium -> v12.13.0

$ nvm use node
Now using node v12.13.0 (npm v6.12.0)

$ node --version
v12.13.0

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!
/home/ilg/.nvm/versions/node/v12.13.0/bin/npm -> /home/ilg/.nvm/versions/node/v12.13.0/lib/node_modules/npm/bin/npm-cli.js
/home/ilg/.nvm/versions/node/v12.13.0/bin/npx -> /home/ilg/.nvm/versions/node/v12.13.0/lib/node_modules/npm/bin/npx-cli.js
+ npm@6.13.0
added 2 packages from 2 contributors, removed 2 packages and updated 15 packages in 8.68s
* npm upgraded to: v6.13.0

$ which npm
/home/ilg/.nvm/versions/node/v12.13.0/bin/npm
```

{% include note.html content="Please note that this will install the latest
**LTS** version; to install the very latest **Current** version, remove
the `--lts` option." %}

To explicitly install a previous version and to switch to it:

```console
$ nvm install 10
Downloading https://nodejs.org/dist/v10.17.0/node-v10.17.0-linux-x64.tar.xz...
####################################################################################################################### 100.0%
Computing checksum with sha256sum
Checksums matched!
Now using node v10.17.0 (npm v6.11.3)

$ nvm ls
->     v10.17.0
       v12.13.0
         system
default -> lts/* (-> v12.13.0)
node -> stable (-> v12.13.0) (default)
stable -> 12.13 (-> v12.13.0) (default)
iojs -> N/A (default)
unstable -> N/A (default)
lts/* -> lts/erbium (-> v12.13.0)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.16.2 (-> N/A)
lts/dubnium -> v10.17.0
lts/erbium -> v12.13.0

$ nvm use 10
Now using node v10.17.0 (npm v6.11.3)

$ node --version
v10.17.0

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!
/Users/ilg/.nvm/versions/node/v10.17.0/bin/npm -> /Users/ilg/.nvm/versions/node/v10.17.0/lib/node_modules/npm/bin/npm-cli.js
/Users/ilg/.nvm/versions/node/v10.17.0/bin/npx -> /Users/ilg/.nvm/versions/node/v10.17.0/lib/node_modules/npm/bin/npx-cli.js
+ npm@6.13.0
added 3 packages from 2 contributors, removed 3 packages and updated 20 packages in 3.081s
* npm upgraded to: v6.13.0

$ which npm
/Users/ilg/.nvm/versions/node/v10.17.0/bin/npm
```

At any time, to switch between any of the installed versions,
use `nvm use <version>`.

{% include note.html content="These commands were tested with `bash` on
Ubuntu 18 LTS and Manjaro 18; for other shells they may need small
adjustments." %}

{% endcapture %}

{% include platform-tabs.html %}

## Install xpm

The next step is to install the
[xPack Package Manager]({{ site.baseurl }}/xpm/install/).

## Miscellaneous

The official page explaining how to install **npm** in a custom folder is
[Resolving EACCES permissions errors when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally).

For less common platforms, it is also posible to install from unofficial
builds, or to build it from sources; for more details see the
[downloads](https://nodejs.org/en/download/) page.
