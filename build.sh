#!/bin/bash

set -e
set -u

output=$1 # output file name for the CPack bundle.
options=${2:-""}

mkdir -p installs

# Setting up ZLIB
wget http://zlib.net/fossils/zlib-1.3.tar.gz -O zlib.tar.gz
tar -xvf zlib.tar.gz
cd zlib-1.3
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=../installs ${options}
cmake --build build
cmake --install build
cd -

# Setting up SZIP
git clone https://gitlab.dkrz.de/k202009/libaec
cd libaec
git checkout v1.0.6
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=../installs ${options}
cmake --build build
cmake --install build
cd -

# Setting up HDF5.
wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-1_12_2.tar.gz -O bundle.tar.gz
tar -xf bundle.tar.gz
cwd=$(pwd)
mv hdf5-hdf5-1_12_2/ hdf5
cd hdf5

cmake -S . -B build \
  -DBUILD_SHARED_LIBS=OFF \
  -DHDF5_BUILD_EXAMPLES=OFF \
  -DHDF5_BUILD_TOOLS=OFF \
  -DHDF5_BUILD_UTILS=OFF \
  -DHDF5_BUILD_CPP_LIB=ON \
  -DHDF5_ENABLE_Z_LIB_SUPPORT=ON \
  -DHDF5_ENABLE_SZIP_SUPPORT=ON \
  -DBUILD_TESTING=OFF \
  -DUSE_LIBAEC=ON \
  -DZLIB_INCLUDE_DIR=${cwd}/installs/include \
  -DZLIB_LIBRARY=${cwd}/installs/lib/libz.a \
  -DSZIP_INCLUDE_DIR=${cwd}/installs/include \
  -DSZIP_LIBRARY=${cwd}/installs/lib/libsz.a \
  -DCPACK_PACKAGE_FILE_NAME=${output} \
  ${options}

cmake --build build
cpack -G TGZ --config build/CPackConfig.cmake
