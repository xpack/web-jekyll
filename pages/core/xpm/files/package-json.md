---
title: package.json
permalink: /xpm/files/package.json/

date: 2019-07-02 00:36:00 +0300
last_updated: 2019-12-06 22:15:36 +0200

---

The [`package.json`](https://docs.npmjs.com/files/package.json) file is
basically the same as for npm, with some
extensions.

## The mandatory `xpack` property

To identify a npm package as an xPack, it must have an `xpack`
property, even empty:

```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "xpack": {}
}
```

Although not mandatory, it is also recommended to add an `xpack` keyword,
to help find the xPacks in the public repository.

```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "keywords": [
    "xpack",
    "..."
  ],
  "xpack": {}
}
```

## The binary xPack properties

Binary xPacks do not include the binaries, they include only URLs where
to download the binaries from, and checksums to validate the downloads.

These information are stored in the `xpack` property of `package.json`.

```json
{
  "name": "@xpack-dev-tool/openocd",
  "version": "0.10.0-12.1",
  "description": "A binary xPack with OpenOCD",
  "...": "...",
  "xpack": {
    "binaries": {
      "destination": "./.content",
      "baseUrl": "https://github.com/xpack-dev-tools/openocd/releases/download/v0.10.0-12",
      "skip": 3,
      "platforms": {
        "linux-x86": {
          "sha256": "d8267cbd463a7a7691b573f95fd920c3d7cdf59747ce2571cb334b3247265106",
          "fileName": "xpack-openocd-0.10.0-12-linux-x86.tgz"
        },
        "linux-x64": {
          "sha256": "9a601ded65cc5a8c3537f5bc8e14b2c71c01188d4cd2e5192833fcd6950e992f",
          "fileName": "xpack-openocd-0.10.0-12-linux-x64.tgz"
        },
        "darwin-x64": {
          "sha256": "bd06c5fb26ed506eb98444504d218ce759c26c09f837925f16d2981f7e2e5c08",
          "fileName": "xpack-openocd-0.10.0-12-darwin-x64.tgz"
        },
        "win32-x86": {
          "sha256": "48317eaec7ea8e100a676fc7e2d99a476760317d5a20d774c77ba7a1d2260dfc",
          "fileName": "xpack-openocd-0.10.0-12-win32-x86.zip"
        },
        "win32-x64": {
          "sha256": "96cf095435c2fbed4616a903b294d758f3b1df14c6ba36224fa05fdc7ce93c1b",
          "fileName": "xpack-openocd-0.10.0-12-win32-x64.zip"
        }
      }
    },
    "bin": {
      "openocd": "./.content/bin/openocd"
    }
  }
}
```

The supported platforms are:

- `linux-arm` - Arm GNU/Linux 32-bit (since 0.6.0)
- `linux-arm64` - Arm GNU/Linux 64-bit (since 0.6.0)
- `linux-x86` (deprecated)
- `linux-x32` - Intel GNU/Linux 32-bit (since 0.6.0)
- `linux-x64` - Intel GNU/Linux 64-bit
- `darwin-x64` - macOS 64-bit
- `win32-x86` (deprecated)
- `win32-x86` - Windows 32-bit (since 0.6.0)
- `win32-x64` - Windows 64-bit

{% include note.html content="The names are exactly the Node.js
`process.platform` and `process.arch`." %}

The files are downloaded from `<baseUrl>/<fileName>`. The common
use case is to have all files in the same folder, and in this case it is
enough to define `baseUrl` once, but it is also possible to define it
for each platform, allowing to download files from different folders/servers.

The archives are unpacked in the `destination` folder, defined as relative
to the package root folder.

To shorten the paths, a number of the initial levels are skipped (`skip`).

After the archive is unpacked, links are created in `xpacks/.bin` to each
binary. These links are defined in the `bin` section.
On Windows, where soft links to files are problematic, `.cmd`
stubs are created.

{% include important.html content="To accommodate for the `.cmd` stubs,
programs launching the executables should do this via a `cmd.exe` shell." %}

