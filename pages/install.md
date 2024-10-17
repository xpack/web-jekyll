---
title: How to install the xPack prerequisites
permalink: /install/

keywords:
  - npm
  - xpack
  - install

node_version: 18.18.2
npm_version: 9.8.1
npm_latest_version: 10.2.0

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

A recent [Node.js](https://nodejs.org) (>=**18**), since
some dependencies require new features. Detailed instructions
for each supported platform are available in the next section.

```console
$ node --version
v{{ page.node_version }}
```

If this is your first encounter with **npm**, you need to install the
[Node.js](https://nodejs.org) ECMAScript (JavaScript) run-time. The process is
straightforward and does not pollute the system locations;
there are two Node versions, **LTS** (**Long Term Service**) and
**Current**; generally it is safer to use **LTS**, especially on Windows.

![The Node Download page]({{ site.baseurl }}/assets/images/2023/nodejs-org.png)

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

[`xpm`](https://xpack.github.io/xpm/) is a portable
[Node.js](https://nodejs.org/) command line application.

If you followed the _Quick instructions_, it was already installed.

Otherwise, to install it, follow the steps in the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

If you know what you're doing and prefer a shortcut,
issue the following command:

```sh
npm install -location=global xpm@latest
```

{% endcapture %}

{% capture xpm_install_windows %}

## Install xpm

Follow the step in the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

If you already know what this is all about, issue the following command:

```sh
npm install -location=global xpm@latest
```

{% endcapture %}

{% capture use_nvm %}

For Unix-like systems, it is
**highly recommended** to **use a version manager** (see below).

The result is a binary program named `node`,
that can be used to execute
JavaScript code from the terminal, and a symbolic link named `npm`, pointing to
the `npm-cli.js` script, which is part of the Node.js module that implements
the `npm` functionality.

{% endcapture %}

{% capture tldr %}

## Quick instructions

If you know what you're doing and prefer a shortcut, copy/paste the following
[script](https://github.com/xpack/assets/blob/master/scripts/install-nvm-node-npm-xpm.sh)
into a terminal (otherwise perform the steps one by one).

{% include warning.html content="For security reasons, conscientious users
should first check the content of the file before executing it." %}

If you trust the script, you can use the following shortcut:

```sh
curl https://raw.githubusercontent.com/xpack/assets/master/scripts/install-nvm-node-npm-xpm.sh | bash

exit
```

Otherwise download and check the script:

```sh
mkdir -pv "${HOME}/Downloads/"
curl --output "${HOME}/Downloads/install-nvm-node-npm-xpm.sh" https://raw.githubusercontent.com/xpack/assets/master/scripts/install-nvm-node-npm-xpm.sh
cat "${HOME}/Downloads/install-nvm-node-npm-xpm.sh"

bash "${HOME}/Downloads/install-nvm-node-npm-xpm.sh"

exit
```

This script will install `nvm` (the Node Version Manager), `node`,
`npm` and `xpm`.

{% include note.html content="To activate `nvm` automatically,
the script adds several lines
to the shell initialisation script." %}

{% endcapture %}

{% capture windows %}

For Windows, the general procedure is to download the package
and install it as usual (see below for details).

The result is a binary program named `node.exe`,
that can be used to execute
JavaScript code from the terminal, and a stub named `npm.cmd`, executing
the `npm-cli.js` script, which is part of the Node.js module that implements
the `npm` functionality.

{{ manual_install }}

{{ node_install }}

Download the Windows **Prebuilt Installer** (a `.msi` file) from the Node.js
[download](https://nodejs.org/en/download/prebuilt-installer) page and install it as usual,
with administrative rights.

{% include tip.html content="If you are using a 64-bit machine, download the `node-v*-x64.msi` file." %}

{% include tip.html content="Unless you do native module development, when asked to install
the **Tools for Native Modules**, be sure you do **not** select it,
otherwise you might end up with Visual Studio and other very large
packages installed." %}

![The Node.js Tools for Native Modules]({{ site.baseurl }}/assets/images/2024/nodejs-setup-tools-for-native-modules.png)

The result of the setup is a folder like `C:\Program Files\nodejs`, already
added to the system path since it includes the `node.exe` binary.

```txt
C:\>where node.exe
C:\Program Files\nodejs\node.exe
C:\>node --version
v{{ page.node_version }}
```

{{ npm_update }}

A version of **npm**, usually a bit older, comes packed with Node.js.

```txt
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
{{ page.npm_version }}
```

It is recommended to update it to the latest version:

```txt
C:\>npm install -location=global npm@latest
removed 1 package, and changed 60 packages in 5s

27 packages are looking for funding
  run `npm fund` for details
```

Surprisingly, checking the version usually shows the old version:

```txt
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
{{ page.npm_version }}
```

This is because on Windows, by default, global node packages are
installed in the
user home folder, in `%APPDATA%\npm`
(like `C:\Users\ilg\AppData\Roaming\npm`);
and this path **is not** in the default environment.

```txt
C:\>echo %Path%
```

It must be added manually **in front** of the current path:

```txt
C:\>set Path=%APPDATA%\npm;%Path%
```

To make this setting **persistent**, also issue the following:

```txt
C:\>setx Path "%APPDATA%\npm;%Path%"
```

{% include note.html content="Please note the syntax differences, no equal
sign and double quotes, specific to `setx` but harmful to `set`." %}

{% include note.html content="These commands are valid when using the
`cmd.exe` terminal; for PowerShell or other terminals, please adjust
the syntax to match their specifics." %}

After this, the new version of the program should be visible:

```txt
C:\>npm --version
{{ page.npm_latest_version }}
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

```txt
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

```txt
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
```

For more details please read the Microsoft
[about_Execution_Policies](https://docs.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1) page.

## node/npm clean-ups

If installed as recommended via setup, **node** can be uninstalled via the
Microsoft specific mechanisms.

For a thorough clean-up, please note that **npm** uses the following two folders
to install global packages:

- `%APPDATA%\Roaming\npm`
- `%APPDATA%\Local\npm-cache`

They can be removed at any time, and **npm** will recreate them on new installs.

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

{{ tldr }}

## Command Line Tools

The system C/C++ headers and most development tools are not in the
standard macOS distribution, and need to be installed separately;
they are provided by Apple as the separate Command Line Tools package.

If you followed the _Quick instructions_, it was already installed. Otherwise,
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

{% include tip.html content="If the `install-nvm-node-npm-xpm.sh`
script was successful,
the rest of this page is only informative and can be skipped." %}

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
Downloading and installing node v18.18.2...
Downloading https://nodejs.org/dist/v18.18.2/node-v18.18.2-darwin-x64.tar.xz...
######################################################################### 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v18.18.2 (npm v9.8.1)
Creating default alias: default -> lts/* (-> v18.18.2)

$ nvm ls
->     v18.18.2
default -> lts/* (-> v18.18.2)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v18.18.2) (default)
stable -> 18.18 (-> v18.18.2) (default)
lts/* -> lts/hydrogen (-> v18.18.2)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1 (-> N/A)
lts/erbium -> v12.22.12 (-> N/A)
lts/fermium -> v14.21.3 (-> N/A)
lts/gallium -> v16.20.2 (-> N/A)
lts/hydrogen -> v18.18.2

$ nvm use node
Now using node v18.18.2 (npm v9.8.1)

$ nvm alias default node
default -> node (-> v18.18.2)

$ node --version
v18.18.2

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!

removed 2 packages, and changed 62 packages in 2s

29 packages are looking for funding
  run `npm fund` for details
* npm upgraded to: v10.2.0

$ which npm
/Users/ilg/.nvm/versions/node/v18.18.2/bin/npm
```

{% include note.html content="Please note that this will install the latest
**LTS** version; to install the very latest **Current** version, remove
the `--lts` option." %}

To explicitly install a previous version and to switch to it:

```console
% nvm install 16
Downloading and installing node v16.20.2...
Downloading https://nodejs.org/dist/v16.20.2/node-v16.20.2-darwin-x64.tar.xz...
######################################################################### 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v16.20.2 (npm v8.19.4)

% nvm ls
->     v16.20.2
       v18.18.2
default -> node (-> v18.18.2)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v18.18.2) (default)
stable -> 18.18 (-> v18.18.2) (default)
lts/* -> lts/hydrogen (-> v18.18.2)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1 (-> N/A)
lts/erbium -> v12.22.12 (-> N/A)
lts/fermium -> v14.21.3 (-> N/A)
lts/gallium -> v16.20.2
lts/hydrogen -> v18.18.2

% nvm use 16
Now using node v16.20.2 (npm v8.19.4)

% nvm alias default 16
default -> 16 (-> v16.20.2)

% node --version
v16.20.2

% nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* `npm` `v9.x` is the last version that works on `node` `< v18.17`, `v19`, or `v20.0` - `v20.4`

removed 17 packages, changed 101 packages, and audited 252 packages in 2s

28 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
* npm upgraded to: v9.9.0

$ which npm
/Users/ilg/.nvm/versions/node/v16.20.2/bin/npm
```

At any time, to switch between any of the installed versions,
use `nvm use <version>` & `nvm alias default <version>`.

## nvm/node/npm clean-ups

For a thorough clean-up, please note that **nvm/node/npm** use only two folders:

- `$HOME/.nvm`
- `$HOME/.cache/node`

They can be removed at any time, and **nvm** will recreate them on new installs.

{{ xpm_install }}

{% endcapture %}

{% capture linux %}

{{ use_nvm }}

{{ node_warning }}

{{ tldr }}

{% include callout.html content="Arm platforms, like the Raspberry Pi,
are supported, currently in both 32/64-bit variants." %}

{% include tip.html content="If the `install-nvm-node-npm-xpm.sh`
script was successful,
the rest of this page is only informative and can be skipped." %}

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
% nvm install --lts node
Downloading and installing node v18.18.2...
Downloading https://nodejs.org/dist/v18.18.2/node-v18.18.2-darwin-x64.tar.xz...
######################################################################### 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v18.18.2 (npm v9.8.1)
Creating default alias: default -> lts/* (-> v18.18.2)

$ nvm ls
->     v18.18.2
default -> lts/* (-> v18.18.2)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v18.18.2) (default)
stable -> 18.18 (-> v18.18.2) (default)
lts/* -> lts/hydrogen (-> v18.18.2)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1 (-> N/A)
lts/erbium -> v12.22.12 (-> N/A)
lts/fermium -> v14.21.3 (-> N/A)
lts/gallium -> v16.20.2 (-> N/A)
lts/hydrogen -> v18.18.2

$ nvm use node
Now using node v18.18.2 (npm v9.8.1)

$ nvm alias default node
default -> node (-> v18.18.2)

$ node --version
v18.18.2

$ nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* Installing latest `npm`; if this does not work on your node version, please report a bug!

removed 2 packages, and changed 62 packages in 2s

29 packages are looking for funding
  run `npm fund` for details
* npm upgraded to: v10.2.0

$ which npm
/home/ilg/.nvm/versions/node/v18.18.2/bin/npm
```

{% include note.html content="Please note that this will install the latest
**LTS** version; to install the very latest **Current** version, remove
the `--lts` option." %}

To explicitly install a previous version and to switch to it:

```console
% nvm install 16
Downloading and installing node v16.20.2...
Downloading https://nodejs.org/dist/v16.20.2/node-v16.20.2-darwin-x64.tar.xz...
######################################################################### 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v16.20.2 (npm v8.19.4)

% nvm ls
->     v16.20.2
       v18.18.2
default -> node (-> v18.18.2)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v18.18.2) (default)
stable -> 18.18 (-> v18.18.2) (default)
lts/* -> lts/hydrogen (-> v18.18.2)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1 (-> N/A)
lts/erbium -> v12.22.12 (-> N/A)
lts/fermium -> v14.21.3 (-> N/A)
lts/gallium -> v16.20.2
lts/hydrogen -> v18.18.2

% nvm use 16
Now using node v16.20.2 (npm v8.19.4)

% nvm alias default 16
default -> 16 (-> v16.20.2)

% node --version
v16.20.2

% nvm install-latest-npm
Attempting to upgrade to the latest working version of npm...
* `npm` `v9.x` is the last version that works on `node` `< v18.17`, `v19`, or `v20.0` - `v20.4`

removed 17 packages, changed 101 packages, and audited 252 packages in 2s

28 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
* npm upgraded to: v9.9.0

$ which npm
/home/ilg/.nvm/versions/node/v16.20.2/bin/npm
```

At any time, to switch between any of the installed versions,
use `nvm use <version>`.

{% include callout.html content="These commands were tested with `bash` on
Ubuntu 18 LTS and Manjaro 18; for other shells they may need small
adjustments." %}

## git & curl

Although not a requirement for the node/npm/xpm tools themselves,
it is recommended to have these tools installed, especially `git`,
since all examples start with cloning projects.

Install them according to the distribution specifics.

For example on Ubuntu and Debian derived distributions, use:

```sh
sudo apt-get install --yes git curl
```

## The GCC development headers and libraries

Also not a requirement for the node/npm/xpm tools themselves, if the
xPack toolchains
are used for software development, including for running tests, **the
system C/C++ headers and libraries** will be needed.

Install them according to the distribution specifics.

For example on Ubuntu and Debian derived distributions, use:

```sh
sudo apt-get install --yes g++ libc6-dev libstdc++6
```

To compile 32-bit application on 64-bit Intel systems, the **multilib**
package is necessary:

```sh
sudo apt-get install --yes g++-multilib
```

For some applications, the kernel headers are also necessary:

```sh
sudo apt-get install --yes linux-headers-generic
```

## nvm/node/npm clean-ups

For a thorough clean-up, please note that **nvm/node/npm** use only two folders:

- `$HOME/.nvm`
- `$HOME/.npm`

They can be removed at any time, and **nvm** will recreate them on new installs.

{{ xpm_install }}

{% endcapture %}

{% include platform-tabs.html %}

## Miscellaneous

The official page explaining how to install **npm** in a custom folder is
[Resolving EACCES permissions errors when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally).

For less common platforms, it is also possible to install from unofficial
builds, or to build it from sources; for more details see the
[downloads](https://nodejs.org/en/download/) page.
