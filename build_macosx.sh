#!/bin/bash

set -e
set -u

arch=${1}

mkdir installed
install_dir=$(pwd)/installed

common="-DCMAKE_OSX_ARCHITECTURES=${arch} -DCMAKE_INSTALL_PREFIX=${install_dir}"

./setup_aec.sh "${common}"
cd libaec
cmake --install build
cd -

./setup_hdf5.sh "${common}"
cd libhdf5
cmake --install build
cd -
