---
title: xpm folders
permalink: /xpm/folders/

redirect_from:
  - /xpm/files/folders/

date: 2017-10-09 14:14:00 +0300
last_updated: 2020-07-31 20:16:27 +0300

---

The locations of folders used by xmp can be controlled by several environment
variables.

Please note that when the variables must be available in GUI applications,
setting them in shell init scripts is not effective, since the windows manager
usually is not started by a shell, but by other system mechanism, which has
its own configuration files.

## Environment

* `XPACKS_REPO_FOLDER`
* `XPACKS_CACHE_FOLDER`
* `XPACKS_SYSTEM_FOLDER`

## macOS

Global (home) install:

* `${HOME}/Library/xPacks`
* `${HOME}/Library/Caches/xPacks`

System install (not implemented yet):

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

## Setting session wide environment variables

{% capture windows %}
To define session wide environment variables on Windows 10, use the 
Control Panel and add the variables.

TODO: find out commands to do this in a terminal.

{% endcapture %}

{% capture macos %}
To define session wide environment variables on recent macOS systems,
define a User Agent that will issue the `launchctl setenv` command.

Create a special `environment.plist` file in the users home directory,
for example in `~/Library/LaunchAgents/`:

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">

<plist version="1.0">
<dict>
 <key>Label</key>
 <string>my.variables</string>
 <key>ProgramArguments</key>
 <array>
  <string>sh</string>
  <string>-c</string>
  <string>launchctl setenv XPACKS_REPO_FOLDER /Users/myself/location/xpacks</string>
 </array>
 <key>RunAtLoad</key>
 <true/>
</dict>
</plist>
```

To activate this, run

```console
launchctl load ~/Library/LaunchAgents/environment.plist
launchctl start ~/Library/LaunchAgents/environment.plist
```

Logout and login.

The new variable should be in the environment, and available to
all applications, all shells, etc.

TODO: check if this definition is limited to a user.

Links:

- https://www.launchd.info
- https://support.apple.com/en-in/guide/terminal/apdc6c1077b-5d5d-4d35-9c19-60f2397b2369/mac
- https://support.shotgunsoftware.com/hc/en-us/articles/219042108

{% endcapture %}

{% capture linux %}
TODO: find out how this can be done on Linux.

{% endcapture %}

{% include platform-tabs.html %}
