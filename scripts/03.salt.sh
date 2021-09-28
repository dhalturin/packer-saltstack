#!/bin/bash

set -ex

curl -sL https://bootstrap.saltproject.io | sudo sh -s -- -x python3 -P stable 3003.3
