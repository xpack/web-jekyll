---
title: How to install the xPack tools?
permalink: /install/

toc: false
comments: true
keywords: 
  - npm
  - xpack
  - install


date: 2017-10-09 14:14:00 +0300
last_updated: 2019-07-04 23:24:50 +0300

---

## Overview

All Core Tools are [Node.js](https://nodejs.org) CLI application 
available from the 
[npmjs.com](https://www.npmjs.com) public repository and are installed
via `npm` which uses `node`.

## Prerequisites

A recent [Node.js](https://nodejs.org) (>=8.x), since the ECMAScript 6 class 
syntax is used.

```console
$ node --version
v10.16.0
```

If this is your first encounter with `npm`, you need to install the 
[Node.js](https://nodejs.org) JavaScript run-time. The process is 
straightforward and does not pollute the system locations significantly; 
there are two `node` versions, **LTS** (**Long Term Service**) and 
**Current**; generally it is safer to use LTS, especially on Windows.

![The Node Download page]({{ site.baseurl }}/assets/images/2019/nodejs-org.png)

The general procedure is to download the package suitable for your 
platform and install it as usual.
The result is a binary program called `node` (that can be used to execute 
JavaScript code from the terminal), and a link called `npm`, pointing to 
the `npm-cli.js` script, which is part of the Node module that implements 
the npm functionality (on Windows instead of soft links, 
`.cmd` stubs are used).

{% include tip.html content="The usual method is to install `node` with 
administrative rights;
it is also possible to install it in a custom location, using the
archive distributions. Regardless where it is installed, `node` must 
be in the system path." %}

{% capture node_install %}
## `node` install
{% endcapture %}

{% capture version_manager %}
### Version manager

For advanced users, it is recommended to use a version manager,
which allows to install multiple versions of Node.js in parallel. 
For details, see the 
[Using a Version Manager to install Node.js and npm](https://docs.npmjs.com/getting-started/installing-node#using-a-version-manager-to-install-nodejs-and-npm)
page.
{% endcapture %}

{% capture npm_install %}
## `npm` install
{% endcapture %}

{% capture windows %}

{{ node_install }}

Download the **Windows Installer (.msi)** and install it as usual, 
with administrative rights.

{% include tip.html content="If you are using a 64-bit machine, download the `node-v*-x64.msi` file." %}

The result is a folder like `C:\Program Files\nodejs`, added to the 
system path since it includes the `node.exe` binary.

```powershell
C:\>where node.exe
C:\Program Files\nodejs\node.exe
C:\>node --version
v10.16.0
```

{{ version_manager }}

{{ npm_install }}

A version of `npm`, usually a bit older, comes packed with `node`.

```powershell
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
6.4.1
```

It is recommended to update it to the latest version:

```powershell
C:\>npm install --global npm
C:\Users\ilg\AppData\Roaming\npm\npm -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npm-cli.js
C:\Users\ilg\AppData\Roaming\npm\npx -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npx-cli.js
+ npm@6.10.0
added 435 packages from 816 contributors in 72.64s
```

Surprisingly, checking the version usually shows the old version:

```powershell
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
6.4.1
```

This is because on **Windows**, by default, global node packages are 
installed in the 
user home folder, in `%APPDATA%\npm` 
(like `C:\Users\ilg\AppData\Roaming\npm`); 
and this path **is not** in the default environment.

```
C:\>echo %Path%
```

It must be added manually: 

```
C:\>setx Path "%Path%;%APPDATA%\npm"
```

After this, the new version of the program should be visible:

```
C:\>npm --version
6.10.0
```

### Git

Although not mandatory for using the xPack tools alone, on Windows 
it is recommended to 
also install the [Git for Windows](https://git-scm.com/download/win) package.

The xPack Core Tools can run either in the Windows `cmd.exe` terminal, 
or in the Git shell terminal.

{% endcapture %}

{% capture macos %}

{{ node_install }}

Download the **macOS Installer (.pkg)** and install it as usual,
with administrative rights.

The result is a binary like `/usr/local/bin/node` and a folder like
`/usr/local/lib/node_modules` where the modules, including `npm`, 
are installed.

```console
$ which node
/usr/local/bin/node
$ node --version
v10.16.0
$
```

{{ version_manager }}

{{ npm_install }}

A version of `npm`, usually a bit older, comes packed with `node`.

```console
$ which npm
/usr/local/bin/npm
npm --version
6.9.0
```

It is recommended to update it to the latest version.

### Default (with administrative rights)

On **macOS**, by default, global Node packages are installed in 
`/usr/local`, and managing them requires administrative rights.

```console
$ sudo npm install --global npm   <-- DO NOT DO THAT
```

### Recommended (without administrative rights)

To avoid some nasty errors while installing packages,
**the recommended install location** is `${HOME}/Library/npm`.

{% include note.html content="On macOS, by default, `~/Library` is 
hidden and does not show in folder selections. See below how to
make it visible again, or select an alternate location." %}

The commands to configure the custom location are:

```console
$ mkdir -p ~/Library/npm
$ npm config set prefix ~/Library/npm
$ echo 'export PATH="${HOME}/Library/npm/bin:${PATH}"' >> ~/.profile
$ source ~/.profile
```

With the environment properly set, the command to re-install `npm` is:

```
$ npm install --global npm
/Users/ilg/Library/npm/bin/npx -> /Users/ilg/Library/npm/lib/node_modules/npm/bin/npx-cli.js
/Users/ilg/Library/npm/bin/npm -> /Users/ilg/Library/npm/lib/node_modules/npm/bin/npm-cli.js
+ npm@6.10.0
added 14 packages from 10 contributors, removed 5 packages and updated 17 packages in 10.446s
$ 
```

To check if the environment is set correctly :

```console
$ which npm
/Users/ilg/Library/npm/bin/npm
$ npm --version
6.10.0
$
```

### Hidden folder

On macOS, by default, `~/Library` is hidden and does not show in 
folder selections.

To make it visible, use:

```console
$ /usr/bin/chflags nohidden ~/Library
$ xattr -d com.apple.FinderInfo ~/Library
```

### Alternate location

If, for any reasons, you are reluctant to un-hide this folder, 
an alternate solution is to use `~/opt`, as on GNU/Linux.

```console
$ mkdir -p ~/opt/npm
$ npm config set prefix ~/opt/npm
$ echo 'export PATH="${HOME}/opt/npm/bin:${PATH}"' >> ~/.profile
$ source ~/.profile
```

(Be sure to remove the previous location from `.profile`.)

If you do this, you should also set the environment variables which
define the location where xPacks are installed, which also defaults to
`~/Library` (add the following to `~/.profile`):

```
XPACKS_REPO_FOLDER="${HOME}/opt/xPacks"
XPACKS_CACHE_FOLDER="${HOME}/.cache/xPacks"
```

{% endcapture %}

{% capture linux %}

{{ node_install }}

On GNU/Linux, download the **Linux Binaries (x64)** archive from the Node.js
[download](https://nodejs.org/en/download/) page.

{% include note.html content="Currently only a 64-bit binary is available." %}

To install, follow the instructions from the 
[Installing Node.js via binary archive on Linux](https://github.com/nodejs/help/wiki/Installation) page.

The result is a binary like `/usr/bin/node` and a folder like
`/usr/lib/node_modules` where the modules, including `npm`, are installed.

{% include warning.html content="Your distribution may already have a `node` 
binary installed; if
it is not >=8.x, xpm will complain and do not start; anyway, we strongly
recommend, if old, to avoid the distribution binary and install at least 
the LTS package from Node.js." %}

```console
$ which node
/usr/local/bin/node
$ node --version
v10.16.0
$
```

{{ version_manager }}

{{ npm_install }}

A version of `npm`, usually a bit older, comes packed with `node`.

```console
$ which npm
/usr/local/bin/npm
npm --version
6.9.0
```

It is recommended to update it to the latest version.

### Default (with administrative rights)

On **GNU/Linux**, by default, global Node packages are installed in 
`/usr/local`, and managing them requires administrative rights.

```console
$ sudo npm install --global npm   <-- DO NOT DO THAT
```

### Recommended (without administrative rights)

To avoid some nasty errors while installing packages,
**the recommended install location** is `${HOME}/opt/npm`.

The commands to configure the custom location are:

```console
$ mkdir -p ~/opt/npm
$ npm config set prefix ~/opt/npm
$ echo 'export PATH="${HOME}/opt/npm/bin:${PATH}"' >> ~/.profile
$ source ~/.profile
```

To check if the environment is set correctly :

```console
$ which npm
/Users/ilg/Library/npm/bin/npm
$ npm --version
6.10.0
$
```

(These commands were tested with `bash`, for other shells they may need 
small adjustments.)

{% endcapture %}

{% include platform-tabs.html %}

## Miscellaneous

The official page explaining how to install `npm` in a custom
folder is [How to Prevent Permissions Errors](https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-two-change-npms-default-directory).
