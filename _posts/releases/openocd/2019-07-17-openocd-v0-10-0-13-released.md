---
title:  xPack OpenOCD v0.10.0-13 released

version: 0.10.0-13
download_url: https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.10.0-13/

date:   2019-07-17 19:57:00 +0300
last_updated: 2019-07-22 22:14:05 +0300

categories:
  - releases
  - openocd

tags:
  - releases
  - openocd

---

Version {{ page.version }} is a maintenance release; it updates to the 
latest upstream master. 

[Binary files »]({{ page.download_url }})

## Install

The full details of installing the **xPack OpenOCD** on various platforms
are presented in the separate 
[Install]({{ site.baseurl }}/openocd/install/) page.

## Easy install 

The easiest way to install OpenOCD is with 
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as 
[`@xpack-dev-tools/openocd`](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```console
$ xpm install --global @xpack-dev-tools/openocd@latest
```

To install this specific version, use:

```console
$ xpm install --global @xpack-dev-tools/openocd@{{ page.version }}.1
```

## Changes

There are no functional changes.

Compared to the upstream, the following changes were applied:

- a configure option was added to configure branding (`--enable-branding`)
- the `src/openocd.c` file was edited to display the branding string
- the `contrib/60-openocd.rules` file was simplified to avoid protection 
  related issues.

## Known problems

- none

## Binaries

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

## Checksums

The SHA-256 hashes for the files are:

```
ba13b6697db9213fc51024e3bbfe6bb565106053569dfcd4b8966a75538ba7b5
xpack-openocd-0.10.0-13-darwin-x64.tgz

3283752a96235a5072eba27603f7976df00767c30acd011c84fa692cd5bfe3dd
xpack-openocd-0.10.0-13-linux-x32.tgz

44fefd65e915e9e697b490eb990b4555424af3b7c166c9e298058dc555039cae
xpack-openocd-0.10.0-13-linux-x64.tgz

d3801dc0f65940d23d39e3166d7e92a236f2f302d0ff7d692b34afef39ba3e4a
xpack-openocd-0.10.0-13-win32-x32.zip

f287d06db3d7fde4e407b939387b17d906d888c8750f0d465bef80b913c645ea
xpack-openocd-0.10.0-13-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/openocd-xpack](https://github.com/xpack-dev-tools/openocd-xpack/)
  * this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/v{{ page.version }}/)
  - all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/openocd-xpack/total.svg)](https://github.com/xpack-dev-tools/openocd-xpack/releases/)
  - GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/openocd/total.svg)](https://github.com/gnu-mcu-eclipse/openocd/releases/)
  - [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=openocd-xpack) (grouped per release)
- xnpmjs.com [@xpack-dev-tools/openocd](https://www.npmjs.com/package/@xpack-dev-tools/openocd)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/openocd.svg)](https://www.npmjs.com/package/@xpack-dev-tools/openocd/)

Credit to [Shields IO](https://shields.io) and [Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats).
