#!/bin/bash

set -ex

if [ $(command -v yum) ]; then
    yum update -y kernel 
    yum install -y kernel-devel kernel-headers make bzip2 perl gcc dkms

    reboot
fi

if [ $(command -v apt) ]; then
    apt update
    apt install -y --no-install-recommends linux-image-5.4.0-80-generic linux-headers-5.4.0-80-generic build-essential dkms
fi
