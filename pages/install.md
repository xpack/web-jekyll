---
title: How to install the xPack prerequisites
permalink: /install/

keywords:
  - npm
  - xpack
  - install

node_version: 16.14.2
npm_version: 8.6.0

comments: true
toc: false

date: 2017-10-09 14:14:00 +0300

---

## Overview

All xPack Core Tools are [Node.js](https://nodejs.org) CLI application
available from the
[npmjs.com](https://www.npmjs.com) public repository and are installed
via `npm` which runs on top of `node`, which is the **Node.js**
(or Node in short) executable.

## Prerequisites

A recent [Node.js](https://nodejs.org) (>=**16.14**), since
some dependencies require new features. Detailed instructions
for each supported platform are available in the next section.

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

For Windows, the general procedure is to download the package
and install it as usual (see below for details).

For GNU/Linux and macOS, it is
**highly recommended** to **use a version manager** (see below).

The result is a binary program named `node` (or `node.exe` on Windows),
that can be used to execute
JavaScript code from the terminal, and a symbolic link named `npm`, pointing to
the `npm-cli.js` script, which is part of the Node.js module that implements
the npm functionality (on Windows, where symbolic links are problematic,
`.cmd` stubs are used).


{% capture version_manager %}

## Install `nvm` (node version manager)

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

{% capture xpm_install %}

## Install xpm

Follow the step in the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

If you followed the TL;DR steps, it was already installed. Otherwise,
if you already know what this is all about, issue the following command:

```sh
npm install --global xpm@latest
```

{% endcapture %}

{% capture xpm_install_windows %}

## Install xpm

Follow the step in the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

If you already know what this is all about, issue the following command:

```sh
npm install --global xpm@latest
```

{% endcapture %}

{% capture use_nvm %}

For Unix-like systems, it is
**highly recommended** to **use a version manager** (see below).

The result is a binary program named `node`,
that can be used to execute
JavaScript code from the terminal, and a symbolic link named `npm`, pointing to
the `npm-cli.js` script, which is part of the Node.js module that implements
the npm functionality.

{% endcapture %}

{% capture windows %}

For Windows, the general procedure is to download the package
and install it as usual (see below for details).

The result is a binary program named `node.exe`,
that can be used to execute
JavaScript code from the terminal, and a stub named `npm.cmd`, executing to
the `npm-cli.js` script, which is part of the Node.js module that implements
the npm functionality.

{{ manual_install }}

{{ node_install }}

Download the **Windows Installer (.msi)** from the Node.js
[download](https://nodejs.org/en/download/) page and install it as usual,
with administrative rights.

{% include tip.html content="If you are using a 64-bit machine, download the `node-v*-x64.msi` file." %}

The result is a folder like `C:\Program Files\nodejs`, added to the
system path since it includes the `node.exe` binary.

```doscon
C:\>where node.exe
C:\Program Files\nodejs\node.exe
C:\>node --version
v{{ page.node_version }}
```

{{ npm_update }}

A version of **npm**, usually a bit older, comes packed with Node.js.

```doscon
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
{{ page.node_version }}
```

It is recommended to update it to the latest version:

```doscon
C:\>npm install --global npm@latest
C:\Users\ilg\AppData\Roaming\npm\npm -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npm-cli.js
C:\Users\ilg\AppData\Roaming\npm\npx -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npx-cli.js
+ npm@{{ page.npm_version }}
added 435 packages from 816 contributors in 72.64s
```

Surprisingly, checking the version usually shows the old version:

```doscon
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
{{ page.node_version }}
```

This is because on Windows, by default, global node packages are
installed in the
user home folder, in `%APPDATA%\npm`
(like `C:\Users\ilg\AppData\Roaming\npm`);
and this path **is not** in the default environment.

```doscon
C:\>echo %Path%
```

It must be added manually in front of the current path:

```doscon
C:\>set Path=%APPDATA%\npm;%Path%
```

To make this setting persistent, also issue the following:

```doscon
C:\>setx Path "%APPDATA%\npm;%Path%"
```

{% include note.html content="Please note the syntax differences, no equal
sign and double quotes, specific to `setx` but harmful to `set`." %}

{% include note.html content="These commands are valid when using the
`cmd.exe` terminal; for PowerShell or other terminals, please adjust
the syntax to match their specifics." %}

After this, the new version of the program should be visible:

```doscon
C:\>npm --version
{{ page.npm_version }}
```

## Git

Although not mandatory for using the xPack tools alone, on Windows
it is recommended to
also install the [Git for Windows](https://git-scm.com/download/win) package.

The xPack Core Tools can run either in the Windows `cmd.exe` terminal,
or in the Git shell terminal.

## PowerShell Execution Policies

Recent Windows versions use PowerShell, which has a more restrictive
execution policy intended to prevent
the execution of malicious scripts; unfortunately this also prevents
the execution of node.js applications.

If you get a message in the console as the one below:

```doscon
xpm : File C:\Users\...\AppData\Roaming\npm\xpm.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ xpm init --template @xpack/hello-world-template@latest --property lan ...
+ ~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
The terminal process "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -Command xpm init --template @xpack/hello-world-template@latest --property language
```

then run the following command in a PowerShell terminal:

```doscon
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

For more details please read the Microsoft
[about_Execution_Policies](https://docs.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1) page.

{{ xpm_install_windows }}

{% endcapture %}

{% capture node_warning %}

{% include warning.html content="Due to a misconception, some
tutorials suggest to install Node.js with administrative rights;
this is not a problem
for `node` itself, but will also require administrative rights for using
`npm` and `xpm`, and these tools fail in various ways when installed
with administrative rights (mostly with problems related to permissions);
to simplify maintenance, the highly recommended method is to install
Node.js/npm in the home folder, using a version manager." %}

{% endcapture %}

{% capture macos %}

{{ use_nvm }}

{{ node_warning }}

## TL;DR

If you prefer a shortcut, copy/paste the following
[script](https://github.com/xpack/assets/blob/master/scripts/install-nvm-node-npm-xpm.sh) into a terminal:

```sh
curl -o- https://raw.githubusercontent.com/xpack/assets/master/scripts/install-nvm-node-npm-xpm.sh | bash

exit
```

## Command Line Tools

The system C/C++ headers and most development tools are not in the
standard macOS distribution, and need to be installed separately;
they are provided by Apple as the separate Command Line Tools package.

If you followed the TL;DR steps, it was already installed. Otherwise,
to install the Command Line Tools only if they are not already in the
expected location, use:

```sh
if [ ! -d "/Library/Developer/CommandLineTools/" ]
then
  xcode-select --install
fi
```

{% include note.html content="Please note that although the C/C++ headers
are also part of Xcode, their location is not fixed, hence the Command
Line Tools package must still be installed, for the xPack toolchains to
find them in the expected location." %}

If the `install-nvm-node-npm-xpm.sh` script was successful,
the rest of this page is only informative and can be skipped.

{{ version_manager }}

In short, [nvm](https://github.com/nvm-sh/nvm) changes the install
location to `~/.nvm` and allows to install multiple instances of node
in the `~/.nvm/versions/node` folder.

If you have a previous version of npm installed with a local prefix,
remove it:

```sh
npm config delete prefix
sudo rm -rf /usr/local/lib/node-modules /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npm
rm -rf ~/Library/npm ~/opt/npm
```

Also remove `${HOME}/Library/npm/bin` or `${HOME}/opt/npm/bin` from the PATH.

When everything is clean, run the install script:

```sh
touch ~/.zshrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```

This will install the version manager in `~/.nvm`, and add a few lines to the shell profile (`.zshrc`, which must be present).

{% include warning.html content="Please note that without these shell settings
nvm is not functional." %}

To install the latest node, after updating the shell profile, open a new
terminal (to make use of the new environment variables) and issue the
following:

```console
% nvm install --lts node
Downloading and installing node v16.18.0...
Downloading https://nodejs.org/dist/v16.18.0/node-v16.18.0-darwin-x64.tar.xz...
############################################################################################# 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v16.18.0 (npm v8.19.2)

$ nvm ls
      v12.22.12
->     v16.18.0
default -> node (-> v16.18.0)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v16.18.0) (default)
stable -> 16.18 (-> v16.18.0) (default)
lts/* -> lts/gallium (-> v16.18.0)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1 (-> N/A)
lts/erbium -> v12.22.12
lts/fermium -> v14.20.1 (-> N/A)
lts/gallium -> v16.18.0

$ nvm use node
Now using node v16.18.0 (npm v8.19.2)

$ nvm alias default node
default -> node (-> v16.18.0)

$ node --version
v16.18.0

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!

changed 16 packages, and audited 212 packages in 1s

11 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
* npm upgraded to: v8.19.2

$ which npm
/Users/ilg/.nvm/versions/node/v16.18.0/bin/npm
```

{% include note.html content="Please note that this will install the latest
**LTS** version; to install the very latest **Current** version, remove
the `--lts` option." %}

To explicitly install a previous version and to switch to it:

```console
% nvm install 12
Downloading and installing node v12.22.12...
Downloading https://nodejs.org/dist/v12.22.12/node-v12.22.12-darwin-x64.tar.xz...
######################################################################################################## 100.0%
Computing checksum with shasum -a 256
Checksums matched!

% nvm ls
       v10.24.1
->    v12.22.12
       v16.14.2
       v16.16.0
default -> 12 (-> v12.22.12)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v16.16.0) (default)
stable -> 16.16 (-> v16.16.0) (default)
lts/* -> lts/gallium (-> N/A)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1
lts/erbium -> v12.22.12
lts/fermium -> v14.20.1 (-> N/A)
lts/gallium -> v16.18.0 (-> N/A)

% nvm use 12
Now using node v12.22.12 (npm v6.14.16)

% nvm alias default 12
default -> 12 (-> v12.22.12)

% node --version
v12.22.12

% nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!
/Users/ilg/.nvm/versions/node/v12.22.12/bin/npx -> /Users/ilg/.nvm/versions/node/v12.22.12/lib/node_modules/npm/bin/npx-cli.js
/Users/ilg/.nvm/versions/node/v12.22.12/bin/npm -> /Users/ilg/.nvm/versions/node/v12.22.12/lib/node_modules/npm/bin/npm-cli.js
+ npm@8.19.2
added 73 packages from 21 contributors, removed 299 packages and updated 138 packages in 5.001s
* npm upgraded to: v8.19.2

$ which npm
/Users/ilg/.nvm/versions/node/v12.22.12/bin/npm
```

At any time, to switch between any of the installed versions,
use `nvm use <version>` & `nvm alias default <version>`.

{{ xpm_install }}

{% endcapture %}

{% capture linux %}

{{ use_nvm }}

{{ node_warning }}

## TL;DR

If you prefer a shortcut, copy/paste the following
[script](https://github.com/xpack/assets/blob/master/scripts/install-nvm-node-npm-xpm.sh) into a terminal:

```sh
curl -o- https://raw.githubusercontent.com/xpack/assets/master/scripts/install-nvm-node-npm-xpm.sh | bash

exit
```

{% include note.html content="Arm platforms, like the Raspberry Pi,
are supported, currently in both 32/64-bit variants." %}

If the `install-nvm-node-npm-xpm.sh` script was successful,
the rest of this page is only informative and can be skipped.

{{ version_manager }}

In short, [nvm](https://github.com/nvm-sh/nvm) changes the install
location to `~/.nvm` and allows to install
multiple instances of node
in the `~/.nvm/versions/node` folder.

If you have a previous version of npm installed with a local prefix,
remove it:

```sh
sudo rm -rf /usr/local/lib/nodejs
rm -rf ~/opt/npm
npm config delete prefix
```

Also remove `${HOME}/opt/npm/bin` from the PATH.

When everything is clean, run the install script:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
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

## The GCC development headers and libraries

Although not a requirement for the node/npm/xpm tools themselves, if the
xPack toolchains
are used for software development, including for running tests, the
system C/C++ headers and libraries will be needed.

Install them according to the distribution specifics.

{{ xpm_install }}

{% endcapture %}

{% include platform-tabs.html %}

## Miscellaneous

The official page explaining how to install **npm** in a custom folder is
[Resolving EACCES permissions errors when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally).

For less common platforms, it is also possible to install from unofficial
builds, or to build it from sources; for more details see the
[downloads](https://nodejs.org/en/download/) page.
