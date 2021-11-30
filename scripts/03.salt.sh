#!/bin/bash

set -ex

curl -sL https://bootstrap.saltproject.io | sudo sh -s -- -x python3 -P stable ${SALT_VERSION}

useradd -g sudo -s /usr/sbin/nologin -M salt

echo "user: salt" > /etc/salt/minion.d/user.conf

cat | xargs -I {} bash -c 'mkdir -p {}; chown salt: -R {}' <<EOF
/etc/salt
/srv/pillar
/srv/salt
/srv/spm
/var/cache/salt
/var/log/salt
/var/run/salt
EOF
