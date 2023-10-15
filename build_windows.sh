#!/bin/bash

set -e
set -u

package_name=${1}

mkdir installs
install_dir=$(pwd)/installs

common="--config Release -DCMAKE_INSTALL_PREFIX=${install_dir}" 

./setup_aec.sh "-DCPACK_PACKAGE_FILE_NAME=libaec-${package_name} ${common}"
cd libaec
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -

./setup_hdf5.sh "-DCPACK_PACKAGE_FILE_NAME=libhdf5-${package_name} ${common}"
cd libhdf5
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -
