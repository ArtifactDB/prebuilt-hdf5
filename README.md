# Build HDF5 libraries for Python packages

Builds HDF5 libraries (version 1.12.2) so that they can be used for linking in various Python packages.
This attempts to match the build process used by [`cibuildwheel`](https://github.com/pypa/cibuildwheel):

- For `manylinux_x86_64`, we create a Docker image based on `quay.io/pypa/manylinux_2_34_x86_64`. 
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
  [One of the versioned images](https://github.com/ArtifactDB/prebuilt-hdf5/pkgs/container/prebuilt-hdf5%2Fmanylinux_x86_64) 
  should be used with the `CIBW_MANYLINUX_X86_64_IMAGE` option.
- For `manylinux_x86_64_legacy`, we create a Docker image based on `quay.io/pypa/manylinux2014_x86_64`. 
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
  [One of the versioned images](https://github.com/ArtifactDB/prebuilt-hdf5/pkgs/container/prebuilt-hdf5%2Fmanylinux_x86_64) 
  should be used with the `CIBW_MANYLINUX_X86_64_IMAGE` option.
- For `musllinux_x86_64`, we create a Docker image based on `quay.io/pypa/musllinux_1_2_x86_64`.
  These have HDF5 and friends installed in a standard location and should directly work with `find_package()`.
  [One of the versioned images](https://github.com/ArtifactDB/prebuilt-hdf5/pkgs/container/prebuilt-hdf5%2Fmusllinux_x86_64) 
  should be used with the `CIBW_MUSLLINUX_X86_64_IMAGE` option.
- For `macosx_x86_64`, we build binaries using the `macos-13` runner.
  The resulting tarball should be unpacked to the `installed` directory, which can then be set to `CMAKE_INSTALL_PREFIX` for `find_package()`.
- For `macosx_arm64`, we build binaries using the `macos-14` runner.
  (Not ideal, but until GitHub offers an M1/2 runner, it's the best I can do.)
  The resulting tarball should be unpacked to the `installed` directory, which can then be set to `CMAKE_INSTALL_PREFIX` for `find_package()`.
