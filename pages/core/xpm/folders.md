---
title: xpm folders
permalink: /xpm/folders/

redirect_from:
  - /xpm/files/folders/

date: 2017-10-09 14:14:00 +0300
last_updated: 2019-06-28 11:32:00 +0300

---

TBD

## Environment

* `XPACKS_REPO_FOLDER`
* `XPACKS_CACHE_FOLDER`
* `XPACKS_SYSTEM_FOLDER`

## macOS

Global (home) install:

* `${HOME}/Library/xPacks`
* `${HOME}/Library/Caches/xPacks`

System install (not implemented):

* `/opt/xPacks` with 
* links in `/usr/local/bin` (normally in `PATH`)

## GNU/Linux

Global (home) install:

* `${HOME}/opt/xPacks`
* `${HOME}/.cache/xPacks`

System install (not implemented):

* `/opt/xPacks` 
* links in `/usr/local/bin` (normally in `PATH`)

## Windows

Global (home) install:

* `%APPDATA%\xPacks` (`C:\Users\ilg\AppData\Roaming\xPacks`)
* `%LOCALAPPDATA%\Caches\xPacks` (`C:\Users\ilg\AppData\Local\Caches\xPacks`)

System install (not implemented):

* `%ProgramFiles%\xPacks` (`C:\Program Files\xPacks`)
* links in `%ProgramFiles%\xPacks\.bin`, which must be added to the `Path`

## The xPacks folder

Individual packages are stored as separate folders:

* `[@<scope>/]<name>/<version>`

The `xpm link` inside a local package produces a symbolic link from 
the local package folder to something like:

* `[@<scope>/]<name>/link`

## The cache folder

The cache folder is used to store downloaded archives, to avoid 
downloading them again if referred in other packages.

Further downloads performed by the xPacks should also cache files 
here (like toolchain binaries).
