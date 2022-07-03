---
title: xpm run
permalink: /xpm/cli/run/

redirect_from:
  - /xpm/cli/run-script/

comments: true

date: 2017-10-09 12:57:00 +0300

---

## Synopsis

```sh
xpm run [options...] [<command>] [-- <script args>]
```

Aliases:

- `run-action`
- `run-script`
- `rum`,
- `ru`

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

Before creating new processes to run the command, `xpm run` prepends
`xpacks/.bin:node_modules/.bin` to the environment `PATH`.

{% include important.html content="This has the effect that all
binaries provided by locally-installed
dependencies will take precedence to any other similar binaries
present in the PATH." %}

## Options

### Help (`--help`)

```console
$ xpm run --help

xPack manager - run package/configuration specific action
Usage: xpm run [options...] [--config <config_name>] [--dry-run]
               [<action>] [-- <action_args>]
where:
  <action>                   The name of the action/script (optional)
  <action_args>...           Extra arguments for the action (optional, multiple)

Run options:
  -c|--config <config_name>  Run the configuration specific action (optional)
  -n|--dry-run               Pretend to run the action (optional)

Common options:
  --loglevel <level>         Set log level (silent|warn|info|verbose|debug|trace)
  -s|--silent                Disable all messages (--loglevel silent)
  -q|--quiet                 Mostly quiet, warnings and errors (--loglevel warn)
  --informative              Informative (--loglevel info)
  -v|--verbose               Verbose (--loglevel verbose)
  -d|--debug                 Debug messages (--loglevel debug)
  -dd|--trace                Trace messages (--loglevel trace, -d -d)
  --no-update-notifier       Skip check for a more recent version
  -C <folder>                Set current folder

xpm -h|--help                Quick help
xpm --version                Show version
xpm -i|--interactive         Enter interactive mode

npm xpm@0.9.0 '/Users/ilg/.nvm/versions/node/v14.16.0/lib/node_modules/xpm'
Home page: <https://xpack.github.io/xpm/>
Bug reports: <https://github.com/xpack/xpm-js/issues/>
```

### Configuration (`-c|--config`)

Run actions associated with an existing configuration instead of actions
defined for the entire project.

### Dry-run (`-n|--dry-run`)

Do everything except to actually run the action.
