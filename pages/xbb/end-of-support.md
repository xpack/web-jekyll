---
title: End-of-support schedule
permalink: /xbb/end-of-support/

date: 2021-10-13 15:15:00 +0300

---

According to the
[CentOS schedule](https://en.wikipedia.org/wiki/CentOS#End-of-support_schedule),
version 6 will be supported up to Nov. 2020.

However, RHEL releases have a longer
[life cycle](https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates)
and RHEL 7 end of extended life-cycle support is 2024.

Due to maintenance issues, starting with XBB v3.1, support for CentOS/RHEL 6
was discontinued.

However support for RHEL 7 is very important, and will be preserved for
as long as possible. In practical terms, the ldd version must be
2.17 or lower.

## GNU/Linux distro versions

To better decide whch versions to support, below is a list of existing versions.

The names are in fact docker image names, and can be used directly to query
the `ldd --version`:

```sh
docker run -it <image> ldd --version
```

### [Debian](https://en.wikipedia.org/wiki/Debian_version_history)

- `debian:6` - squeeze - 2011-2016, 2.11.3, kernel 2.6.32
- `debian:7` - wheezy - 2013-2016, 2.13, kernel 3.2
- `debian:8` - jessie - 2015-2018, 2.19, kernel 3.16
- `debian:9` - stretch - 2017-2020, 2.24, kernel 4.9.0-6 (first with arm64)
- `debian:10` - buster - 2019-2022, 2.28, kernel 4.19.0-6 <-- next

### [Ubuntu](https://en.wikipedia.org/wiki/Ubuntu_version_history)

- `ubuntu:10.04` - lucy - 2010-2015, 2.11.1
- `ubuntu:12.04` - precise - 2012-2019, 2.15, kernel **3.2** <--- Intel Linux choice
- `ubuntu:14.04` - trusty - 2014-2022, 2.19, kernel 3.16
- `ubuntu:16.04` - xenial - 2016-2024, **2.23**, kernel 4.4 <--- Arm Linux choice
- `ubuntu:18.04` - bionic - 2018-2028, **2.27**, kernel 4.15 <-- **next** Intel & Arm Linux choice
- `ubuntu:20.04` - focal - 2020-2-30, 2.31, kernel 5.4

### [RHEL](https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates)

- `registry.access.redhat.com/rhel6` - 2.12 (no longer supported)
- `registry.access.redhat.com/rhel7` - 2.17, kernel 3.10 <-- still supported, but not for long
- `registry.access.redhat.com/ubi8` - 2.28, kernel 5.10 (next)

### [CentOS](https://en.wikipedia.org/wiki/CentOS)

- `centos:6` - 2011-2020, 2.12 (no longer supported)
- `centos:7` - 2014-2024, 2.17, kernel 3.10 <--- still supported, but not for long
- `centos:8` - 2019-2029, 2.28, kernel 4.18 <-- next

Last version was 8.4; discontinued by the end of 2021; see Rocky Linux.

### [Fedora](https://en.wikipedia.org/wiki/Fedora_version_history)

- `fedora:20` - 2013-12, 2.18, kernel 3.11 <-- Intel
- `fedora:21` - 2014-12, 2.20, kernel 3.17
- `fedora:22` - 2015-05, 2.21, kernel 4.0
- `fedora:23` - 2015-11, 2.22, kernel 4.2
- `fedora:24` - 2016-06, 2.23, kernel 4.5 <-- Arm
- `fedora:25` - 2016-11, 2.24, kernel 4.8
- `fedora:26` - 2017-07,
- `fedora:27` - 2017-11, 2.26, kernel 4.13
- `fedora:28` - 2018-05,
- `fedora:29` - 2018-10, 2.28, kernel 4.18 <-- (next)
- `fedora:30` - 2019-05,
- `fedora:31` - 2019-10, 2.30, kernel 5.3
- `fedora:32` - 2020-04, 2.30, kernel 5.6

## 32-bit support

Existing support for 32-bit builds will be preserved for the moment,
but might be dropped in one of the future version; for consistency
reasons, it is expected to continue to generate 32-bit binares
as long as Node.js still supports them via the
[unofficial builds](https://unofficial-builds.nodejs.org/download/)
(watch for the presence of `-linux-x86.tar.*` files).

## Conclusions

For Intel GNU/Linux, to preserve support for older distributions,
the **Ubuntu 12 (precise)** (2.15) distribution was selected;
the resulting binaries should also run on RHEL 7 or newer;
support for RHEL 6 was discontinued.

For Arm binaries, the base distribution is **Ubuntu 16.04 LTS (xenial)**,
(2.23); the resulting binaries should run on all Raspberry Pi class
machines, or larger/newer.