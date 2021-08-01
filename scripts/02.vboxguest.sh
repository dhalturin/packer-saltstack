#!/bin/bash

set -ex

curl http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso -o /opt/vbga.iso
mount /opt/vbga.iso -o loop /mnt
sh /mnt/VBoxLinuxAdditions.run force || true
modinfo vboxguest
