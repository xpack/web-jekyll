---
title: Prerequisites for building xPack binaries
permalink: /xbb/prerequisites/

comments: true

date: 2017-07-06 20:55:00 +0300

---

The latest generation of the build scripts use the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of [Docker](https://www.docker.com)
containers (separate 32/64-bit containers) based on older
and more conservative distributions, to avoid problems when
attempting to run the executables on older versions.

The XBB v5.0.0 uses Ubuntu 18 LTS for both Intel and Arm GNU/Linux.

{% include note.html content="Building Arm binaries requires
an Arm machine. A Raspberry Pi 4 8GB equipped with a Samsung Portable T7
USB 3 SSD is a good solution." %}

{% include note.html content="Although Arm 32 binaries can be build
inside Docker containers running on AArch64 machines,
it is still recommended to use a 32-bit OS, to avoid issues caused
by the differences between armv7 and armv8." %}

The Windows binaries are generated on the same Docker Intel GNU/Linux
container, using [mingw-w64](https://mingw-w64.org).

## Prerequisites

The build scripts run on GNU/Linux and macOS.

### GNU/Linux

Any GNU/Linux distribution that is able to run Docker should be ok; it
is not necessary to have a physical machine, virtual machines are
perfectly fine. For better results, dedicate 3-4 cores and 8-12 GB of RAM.

The build scripts were tested on:

- Ubuntu 18.04 LTS, running on an Intel NUC NUC8i7BEH with 32 GB of RAM
- Debian 10 (buster), running on an AMD Ryzen 5600G with 32 GB of RAM
- Raspberry Pi OS 64-bit, running on a Raspberry Pi 4 with 8 GB of RAM
- Raspberry Pi OS 32-bit, running on a Raspberry Pi 4 with 4 GB of RAM

The prerequisites are:

- `docker`
- `git` (installed via the system package manager)
- `npm` (shipped with Node.js; installed via nvm, not the system package manager)
- `xpm` (installed via `npm`)

The build scripts do most of the actual work in the Docker container, and,
apart from `docker`, `git` and `xpm`, the host machine has no other special
requirements.

### macOS

With a container solution similar to Docker not available to run macOS
containers, the macOS builds run natively on Intel and Apple Silicon
machines, and, apart from the usual Command Line Tools (provided by
Apple) and `xpm`, the host machine has no other special
requirements.

The build scripts were tested on:

- macOS 12.6.3, running on an Intel MacMini
- macOS 10.13, running inside a Parallels virtual machine
- macOS 11.7.4, running on an Apple Silicon MacMini

The prerequisites are:

- the Command Line Tools
- `npm` (shipped with Node.js; installed via nvm)
- `xpm` (installed via `npm`)

Some build scripts may require **Python 3**. If not already available in the
standard Apple distribution, install it from Python
[downloads](https://www.python.org/downloads/macos/).

## npm

`npm` is shipped with Node.js, and is required to install `xpm`.

For details on installing Node.js, please see the
[xPack prerequisites]({{ site.baseurl }}/install/) page.

{% include warning.html content="Be sure you **do not** install npm
with administrative rights, like via a system package manager;
use `nvm` instead, as instructed, otherwise you will run into
troubles caused by permissions." %}

## xpm

[xpm](https://xpack.github.io/xpm/) is a portable
[Node.js](https://nodejs.org/) command line application.

To install it, follow the steps in the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

## Docker

### GNU/Linux

Any GNU/Linux distribution that is able to run Docker should be ok; it
is not necessary to have a physical machine, virtual machines are
perfectly fine. For better results, dedicate 3-4 cores and 8-12 GB of RAM.

The procedure was tested on:

- Ubuntu 18.04 LTS, running on an Intel NUC NUC8i7BEH with 32 GB of RAM
- Debian 10 (buster), running on an AMD Ryzen 5600G with 32 GB of RAM
- Raspberry Pi OS 64-bit, running on a Raspberry Pi 4 with 8 GB of RAM
- Raspberry Pi OS 32-bit, running on a Raspberry Pi 4 with 4 GB of RAM

#### Install Docker

For any GNU/Linux distribution, follow the
[specific instructions](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository).

For example, the steps to install Docker on a modern Ubuntu system are basically:

```sh
sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates  curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

version_name=$(lsb_release -cs)
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  ${version_name} stable"

sudo apt-get update
sudo apt-get -y install docker-ce
```

{% include warning.html content="Please note that the above lines get the
current version name via `lsb_release` and assumes that a folder with that
name is available at https://download.docker.com/linux/ubuntu/dists/.
This is true for most versions, except the very latest one, which might not
yet be made available by the Docker team. In this case set the
`version_name` manually to the previous version.
You can also do this by
manually editing the `/etc/apt/sources.list` file." %}

To check if the install is functional, run the _Hello World_ image,
for the moment as `sudo`:

```console
$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b04784fba78d: Pull complete
Digest: sha256:f3b3b28a45160805bb16542c9531888519430e9e6d6ffc09d72261b0d26ff74f
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
...
```

#### Configure Docker to run as a regular user

To allow Docker to run as a regular user, you need to be a member of
the `docker` group.

```sh
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
```

The above script are for Ubuntu and the Debian family. For other
distributions, the last line may differ, for example for Arch Linux use:

```sh
systemctl restart docker
```

To make these changes effective, preferably **reboot** the machine.

To check if the configuration change is functional, run the same
_Hello World_ image without sudo:

```console
$ docker run hello-world

Hello from Docker!
...
```

### macOS

For development builds, the procedure is executed on a recent macOS
version (currently 12.6).

For production builds it is recommended to use a slightly older version.
macOS 10.13 is a good compromise.

It is not mandatory to have a physical macOS 10.13 machine, a virtual
machine is also perfectly fine. Both Parallels and VirtualBox were
checked and were functional (although VirtualBox was not as stable
as Parallels).

#### Install the Command Line Tools

The macOS compiler and other development tools are packed in a
separate Xcode add-on. The best place to get it is from the
[Developer](https://developer.apple.com/xcode/downloads/) site,
although this might require enrolling to the developer program
(free of charge).

The recommended way is to install the Command Line Tools separately
via a command line:

```console
$ xcode-select --install
$ xcode-select -p
/Library/Developer/CommandLineTools
$ gcc --version
Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/4.2.1
Apple clang version 13.0.0 (clang-1300.0.29.3)
Target: x86_64-apple-darwin20.6.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
```

{% include note.html content="Xcode alone includes the compiler
in the Xcode.app folder, which may very in different versions;
for a stable configuration it is
required to install the CommandLineTools package." %}

#### No macOS Docker

Due to the specifics of macOS, Docker cannot run natively; instead,
it uses a GNU/Linux virtual machine running in Apple HyperKit
(Apple's virtualization framework), and a file system compatibility
layer.

The end result is that Docker runs slow, consumes a lot of memory,
and is not reliable, so it is not recommended to run the
Linux/Windows builds on macOS.

### Docker images

The Docker images are available from
[Docker Hub](https://hub.docker.com/u/ilegeul/). They were build using
the Dockerfiles available from
[XBB (xPack Build Box)](https://github.com/xpack/xpack-build-box/tree/master/).

If not already loaded, Docker will load the images at first usage.
The images are reasonably large, currently below 1 GB.

More details in each script documentation page.

## Visual Studio Code

Although not mandatory, VS Code is a nice addition to the development
environment, and with the
[xPack extension](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack),
some of the actions are only at a mouse click distance.
