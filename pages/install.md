---
title: How to install the xPack tools?
permalink: /install/

toc: false
comments: true
keywords: 
  - npm
  - xpack
  - install

node_version: v10.16.0
npm_version: 6.10.1

date: 2017-10-09 14:14:00 +0300
last_updated: 2019-07-12 09:30:07 +0300

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
{{ page.node_version }}
```

If this is your first encounter with `npm`, you need to install the 
[Node.js](https://nodejs.org) JavaScript run-time. The process is 
straightforward and does not pollute the system locations significantly; 
there are two Node versions, **LTS** (**Long Term Service**) and 
**Current**; generally it is safer to use LTS, especially on Windows.

![The Node Download page]({{ site.baseurl }}/assets/images/2019/nodejs-org.png)

The general procedure is to download the package suitable for your 
platform and install it as usual.
The result is a binary program called `node` (that can be used to execute 
JavaScript code from the terminal), and a link called `npm`, pointing to 
the `npm-cli.js` script, which is part of the Node module that implements 
the npm functionality (on Windows instead of soft links, 
`.cmd` stubs are used).

{% include tip.html content="The usual method is to install Node with 
administrative rights;
it is also possible to install it in a custom location, using the
archive distributions. Regardless where it is installed, the `node` 
executable must be in the system path." %}

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

{% capture npm_update %}
## `npm` update
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
{{ page.node_version }}
```

{{ version_manager }}

{{ npm_update }}

A version of `npm`, usually a bit older, comes packed with `node`.

```powershell
C:\>where npm.cmd
C:\Program Files\nodejs\npm.cmd
C:\>npm --version
6.4.1
```

It is recommended to update it to the latest version:

```powershell
C:\>npm install --global npm@latest
C:\Users\ilg\AppData\Roaming\npm\npm -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npm-cli.js
C:\Users\ilg\AppData\Roaming\npm\npx -> C:\Users\ilg\AppData\Roaming\npm\node_modules\npm\bin\npx-cli.js
+ npm@{{ page.npm_version }}
added 435 packages from 816 contributors in 72.64s
```

Surprisingly, checking the version usually shows the old version:

```powershell
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

It must be added manually: 

```
C:\>setx Path "%Path%;%APPDATA%\npm"
```

After this, the new version of the program should be visible:

```
C:\>npm --version
{{ page.npm_version }}
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
{{ page.node_version }}
```

{{ version_manager }}

{{ npm_update }}

A version of `npm`, usually a bit older, comes packed with `node`.

```console
$ which npm
/usr/local/bin/npm
npm --version
6.9.0
```

It is recommended to update it to the latest version.

### Default (with administrative rights)

On macOS, by default, global Node packages are installed in 
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
$ npm install --global npm@latest
/Users/ilg/Library/npm/bin/npx -> /Users/ilg/Library/npm/lib/node_modules/npm/bin/npx-cli.js
/Users/ilg/Library/npm/bin/npm -> /Users/ilg/Library/npm/lib/node_modules/npm/bin/npm-cli.js
+ npm@{{ page.npm_version }}
added 14 packages from 10 contributors, removed 5 packages and updated 17 packages in 10.446s
```

To check if the environment is set correctly :

```console
$ which npm
/Users/ilg/Library/npm/bin/npm
$ npm --version
{{ page.npm_version }}
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

{% include warning.html content="Your distribution may already have a `node` 
binary installed; check it (via `node --version`) and if it is older than LTS,
remove the distribution binary and install 
the LTS package from Node.js." %}

For example, on Ubuntu 18 LTS, both Node and npm are very old:

```console
$ node --version
v8.10.0
$ npm --version
3.5.2
```

and, to avoid problems, it is probably better to remove them:

```console
$ sudo apt remove --yes nodejs npm
```

Download the **Linux Binaries (x64)** archive from the Node.js
[download](https://nodejs.org/en/download/) page; 
the result is a file like `node-{{ page.node_version }}-linux-x64.tar.xz`.

{% include note.html content="Currently only a 64-bit binary is available." %}

Extract the content of the archive in `/usr/local/lib/nodejs`:

```console
$ sudo mkdir -p /usr/local/lib/nodejs
$ sudo tar -xJvf ~/Downloads/node-{{ page.node_version }}-linux-x64.tar.xz -C /usr/local/lib/nodejs
```

and, for easy access, create soft links to the executables in `/usr/local/bin`:

```console
$ sudo ln -s /usr/local/lib/nodejs/node-{{ page.node_version }}-linux-x64/bin/node /usr/local/bin/node
$ sudo ln -s /usr/local/lib/nodejs/node-{{ page.node_version }}-linux-x64/bin/npm /usr/local/bin/npm
$ sudo ln -s /usr/local/lib/nodejs/node-{{ page.node_version }}-linux-x64/bin/npx /usr/local/bin/npx
```

{% include note.html content="This location requires the `/usr/local/bin` to be
in `PATH`. If it is not, you must add `export PATH=\"/usr/local/bin:${PATH}\"` 
in `.profile`." %}

After this, the new Node should be available:

```console
$ which node
/usr/local/bin/node
$ node --version
{{ page.node_version }}
```

{{ version_manager }}

{{ npm_update }}

A version of `npm`, usually a bit older, comes packed with `node`.

```console
$ which npm
/usr/local/bin/npm
$ npm --version
6.7.0
```

It is recommended to update it to the latest version.

### Default (with administrative rights)

On GNU/Linux, by default, global Node packages are installed in 
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

Now it is possible to install npm without `sudo`:

```console
$ npm install --global npm@latest
/home/ilg/opt/npm/bin/npm -> /home/ilg/opt/npm/lib/node_modules/npm/bin/npm-cli.js
/home/ilg/opt/npm/bin/npx -> /home/ilg/opt/npm/lib/node_modules/npm/bin/npx-cli.js
+ npm@{{ page.npm_version }}
added 21 packages from 15 contributors, removed 14 packages and updated 37 packages in 12.609s
```

To check if the environment is set correctly :

```console
$ which npm
/home/ilg/opt/npm/bin/npm
$ npm --version
{{ page.npm_version }}
```

{% include note.html content="These commands were tested with `bash` on 
Ubuntu 18 LTS; for other shells they may need small adjustments." %}

{% endcapture %}

{% include platform-tabs.html %}

## Miscellaneous

The official page explaining how to install `npm` in a custom
folder is [How to Prevent Permissions Errors](https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-two-change-npms-default-directory).
