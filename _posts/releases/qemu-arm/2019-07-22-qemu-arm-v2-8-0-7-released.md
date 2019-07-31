---
title:  xPack QEMU ARM v2.8.0-7 released

summary: "Version 2.8.0-7 is a maintenance release, to fix a bug
affecting Windows."

version: 2.8.0-7
npm_subversion: 1
download_url: https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/tag/v2.8.0-7/

date:   2019-07-22 20:38:00 +0300
last_updated: 2019-07-31 03:32:50 +0300

categories:
  - releases
  - qemu
  - arm
  - cortex-m

tags:
  - releases
  - qemu

---

[Binary files »]({{ page.download_url }})

## Install

The full details of installing the **xPack QEMU ARM** on various platforms
are presented in the separate 
[Install]({{ site.baseurl }}/qemu-arm/install/) page.

### Easy install 

The easiest way to install QEMU ARM is with 
[`xpm`]({{ site.baseurl }}/xpm/)
by using the **binary xPack**, available as 
[`@xpack-dev-tools/qemu-arm`](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm)
from the [`npmjs.com`](https://www.npmjs.com) registry.

To install the latest version available, use:

```console
$ xpm install --global @xpack-dev-tools/qemu-arm@latest
```

To install this specific version, use:

```console
$ xpm install --global @xpack-dev-tools/qemu-arm@{{ page.version }}.{{ page.npm_subversion }}
```

## Bug fixes

- [[#70](https://github.com/gnu-mcu-eclipse/qemu/issues/70)] due to a bug 
  in the Windows specific part, in certain conditions, starting QEMU in
  non-graphic mode affected the GDB server functionality; thanks to a 
  contribution by GitHub user `@zaq32` 
  [[#71](https://github.com/gnu-mcu-eclipse/qemu/pull/71)] the bug was fixed.
  
## Known problems

- Ctrl-C does not interrupt the execution if the `--nographic` option is used.

## Binaries

Binaries for **Windows**, **macOS** and **GNU/Linux** are provided.

## Checksums

The SHA-256 hashes for the files are:

```
feae25ec1944044ce2c2feb6fb0d76e67e9d93e811b5091cf4d3ffdf5a320d37 
xpack-qemu-arm-2.8.0-7-darwin-x64.tgz

d094ac6236ebf8b0356e159b596bddb225b943d3a8accfed5368f0ed86e86fa4 
xpack-qemu-arm-2.8.0-7-linux-x32.tgz

83e531bfb466430d3eff1039e4da0fb56bd6495e9439bc5945449bddf27bd690 
xpack-qemu-arm-2.8.0-7-linux-x64.tgz

90ac3421c40c05fd8ebf0925e919e02f679886e047fa0e8e1ed53cd17bc9bb5f 
xpack-qemu-arm-2.8.0-7-win32-x32.zip

aa57590576b136956d3ccad56a175c6de94864b977235b018c42ad21d7667c67 
xpack-qemu-arm-2.8.0-7-win32-x64.zip
```

## Download analytics

- GitHub [xpack-dev-tools/qemu-arm-xpack](https://github.com/xpack-dev-tools/qemu-arm-xpack/)
  * this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/qemu-arm-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/v{{ page.version }}/)
  - all releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/qemu-arm-xpack/total.svg)](https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/)
  - GNU MCU Eclipse all releases [![Github All Releases](https://img.shields.io/github/downloads/gnu-mcu-eclipse/qemu/total.svg)](https://github.com/gnu-mcu-eclipse/qemu/releases/)
  - [individual file counters](https://www.somsubhra.com/github-release-stats/?username=xpack-dev-tools&repository=qemu-arm-xpack) (grouped per release)
- xnpmjs.com [@xpack-dev-tools/qemu-arm](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/qemu-arm.svg)](https://www.npmjs.com/package/@xpack-dev-tools/qemu-arm/)

Credit to [Shields IO](https://shields.io) for the badges and to 
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats) 
for the individual file counters.
