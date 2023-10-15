#!/bin/bash

set -e
set -u

aec_options=${1:-""}

git clone https://gitlab.dkrz.de/k202009/libaec
cd libaec
git checkout v1.0.6
cmake -S . -B build \
    ${aec_options}
cmake --build build
cd -
