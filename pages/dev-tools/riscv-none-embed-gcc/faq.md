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
`riscv-unknown-elf-gcc`; you have only one. How can you generate
32 and 64-bit code?
{% endcapture %}

{% capture answer_1 %}
All RISC-V GCC toolchains, if built correctly, are able to generate 
both 32/64-bit binaries, based on `-march` and `-mabi`.
{% endcapture %}

{% include div-panel-group.html %}
{% include faq-panel.html id="collapse-1" question=question_1 answer=answer_1 %}
{% include div-end.html %}
