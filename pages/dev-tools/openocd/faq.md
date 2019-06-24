---
title: FAQ
permalink: /openocd/faq/

toc: false

date: 2019-06-24 14:08:00 +0300
last_updated: 2019-06-24 14:08:00 +0300

---

### The xPack OpenOCD Frequently Asked Questions

<div class="panel-group" id="accordion">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse-1">My JTAG probe XXX is not supported, can you add it?</a>
            </h4>
        </div>
        <div id="collapse-1" class="panel-collapse collapse noCrossRef">
            <div class="panel-body">
Unfortunately not. The xPack OpenOCD is only a binary distribution of the standard source code OpenOCD, and does not intend to add new functionality. Please use the official OpenOCD <a href="http://openocd.org/discussion/" >support channels</a> to ask for new features.
            </div>
        </div>
    </div>
    <!-- /.panel -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse-2">I cannot find a connection script for my board XXX, can you add it?</a>
            </h4>
        </div>
        <div id="collapse-2" class="panel-collapse collapse noCrossRef">
            <div class="panel-body">
Unfortunately not. The xPack OpenOCD is only a binary distribution of the standard source code OpenOCD, and does not intend to add new functionality. Please use the official OpenOCD <a href="http://openocd.org/discussion/" >support channels</a> to ask for new features.
            </div>
        </div>
    </div>
    <!-- /.panel -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse-3">libusb_open failed: LIBUSB_ERROR_ACCESS</a>
            </h4>
        </div>
        <div id="collapse-3" class="panel-collapse collapse noCrossRef">
            <div class="panel-body">
You are using GNU/Linux and your user has no permission to write to USB. Please review the <a href="../install/" >install</a> page.
            </div>
        </div>
    </div>
    <!-- /.panel -->
</div>
<!-- /.panel-group -->
