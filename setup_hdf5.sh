#!/bin/bash

set -e
set -u

hdf5_options=${1:-""}

curl -L https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-1_12_2.tar.gz > bundle.tar.gz
tar -xf bundle.tar.gz
rm bundle.tar.gz

mv hdf5-hdf5-1_12_2/ libhdf5
cd libhdf5

cmake -S . -B build \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DHDF5_BUILD_EXAMPLES=OFF \
  -DHDF5_BUILD_TOOLS=OFF \
  -DHDF5_BUILD_UTILS=OFF \
  -DHDF5_BUILD_CPP_LIB=ON \
  -DHDF5_ENABLE_Z_LIB_SUPPORT=ON \
  -DHDF5_ENABLE_SZIP_SUPPORT=ON \
  -DBUILD_TESTING=OFF \
  -DUSE_LIBAEC=ON \
  ${hdf5_options}

cmake --build build
cd -
