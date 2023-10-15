#!/bin/bash

set -e
set -u

package_name=${1}

mkdir installs
install_dir=$(pwd)/installs

# Setting up AEC
git clone https://gitlab.dkrz.de/k202009/libaec
cd libaec
git checkout v1.0.6
cmake -S . -B build -DCPACK_PACKAGE_FILE_NAME=libaec-${package_name} -DCMAKE_INSTALL_PREFIX=${install_dir}
cmake --build build --config Release
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -

# Setting up HDF5
curl -L https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-1_12_2.tar.gz > bundle.tar.gz
tar -xf bundle.tar.gz
rm bundle.tar.gz

cwd=$(pwd)
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
  -DCPACK_PACKAGE_FILE_NAME=libhdf5-${package_name} \
  -DCMAKE_INSTALL_PREFIX=${install_dir}

cmake --build build --config Release
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -
