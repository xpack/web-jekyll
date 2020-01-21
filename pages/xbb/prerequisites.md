---
title: Prerequisites for building xPack binaries
permalink: /xbb/prerequisites/

date: 2017-07-06 20:55:00 +0300
last_updated: 2019-12-06 22:15:38 +0200

---

TODO: update it

The latest generation of the build scripts use the
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), a set
of Docker containers based on CentOS 6 (separate 32/64-bit containers).
The more conservative CentOS 6 was preferred to avoid problems when
attempting to run the executables on older versions.

The Windows binaries are also generated on the same Docker containers,
using [mingw-w64](http://mingw-w64.org).

The main trick that makes the multi-platform build possible is
[Docker](https://www.docker.com).

### GNU/Linux

Any GNU/Linux distribution that is able to run Docker should be ok; it
is not necessary to have a physical machine, virtual machines are
perfectly fine. For better results, dedicate 3-4 cores and 8-12 GB of RAM.

The procedure was tested on:

- Ubuntu 16.04 LTS, running as a virtual machine in Parallels Desktop on macOS 10.12.
- Ubuntu 17.10, running as a virtual machine in VirtualBox on macOS 10.13.
- Ubuntu 18.04 Server, running on an Intel NUC NUC8i7BEH with 32GB of RAM.

The build scripts do most of the actual work in the Docker container, and,
apart from Docker, the host machine has no other special requirements.

#### Install Docker

For any GNU/Linux distribution, follow the
[specific instructions](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository).

For example, the steps to install Docker on a modern 64-bit Ubuntu system are basically:

```console
$ sudo apt-get update

$ sudo apt-get install apt-transport-https ca-certificates  curl software-properties-common

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

$ version_name=$(lsb_release -cs)
$ sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  ${version_name} stable"

$ sudo apt-get update
$ sudo apt-get -y install docker-ce
```

{% include warning.html content="Please note that the above lines get the
current version name via `lsb_release` and assumes that a folder with that
name is available at https://download.docker.com/linux/ubuntu/dists/.
This is true for most versions, except the very latest one, which might not
yet be made available by the Docker team. In this case set the
`version_name` manually to the previous version.
You can also do this by
manually editting the `/etc/apt/sources.list` file.
At the time
of writing this, the version for Ubuntu 19.10 **eoan** is not available
and you must use **disco**." %}

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

```console
$ sudo groupadd docker
$ sudo gpasswd -a ${USER} docker
$ sudo service docker restart
```

The above script are for Ubuntu and the Debian family. For other
distributions, the last line may differ, for example for Arch Linux use:

```console
$ systemctl restart docker
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

For development build, the procedure is executed on the latest macOS
version (currently 10.13).

For production builds it is recommended to use a slightly older version.
macOS 10.10 is a good compromise, since it still allows to install
the additional build tools via Homebrew.

It is not mandatory to have a physical macOS 10.10 machine, a virtual
machine is also perfectly fine. Both Parallels and VirtualBox were
checked and work without problems.

#### Install the Command Line Tools

The macOS compiler and other development tools are packed in a
separate Xcode add-on. The best place to get it is from the
[Developer](https://developer.apple.com/xcode/downloads/) site,
although this might require enrolling to the developer program
(free of charge).

The recommended way is to first install Xcode, then the Command Line Tools.

```console
$ xcode-select -p
/Applications/Xcode.app/Contents/Developer
$ gcc --version
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include/c++/4.2.1
Apple LLVM version 9.0.0 (clang-900.0.39.2)
Target: x86_64-apple-darwin17.4.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```

It is also possible to install the Command Line Tools separately
via a command line:

```console
$ xcode-select --install
$ xcode-select -p
/Library/Developer/CommandLineTools
$ gcc --version
Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 8.1.0 (clang-802.0.42)
Target: x86_64-apple-darwin16.7.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
```

#### Install a custom instance of Homebrew

The build process is quite complex, and requires tools not available
in the standard Apple macOS distribution. These tools can be installed
with Homebrew. To keep these tools separate, a custom instance of
Homebrew is installed in `${HOME}/opt/homebrew/xbb`.

In a separate run, the **[MacTex](http://www.tug.org/mactex/)** tools
are also installed in `${HOME}/opt/texlive`. Alternatively you can
install MacTex in `/usr/local` using the official distribution, but
this will add lots of programs to the system path, and this is a bad
thing.

The entire process can be automated with two scripts, available from GitHub:

```console
$ mkdir -p ${HOME}/opt
$ git clone https://github.com/xpack/xpack-build-box.git \
    ${HOME}/Downloads/xpack-build-box.git
$ caffeinate bash ${HOME}/Downloads/xpack-build-box.git/macos/install-homebrew-xbb.sh
$ caffeinate bash ${HOME}/Downloads/xpack-build-box.git/macos/install-texlive.sh
```

The scripts run with user credentials, no `sudo` access is required.
Please be aware that both scripts take quite some time to complete.

#### Install Docker

On macOS, Docker can be installed by following the official
[Install Docker on macOS](https://docs.docker.com/docker-for-mac/install/)
instructions.

Due to the specifics of macOS, Docker cannot run native; instead,
it uses a GNU/Linux virtual machine running in Apple HyperKit
(Apple's virtualization framework).

For better results, dedicate 3-4 cores and 4-8 GB of RAM to Docker.

### Docker images

The Docker images are available from
[Docker Hub](https://hub.docker.com/u/ilegeul/). They were build using
the Dockerfiles available from
[XBB (xPack Build Box)](https://github.com/xpack/xpack-build-box/tree/master/centos).

If not already loaded, Docker will load the images at first usage.
The images are relatively large, around 3 GB.

It is possible to separately load the Docker images, using the
script `preload-images` command of each script.

More details in each script documentation page.
