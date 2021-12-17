#!/bin/bash

set -ex

curl -sL https://bootstrap.saltproject.io | sudo sh -s -- -x python3 -P stable ${SALT_VERSION}

cat | xargs -I {} bash -c 'mkdir -p {}; chown salt: -R {}' <<EOF
/etc/salt
/srv/pillar
/srv/salt
/srv/spm
/var/cache/salt
/var/log/salt
/var/run/salt
EOF
