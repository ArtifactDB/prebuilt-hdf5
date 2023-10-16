# Build HDF5 libraries for Python packages

Builds HDF5 libraries (version 1.12.2) so that they can be used for linking in various Python packages.
This attempts to match the build process used by [`cibuildwheel`](https://github.com/pypa/cibuildwheel):

- For `manylinux_x86_64`, we create a Docker image based on `quay.io/pypa/manylinux2014_x86_64`. 
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
- For `musllinux_x86_64`, we create a Docker image based on `quay.io/pypa/musllinux_1_1_x86_64`.
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
- For `macosx_x86_64`, we build binaries using the `macosx-11` runner.
  These binaries can be downloaded and unpacked to a location specified in `CMAKE_INSTALL_PREFIX` for `find_package()`.
- For `windows_x86_64`, we build binaries using the `windows-2019` runner.
  These binaries can be downloaded and unpacked to a location specified in `CMAKE_INSTALL_PREFIX` for `find_package()`.
