#!/bin/bash

set -e
set -u

hdf5_options=${1:-""}

./setup_aec.sh "-DCMAKE_BUILD_TYPE=Release"
cd libaec
cmake --install build
cd -
rm -rf libaec

./setup_hdf5.sh "-DCMAKE_BUILD_TYPE=Release ${hdf5_options}"
cd libhdf5
cmake --install build
cd -
rm -rf libhdf5
