---
title: The xPack GNU RISC-V Embedded GCC Frequently Asked Questions
permalink: /riscv-none-embed-gcc/faq/

toc: false
comments: true

date: 2019-07-10 17:53:00 +0300
last_updated: 2019-07-10 20:23:45 +0300

---

<br/>

{% capture question_1 %}
There are two RISC-V toolchains, `riscv64-unknown-elf-gcc` and 
`riscv32-unknown-elf-gcc`; you have only one. How can you generate
32 and 64-bit code?
{% endcapture %}

{% capture answer_1 %}
All RISC-V GCC toolchains, if built correctly, are able to generate 
both 32/64-bit code, based on `-march` and `-mabi`. Thus a single 
version is enough for all use cases.
{% endcapture %}

{% capture question_2 %}
Why `riscv-none-embed-gcc` and not `riscv-unknown-elf-gcc`?
{% endcapture %}

{% capture answer_2 %}
For the moment the official RISC-V so called _embedded_ toolchain is still
more focused on running applications on emulators, more than on bare-metal
platforms. 
Those emulated environments use system traps to communicate with the host, 
thus the `libgloss` library is implemented to terminate all POSIX system 
calls with
`ECALL`, using a Unix-like API. These calls fail on a bare-metal platform,
since there is no `ECALL` exception handler. To make things worse, the 
official RISC-V 
toolchain mandated the linker to include `libgloss` and there is no easy
way to remove it.

The xPack GNU RISC-V Embedded GCC does not include `libgloss` in the builds;
to differentiate between them, the prefix was changed, to make it closer
to embedded use case. 
{% endcapture %}

{% capture question_3 %}
Why `riscv-none-embed-gcc` and not `riscv-none-eabi-gcc`, as ARM uses?
{% endcapture %}

{% capture answer_3 %}
For the moment RISC-V does not define an EABI (Embedded ABI) and uses the
same Unix ABI for embedded applications too, thus `-eabi-` would not be 
accurate.
{% endcapture %}

{% include div-panel-group.html %}
{% include faq-panel.html id="collapse-1" question=question_1 answer=answer_1 %}
{% include faq-panel.html id="collapse-2" question=question_2 answer=answer_2 %}
{% include faq-panel.html id="collapse-3" question=question_3 answer=answer_3 %}
{% include div-end.html %}
