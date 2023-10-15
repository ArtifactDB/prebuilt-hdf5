#!/bin/bash

set -e
set -u

hdf5_options=${1:-""}

./setup_aec.sh
cd libaec
cmake --install build
cd -
rm -rf libaec

./setup_hdf5.sh ${hdf5_options}
cd libhdf5
cmake --install build
cd -
rm -rf libhdf5
