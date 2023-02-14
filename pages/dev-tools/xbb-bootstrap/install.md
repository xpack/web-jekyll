---
title: How to install the xPack XBB Bootstrap binaries
permalink: /dev-tools/xbb-bootstrap/install/

summary: "The recommended method is via xpm."

version: "4.0"
xpack-subversion: "0"
version-major-minor: "4.0"

comments: true
toc: false

date: 2022-10-04 10:32:00 +0300

---

## Overview

The **xPack XBB Bootstrap** can be installed automatically, via `xpm` (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install XBB Bootstrap is by using the **binary xPack**, available as
[`@xpack-dev-tools/xbb-bootstrap`](https://www.npmjs.com/package/@xpack-dev-tools/xbb-bootstrap)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent
xpm, which is a portable
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

### Install

With xpm available, installing
the latest version of the package is quite easy:

```sh
xpm install --global @xpack-dev-tools/xbb-bootstrap@latest --verbose
```

This command will always install the latest available version,
in the global xPacks store, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

{% capture include_1 %}
The install location can be configured using the
`XPACKS_STORE_FOLDER` environment variable; for more details please check the
[xpm folders]({{ site.baseurl }}/xpm/folders/) page.
{% endcapture %}

{% include tip.html content=include_1 %}

{% include tip.html content="The archive content is unpacked into a folder
named `.content`. On some platforms
this might be hidden for normal browsing, and require
separate options (like `ls -A`) or, in file browsers, to enable
settings like **Show Hidden Files**." %}

### Uninstall

To remove the installed xPack, the command is similar:

```sh
xpm uninstall --global @xpack-dev-tools/xbb-bootstrap --verbose
```

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack XBB Bootstrap** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/xbb-bootstrap-xpack/releases/)
page.

{% endcapture %}

{% capture windows %}

Binaries are available only for GNU/Linux and macOS.

{% endcapture %}

{% capture macos %}

{{ easy_install }}

### Test

To check if the xpm installed XBB Bootstrap binaries start, use something like:

```console
$ ~/.local/xPacks/@xpack-dev-tools/xbb-bootstrap/{{ page.version }}.{{ page.xpack-subversion }}/.content/bin/pkg_config --version
0.29.2
```

{{ manual_install }}

### Download

The macOS versions of **xPack XBB Bootstrap**
are packed as `.tar.gz` archives.
Download the latest version named like:

- `xpack-xbb-bootstrap-{{ page.version }}-darwin-x64.tar.gz`
- `xpack-xbb-bootstrap-{{ page.version }}-darwin-arm64.tar.gz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.

### Unpack

To manually install the xPack XBB Bootstrap,
unpack the archive and move it to
`~/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}`:

```console
mkdir -p ~/.local/xPacks/xbb-bootstrap
cd ~/.local/xPacks/xbb-bootstrap

tar xvf ~/Downloads/xpack-xbb-bootstrap-{{ page.version }}-linux-x64.tar.gz
chmod -R -w xpack-xbb-bootstrap-{{ page.version }}
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

```console
$ tree -L 2 '/home/ilg/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}-{{ page.xpack-subversion }}'
/home/ilg/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}-{{ page.xpack-subversion }}/
├── README.md
├── bin
│   ├── 2to3-3.9
│   ├── 7z
│   ├── 7za
│   ├── 7zr
│   ├── [
│   ├── asn1Coding
│   ├── asn1Decoding
│   ├── asn1Parser
│   ├── awk -> gawk
│   ├── b2sum
│   ├── base32
│   ├── base64
│   ├── basename
│   ├── basenc
│   ├── bash
│   ├── bashbug
│   ├── bison
│   ├── bunzip2
│   ├── bzcat
│   ├── bzcmp -> bzdiff
│   ├── bzdiff
│   ├── bzegrep -> bzgrep
│   ├── bzfgrep -> bzgrep
│   ├── bzgrep
│   ├── bzip2
│   ├── bzip2recover
│   ├── bzless -> bzmore
│   ├── bzmore
│   ├── c_rehash
│   ├── captoinfo -> tic
│   ├── cat
│   ├── certtool
│   ├── chcon
│   ├── chgrp
│   ├── chmod
│   ├── chown
│   ├── chroot
│   ├── cksum
│   ├── clear
│   ├── cmp
│   ├── comm
│   ├── corelist
│   ├── cp
│   ├── cpan
│   ├── cpanm
│   ├── csplit
│   ├── curl
│   ├── curl-config
│   ├── cut
│   ├── date
│   ├── dd
│   ├── df
│   ├── diff
│   ├── diff3
│   ├── dir
│   ├── dircolors
│   ├── dirmngr
│   ├── dirmngr-client
│   ├── dirname
│   ├── dos2unix
│   ├── du
│   ├── echo
│   ├── ed2k-link -> rhash
│   ├── edonr256-hash -> rhash
│   ├── edonr512-hash -> rhash
│   ├── enc2xs
│   ├── encguess
│   ├── env
│   ├── envsubst
│   ├── expand
│   ├── expr
│   ├── factor
│   ├── false
│   ├── flex
│   ├── flex++ -> flex
│   ├── fmt
│   ├── fold
│   ├── gawk
│   ├── gawk-5.1.1
│   ├── gettext
│   ├── gettext.sh
│   ├── gm4 -> m4
│   ├── gmake
│   ├── gnutar -> tar
│   ├── gnutls-cli
│   ├── gnutls-cli-debug
│   ├── gnutls-serv
│   ├── gost12-256-hash -> rhash
│   ├── gost12-512-hash -> rhash
│   ├── gpg
│   ├── gpg-agent
│   ├── gpg-card
│   ├── gpg-connect-agent
│   ├── gpg-wks-client
│   ├── gpg-wks-server
│   ├── gpgconf
│   ├── gpgparsemail
│   ├── gpgscm
│   ├── gpgsm
│   ├── gpgsplit
│   ├── gpgtar
│   ├── gpgv
│   ├── groups
│   ├── gsed -> sed
│   ├── h2ph
│   ├── h2xs
│   ├── has160-hash -> rhash
│   ├── head
│   ├── hostid
│   ├── iconv
│   ├── id
│   ├── idle3.9
│   ├── info
│   ├── infocmp
│   ├── infotocap -> tic
│   ├── install
│   ├── install-info
│   ├── instmodsh
│   ├── join
│   ├── json_pp
│   ├── kbxutil
│   ├── kill
│   ├── libnetcfg
│   ├── link
│   ├── ln
│   ├── logname
│   ├── ls
│   ├── lzcat -> xz
│   ├── lzcmp -> xzdiff
│   ├── lzdiff -> xzdiff
│   ├── lzegrep -> xzgrep
│   ├── lzfgrep -> xzgrep
│   ├── lzgrep -> xzgrep
│   ├── lzless -> xzless
│   ├── lzma -> xz
│   ├── lzmadec
│   ├── lzmainfo
│   ├── lzmore -> xzmore
│   ├── m4
│   ├── mac2unix -> dos2unix
│   ├── magnet-link -> rhash
│   ├── make -> gmake
│   ├── makedepend
│   ├── makeinfo
│   ├── md5sum
│   ├── mkdir
│   ├── mkfifo
│   ├── mknod
│   ├── mktemp
│   ├── mv
│   ├── ncurses6-config
│   ├── ngettext
│   ├── nice
│   ├── nl
│   ├── nohup
│   ├── nproc
│   ├── numfmt
│   ├── ocsptool
│   ├── od
│   ├── openssl
│   ├── paste
│   ├── patch
│   ├── patchelf
│   ├── pathchk
│   ├── pdftexi2dvi
│   ├── perl
│   ├── perl5.34.0
│   ├── perlbug
│   ├── perldoc
│   ├── perlivp
│   ├── perlthanks
│   ├── piconv
│   ├── pinky
│   ├── pkg-config
│   ├── pkg-config-verbose
│   ├── pl2pm
│   ├── pod2html
│   ├── pod2man
│   ├── pod2texi
│   ├── pod2text
│   ├── pod2usage
│   ├── podchecker
│   ├── pr
│   ├── printenv
│   ├── printf
│   ├── prove
│   ├── psktool
│   ├── ptar
│   ├── ptardiff
│   ├── ptargrep
│   ├── ptx
│   ├── pwd
│   ├── pydoc3.9
│   ├── python3 -> python3.9
│   ├── python3.9
│   ├── python3.9-config
│   ├── re2c
│   ├── re2go
│   ├── readlink
│   ├── realpath
│   ├── reset -> tset
│   ├── rhash
│   ├── rm
│   ├── rmdir
│   ├── runcon
│   ├── sdiff
│   ├── sed
│   ├── seq
│   ├── sfv-hash -> rhash
│   ├── sha1sum
│   ├── sha224sum
│   ├── sha256sum
│   ├── sha384sum
│   ├── sha512sum
│   ├── shasum
│   ├── shred
│   ├── shuf
│   ├── sleep
│   ├── sort
│   ├── splain
│   ├── split
│   ├── sqlite3
│   ├── sqlite3_analyzer
│   ├── srptool
│   ├── stat
│   ├── stdbuf
│   ├── streamzip
│   ├── stty
│   ├── sum
│   ├── sync
│   ├── tabs
│   ├── tac
│   ├── tail
│   ├── tar
│   ├── tclsh8.6
│   ├── tee
│   ├── test
│   ├── texi2any
│   ├── texi2dvi
│   ├── texi2pdf
│   ├── texindex
│   ├── tic
│   ├── tiger-hash -> rhash
│   ├── timeout
│   ├── toe
│   ├── touch
│   ├── tput
│   ├── tr
│   ├── true
│   ├── truncate
│   ├── tset
│   ├── tsort
│   ├── tth-hash -> rhash
│   ├── tty
│   ├── uname
│   ├── unexpand
│   ├── uniq
│   ├── unix2dos
│   ├── unix2mac -> unix2dos
│   ├── unlink
│   ├── unlzma -> xz
│   ├── unxz -> xz
│   ├── uptime
│   ├── users
│   ├── vdir
│   ├── watchgnupg
│   ├── wc
│   ├── wget
│   ├── whirlpool-hash -> rhash
│   ├── who
│   ├── whoami
│   ├── xml2-config
│   ├── xmlcatalog
│   ├── xmllint
│   ├── xsubpp
│   ├── xz
│   ├── xzcat -> xz
│   ├── xzcmp -> xzdiff
│   ├── xzdec
│   ├── xzdiff
│   ├── xzegrep -> xzgrep
│   ├── xzfgrep -> xzgrep
│   ├── xzgrep
│   ├── xzless
│   ├── xzmore
│   ├── yacc
│   ├── yes
│   └── zipdetails
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── etc
│   ├── profile.d
│   ├── rhashrc
│   └── wgetrc
├── include
│   └── python3.9
├── lib
│   ├── bash
│   ├── libpython3.9.dylib
│   ├── perl5
│   ├── pkgconfig
│   ├── python3.9
│   ├── tcl8
│   └── tcl8.6
├── libexec
│   ├── awk
│   ├── coreutils
│   ├── dirmngr_ldap
│   ├── gpg-check-pattern
│   ├── gpg-pair-tool
│   ├── gpg-preset-passphrase
│   ├── gpg-protect-tool
│   ├── gpg-wks-client
│   ├── keyboxd
│   ├── libassuan.0.dylib
│   ├── libbz2.1.0.8.dylib
│   ├── libcrypt.2.dylib
│   ├── libcrypto.1.1.dylib
│   ├── libcurl.4.dylib
│   ├── libexpat.1.8.1.dylib
│   ├── libexpat.1.dylib -> libexpat.1.8.1.dylib
│   ├── libffi.8.dylib
│   ├── libgc.1.dylib
│   ├── libgcc_s.1.dylib
│   ├── libgcrypt.20.dylib
│   ├── libgmp.10.dylib
│   ├── libgnutls.30.dylib
│   ├── libgpg-error.0.dylib
│   ├── libguile-2.2.1.dylib
│   ├── libhistory.8.1.dylib
│   ├── libhistory.8.dylib -> libhistory.8.1.dylib
│   ├── libhogweed.6.4.dylib
│   ├── libhogweed.6.dylib -> libhogweed.6.4.dylib
│   ├── libiconv.2.dylib
│   ├── libksba.8.dylib
│   ├── libltdl.7.dylib
│   ├── liblzma.5.dylib
│   ├── libmpfr.6.dylib
│   ├── libncurses.6.dylib
│   ├── libnettle.8.4.dylib
│   ├── libnettle.8.dylib -> libnettle.8.4.dylib
│   ├── libnpth.0.dylib
│   ├── libopts.25.dylib
│   ├── libpanel.6.dylib
│   ├── libpython3.9.dylib
│   ├── libreadline.8.1.dylib
│   ├── libreadline.8.dylib -> libreadline.8.1.dylib
│   ├── librhash.0.dylib
│   ├── libsqlite3.0.dylib
│   ├── libssl.1.1.dylib
│   ├── libtasn1.6.dylib
│   ├── libtcl8.6.dylib
│   ├── libunistring.2.dylib
│   ├── libxml2.2.dylib
│   ├── libz.1.2.11.dylib
│   ├── libz.1.dylib -> libz.1.2.11.dylib
│   └── scdaemon
├── sbin
│   ├── addgnupghome
│   └── applygnupgdefaults
└── share
    ├── aclocal
    ├── awk
    ├── bison
    ├── gettext
    ├── gnupg
    ├── gtk-doc
    ├── locale
    ├── pkgconfig
    ├── re2c
    ├── readline
    ├── tabset
    ├── texinfo
    └── util-macros

34 directories, 345 files
ilg@wksi .content %
```

### Test

To check if the manually installed XBB Bootstrap starts, use something like:

```console
$ ~/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}/bin/pkg_config --version
0.29.2
```

{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed XBB Bootstrap binaries start, use something like:

```console
$ ~/.local/xPacks/@xpack-dev-tools/xbb-bootstrap/{{ page.version }}.{{ page.xpack-subversion }}/.content/bin/pkg_config --version
0.29.2
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack XBB Bootstrap**
are packed as `.tar.gz` archives.
Download the latest version named like:

- `xpack-xbb-bootstrap-{{ page.version }}-linux-x64.tar.gz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.

### Unpack

To manually install the xPack XBB Bootstrap,
unpack the archive and move it to
`~/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}`:

```console
mkdir -p ~/.local/xPacks/xbb-bootstrap
cd ~/.local/xPacks/xbb-bootstrap

tar xvf ~/Downloads/xpack-xbb-bootstrap-{{ page.version }}-linux-x64.tar.gz
chmod -R -w xpack-xbb-bootstrap-{{ page.version }}
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

```console
$ tree -L 2 '/home/ilg/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}-{{ page.xpack-subversion }}'
/home/ilg/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}-{{ page.xpack-subversion }}/
├── bin
│   ├── [
│   ├── 2to3-3.9
│   ├── 7z
│   ├── 7za
│   ├── 7zr
│   ├── asn1Coding
│   ├── asn1Decoding
│   ├── asn1Parser
│   ├── awk -> gawk
│   ├── b2sum
│   ├── base32
│   ├── base64
│   ├── basename
│   ├── basenc
│   ├── bash
│   ├── bashbug
│   ├── bison
│   ├── bunzip2
│   ├── bzcat
│   ├── bzcmp -> bzdiff
│   ├── bzdiff
│   ├── bzegrep -> bzgrep
│   ├── bzfgrep -> bzgrep
│   ├── bzgrep
│   ├── bzip2
│   ├── bzip2recover
│   ├── bzless -> bzmore
│   ├── bzmore
│   ├── captoinfo -> tic
│   ├── cat
│   ├── certtool
│   ├── chcon
│   ├── chgrp
│   ├── chmod
│   ├── chown
│   ├── chroot
│   ├── cksum
│   ├── clear
│   ├── cmp
│   ├── comm
│   ├── corelist
│   ├── cp
│   ├── cpan
│   ├── cpanm
│   ├── c_rehash
│   ├── csplit
│   ├── curl
│   ├── curl-config
│   ├── cut
│   ├── date
│   ├── dd
│   ├── df
│   ├── diff
│   ├── diff3
│   ├── dir
│   ├── dircolors
│   ├── dirmngr
│   ├── dirmngr-client
│   ├── dirname
│   ├── dos2unix
│   ├── du
│   ├── echo
│   ├── ed2k-link -> rhash
│   ├── edonr256-hash -> rhash
│   ├── edonr512-hash -> rhash
│   ├── enc2xs
│   ├── encguess
│   ├── env
│   ├── envsubst
│   ├── expand
│   ├── expr
│   ├── factor
│   ├── false
│   ├── flex
│   ├── flex++ -> flex
│   ├── fmt
│   ├── fold
│   ├── gawk
│   ├── gawk-5.1.1
│   ├── gettext
│   ├── gettext.sh
│   ├── gm4 -> m4
│   ├── gmake
│   ├── gnutar -> tar
│   ├── gnutls-cli
│   ├── gnutls-cli-debug
│   ├── gnutls-serv
│   ├── gost12-256-hash -> rhash
│   ├── gost12-512-hash -> rhash
│   ├── gpg
│   ├── gpg-agent
│   ├── gpg-card
│   ├── gpgconf
│   ├── gpg-connect-agent
│   ├── gpgparsemail
│   ├── gpgscm
│   ├── gpgsm
│   ├── gpgsplit
│   ├── gpgtar
│   ├── gpgv
│   ├── gpg-wks-client
│   ├── gpg-wks-server
│   ├── groups
│   ├── gsed -> sed
│   ├── h2ph
│   ├── h2xs
│   ├── has160-hash -> rhash
│   ├── head
│   ├── hostid
│   ├── iconv
│   ├── id
│   ├── idle3.9
│   ├── info
│   ├── infocmp
│   ├── infotocap -> tic
│   ├── install
│   ├── install-info
│   ├── instmodsh
│   ├── join
│   ├── json_pp
│   ├── kbxutil
│   ├── kill
│   ├── libnetcfg
│   ├── link
│   ├── ln
│   ├── logname
│   ├── ls
│   ├── lzcat -> xz
│   ├── lzcmp -> xzdiff
│   ├── lzdiff -> xzdiff
│   ├── lzegrep -> xzgrep
│   ├── lzfgrep -> xzgrep
│   ├── lzgrep -> xzgrep
│   ├── lzless -> xzless
│   ├── lzma -> xz
│   ├── lzmadec
│   ├── lzmainfo
│   ├── lzmore -> xzmore
│   ├── m4
│   ├── mac2unix -> dos2unix
│   ├── magnet-link -> rhash
│   ├── make -> gmake
│   ├── makedepend
│   ├── makeinfo
│   ├── md5sum
│   ├── mkdir
│   ├── mkfifo
│   ├── mknod
│   ├── mktemp
│   ├── mv
│   ├── ncurses6-config
│   ├── ngettext
│   ├── nice
│   ├── nl
│   ├── nohup
│   ├── nproc
│   ├── numfmt
│   ├── ocsptool
│   ├── od
│   ├── openssl
│   ├── paste
│   ├── patch
│   ├── patchelf
│   ├── pathchk
│   ├── pdftexi2dvi
│   ├── perl
│   ├── perl5.34.0
│   ├── perlbug
│   ├── perldoc
│   ├── perlivp
│   ├── perlthanks
│   ├── piconv
│   ├── pinky
│   ├── pkg-config
│   ├── pkg-config-verbose
│   ├── pl2pm
│   ├── pod2html
│   ├── pod2man
│   ├── pod2texi
│   ├── pod2text
│   ├── pod2usage
│   ├── podchecker
│   ├── pr
│   ├── printenv
│   ├── printf
│   ├── prove
│   ├── psktool
│   ├── ptar
│   ├── ptardiff
│   ├── ptargrep
│   ├── ptx
│   ├── pwd
│   ├── pydoc3.9
│   ├── python3 -> python3.9
│   ├── python3.9
│   ├── python3.9-config
│   ├── re2c
│   ├── re2go
│   ├── readlink
│   ├── realpath
│   ├── reset -> tset
│   ├── rhash
│   ├── rm
│   ├── rmdir
│   ├── runcon
│   ├── sdiff
│   ├── sed
│   ├── seq
│   ├── sfv-hash -> rhash
│   ├── sha1sum
│   ├── sha224sum
│   ├── sha256sum
│   ├── sha384sum
│   ├── sha512sum
│   ├── shasum
│   ├── shred
│   ├── shuf
│   ├── sleep
│   ├── sort
│   ├── splain
│   ├── split
│   ├── sqlite3
│   ├── sqlite3_analyzer
│   ├── srptool
│   ├── stat
│   ├── stdbuf
│   ├── streamzip
│   ├── stty
│   ├── sum
│   ├── sync
│   ├── tabs
│   ├── tac
│   ├── tail
│   ├── tar
│   ├── tclsh8.6
│   ├── tee
│   ├── test
│   ├── texi2any
│   ├── texi2dvi
│   ├── texi2pdf
│   ├── texindex
│   ├── tic
│   ├── tiger-hash -> rhash
│   ├── timeout
│   ├── toe
│   ├── touch
│   ├── tput
│   ├── tr
│   ├── true
│   ├── truncate
│   ├── tset
│   ├── tsort
│   ├── tth-hash -> rhash
│   ├── tty
│   ├── uname
│   ├── unexpand
│   ├── uniq
│   ├── unix2dos
│   ├── unix2mac -> unix2dos
│   ├── unlink
│   ├── unlzma -> xz
│   ├── unxz -> xz
│   ├── uptime
│   ├── users
│   ├── vdir
│   ├── watchgnupg
│   ├── wc
│   ├── wget
│   ├── whirlpool-hash -> rhash
│   ├── who
│   ├── whoami
│   ├── xml2-config
│   ├── xmlcatalog
│   ├── xmllint
│   ├── xsubpp
│   ├── xz
│   ├── xzcat -> xz
│   ├── xzcmp -> xzdiff
│   ├── xzdec
│   ├── xzdiff
│   ├── xzegrep -> xzgrep
│   ├── xzfgrep -> xzgrep
│   ├── xzgrep
│   ├── xzless
│   ├── xzmore
│   ├── yacc
│   ├── yes
│   └── zipdetails
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── etc
│   ├── profile.d
│   ├── rhashrc
│   └── wgetrc
├── include
│   └── python3.9
├── lib
│   ├── bash
│   ├── libpython3.9.so -> libpython3.9.so.1.0
│   ├── libpython3.9.so.1.0
│   ├── libpython3.so
│   ├── perl5
│   ├── pkgconfig
│   ├── python3.9
│   ├── tcl8
│   └── tcl8.6
├── libexec
│   ├── awk
│   ├── coreutils
│   ├── gpg-check-pattern
│   ├── gpg-pair-tool
│   ├── gpg-preset-passphrase
│   ├── gpg-protect-tool
│   ├── gpg-wks-client
│   ├── keyboxd
│   ├── libassuan.so.0 -> libassuan.so.0.8.5
│   ├── libassuan.so.0.8.5
│   ├── libcrypto.so.1.1
│   ├── libcrypt.so.2 -> libcrypt.so.2.0.0
│   ├── libcrypt.so.2.0.0
│   ├── libcurl.so.4 -> libcurl.so.4.7.0
│   ├── libcurl.so.4.7.0
│   ├── libexpat.so.1 -> libexpat.so.1.8.1
│   ├── libexpat.so.1.8.1
│   ├── libffi.so.8 -> libffi.so.8.1.0
│   ├── libffi.so.8.1.0
│   ├── libgcc_s.so.1
│   ├── libgcrypt.so.20 -> libgcrypt.so.20.3.4
│   ├── libgcrypt.so.20.3.4
│   ├── libgc.so.1 -> libgc.so.1.4.4
│   ├── libgc.so.1.4.4
│   ├── libgmp.so.10 -> libgmp.so.10.4.1
│   ├── libgmp.so.10.4.1
│   ├── libgnutls.so.30 -> libgnutls.so.30.30.0
│   ├── libgnutls.so.30.30.0
│   ├── libgpg-error.so.0 -> libgpg-error.so.0.32.0
│   ├── libgpg-error.so.0.32.0
│   ├── libguile-2.2.so.1 -> libguile-2.2.so.1.4.2
│   ├── libguile-2.2.so.1.4.2
│   ├── libhistory.so.8 -> libhistory.so.8.1
│   ├── libhistory.so.8.1
│   ├── libhogweed.so.6 -> libhogweed.so.6.4
│   ├── libhogweed.so.6.4
│   ├── libiconv.so.2 -> libiconv.so.2.6.1
│   ├── libiconv.so.2.6.1
│   ├── libksba.so.8 -> libksba.so.8.14.0
│   ├── libksba.so.8.14.0
│   ├── libltdl.so.7 -> libltdl.so.7.3.1
│   ├── libltdl.so.7.3.1
│   ├── liblzma.so.5 -> liblzma.so.5.2.5
│   ├── liblzma.so.5.2.5
│   ├── libmpfr.so.6 -> libmpfr.so.6.1.0
│   ├── libmpfr.so.6.1.0
│   ├── libncurses.so.6 -> libncurses.so.6.2
│   ├── libncurses.so.6.2
│   ├── libnettle.so.8 -> libnettle.so.8.4
│   ├── libnettle.so.8.4
│   ├── libnpth.so.0 -> libnpth.so.0.1.2
│   ├── libnpth.so.0.1.2
│   ├── libnsl-2.27.so
│   ├── libnsl.so.1 -> libnsl-2.27.so
│   ├── libopts.so.25 -> libopts.so.25.17.1
│   ├── libopts.so.25.17.1
│   ├── libpanel.so.6 -> libpanel.so.6.2
│   ├── libpanel.so.6.2
│   ├── libreadline.so.8 -> libreadline.so.8.1
│   ├── libreadline.so.8.1
│   ├── libresolv-2.27.so
│   ├── libresolv.so.2 -> libresolv-2.27.so
│   ├── librhash.so.0
│   ├── libsqlite3.so.0 -> libsqlite3.so.0.8.6
│   ├── libsqlite3.so.0.8.6
│   ├── libssl.so.1.1
│   ├── libstdc++.so.6 -> libstdc++.so.6.0.29
│   ├── libstdc++.so.6.0.29
│   ├── libtasn1.so.6 -> libtasn1.so.6.6.2
│   ├── libtasn1.so.6.6.2
│   ├── libtcl8.6.so
│   ├── libunistring.so.2 -> libunistring.so.2.1.0
│   ├── libunistring.so.2.1.0
│   ├── libxml2.so.2 -> libxml2.so.2.10.2
│   ├── libxml2.so.2.10.2
│   ├── libz.so.1 -> libz.so.1.2.11
│   ├── libz.so.1.2.11
│   ├── rmt
│   └── scdaemon
├── README.md
├── sbin
│   ├── addgnupghome
│   └── applygnupgdefaults
└── share
    ├── aclocal
    ├── awk
    ├── bison
    ├── gettext
    ├── gnupg
    ├── gtk-doc
    ├── locale
    ├── pkgconfig
    ├── re2c
    ├── readline
    ├── tabset
    ├── texinfo
    └── util-macros

34 directories, 374 files
```

### Test

To check if the manually installed XBB Bootstrap starts, use something like:

```console
$ ~/.local/xPacks/xbb-bootstrap/xpack-xbb-bootstrap-{{ page.version }}/bin/pkg_config --version
0.29.2
```

{% endcapture %}

{% include platform-tabs.html %}
