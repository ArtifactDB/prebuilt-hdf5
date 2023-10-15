#!/bin/bash

set -e
set -u

arch=${1}
package_name=${2}

mkdir installs
install_dir=$(pwd)/installs

./setup_aec.sh "-DCMAKE_OSX_ARCHITECTURES=${arch} -DCPACK_PACKAGE_FILE_NAME=libaec-${package_name} -DCMAKE_INSTALL_PREFIX=${install_dir}" 
cd libaec
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -

./setup_hdf5.sh "-DCMAKE_OSX_ARCHITECTURES=${arch} -DCPACK_PACKAGE_FILE_NAME=libhdf5-${package_name} -DCMAKE_INSTALL_PREFIX=${install_dir}" 
cd libhdf5
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -
