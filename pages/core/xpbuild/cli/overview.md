---
title: xpbuild - common options
permalink: /xpbuild/cli/

comments: true

date: 2017-10-09 12:50:00 +0300
last_updated: 2019-07-04 19:09:21 +0300

---

## Synopsis

```
xpbuild [<command>] [<options> ...] [<args>...]
```

## Description


The program accepts an optional command name, 
options (that start with a dash) and possibly one or more
arguments, like names, files, etc.

The list of accepted options and arguments is specific to a given
command, or set of command and subcommands.

## Common options

### Help (`-h|--help`)

To get an initial glimpse on the program, ask for help:

```
$ xpbuild --help

...
```

This works both at top level and with commands/subcommands.

### Log level (`--loglevel`)

The default behaviour of the program is to display only a minimum
amount of messages.

This can be changed, from not displaying any messages at all (`--silent`)
to displaying lots of debugging trace messages (`--trace`).

```
  --loglevel <level>     Set log level (silent|warn|info|verbose|debug|trace) 
  -s|--silent            Disable all messages (--loglevel silent) 
  -q|--quiet             Mostly quiet, warnings and errors (--loglevel warn) 
  --informative          Informative (--loglevel info) 
  -v|--verbose           Verbose (--loglevel verbose) 
  -d|--debug             Debug messages (--loglevel debug) 
  -dd|--trace            Trace messages (--loglevel trace, -d -d) 
```

### Current folder (`-C`)

By default the program is executed in the context of the current shell 
folder, but it can be changed to any folder using `-C <folder>`.

### Program version (`--version`)

As for most command line tools, it is possible to ask for the current 
version, with `--version`:

```console
$ xpbuild --version
0.5.0
```

The result is written to the standard output stream, and consists of the
semver string, without any `v` prefix, so it can be directly used in 
automated scripts, without any post processing.

### Skip checks (`--no-update-notifier`)

By default, before exiting, xpbuild checks, once a day, if there is a 
new version of the program available.

For environments where this check is not necessary, it can be disabled.

## Commands

* [xpbuild init]({{ site.baseurl }}/xpbuild/cli/init/)
