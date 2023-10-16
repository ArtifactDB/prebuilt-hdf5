# Build HDF5 libraries for Python packages

Builds HDF5 libraries (version 1.12.2) so that they can be used for linking in various Python packages.
This attempts to match the build process used by [`cibuildwheel`](https://github.com/pypa/cibuildwheel):

- For `manylinux_x86_64`, we create a Docker image based on `quay.io/pypa/manylinux2014_x86_64`. 
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
  This should be used with the `CIBW_MANYLINUX_X86_64_IMAGE` option.
- For `musllinux_x86_64`, we create a Docker image based on `quay.io/pypa/musllinux_1_1_x86_64`.
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
  This should be used with the `CIBW_MUSLLINUX_X86_64_IMAGE` option.
- For `macosx_x86_64`, we build binaries using the `macosx-11` runner.
  The resulting tarball should be unpacked to the `installed` directory, which can then be set to `CMAKE_INSTALL_PREFIX` for `find_package()`.
- For `windows_x86_64`, we build binaries using the `windows-2019` runner.
  The resulting tarball should be unpacked to the `installed` directory, which can then be set to `CMAKE_INSTALL_PREFIX` for `find_package()`.
  Note that MSVC builds should define the [`H5_BUILT_AS_DYNAMIC_LIB` macro](https://www.hdfgroup.org/downloads/hdf5/).
