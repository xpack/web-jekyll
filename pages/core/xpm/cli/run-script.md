---
title: xpm run-script
permalink: /xpm/cli/run-script/

comments: true

date: 2017-10-09 12:57:00 +0300
last_updated: 2019-12-06 22:15:36 +0200

---

## Synopsis

```
xpm run-script [options...] [<command>] [-- <script args>]
```

Aliases:
- `run`
- `rum`

## Description

This runs an arbitrary command listed in the `scripts` object
in `package.json`.

```json
{
  "name": "h1b",
  "version": "1.0.0",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "build": "xmake build -- all",
    "clean": "xmake build -- clean"
  },
  "...": "..."
}
```

Options passed after the double dash separator are not processed
but appended _as is_ at the end of the command string.

Before creating new processes to run the comman, `xpm run` prepends
`xpacks/.bin:node_modules/.bin` to the environment `PATH`.

{% include important.html content="This has the effect that all
binaries provided by locally-installed
dependencies will take precedence to any other similar binaries
present in the PATH." %}

## Options

### Help (`--help`)

```
$ xpm run-script --help

xPack manager - run package specific script
Usage: xpm run-script [options...] [<command>] [-- <script args>]
where:
  <command>             The command associated with the script (optional)
  <script args>...      Extra arguments for the script (optional, multiple)

Common options:
  --loglevel <level>    Set log level (silent|warn|info|verbose|debug|trace)
  -s|--silent           Disable all messages (--loglevel silent)
  -q|--quiet            Mostly quiet, warnings and errors (--loglevel warn)
  --informative         Informative (--loglevel info)
  -v|--verbose          Verbose (--loglevel verbose)
  -d|--debug            Debug messages (--loglevel debug)
  -dd|--trace           Trace messages (--loglevel trace, -d -d)
  --no-update-notifier  Skip check for a more recent version
  -C <folder>           Set current folder

xpm -h|--help           Quick help
xpm --version           Show version
xpm -i|--interactive    Enter interactive mode

npm xpm@0.5.0 '/Users/ilg/Library/npm/lib/node_modules/xpm'
Home page: <https://github.com/xpack/xpm-js>
Bug reports: <https://github.com/xpack/xpm-js/issues>
$
```
