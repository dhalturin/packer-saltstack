#!/bin/bash

set -ex

if [ $(command -v yum) ]; then
    yum update -y kernel 
    yum install -y kernel-devel kernel-headers make bzip2 perl gcc dkms

    reboot
fi

if [ $(command -v apt) ]; then
    apt install -y --no-install-recommends build-essential dkms
fi
