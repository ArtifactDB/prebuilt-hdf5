#!/bin/bash

set -e
set -u

arch=${1}
package_name=${2}

mkdir installs
install_dir=$(pwd)/installs

common="-DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_ARCHITECTURES=${arch} -DCMAKE_INSTALL_PREFIX=${install_dir}" 

./setup_aec.sh "${common} -DCPACK_PACKAGE_FILE_NAME=libaec-${package_name}" 
cd libaec
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -

./setup_hdf5.sh "${common} -DCPACK_PACKAGE_FILE_NAME=libhdf5-${package_name}"
cd libhdf5
cmake --install build
cpack -G TGZ --config build/CPackConfig.cmake
cd -
