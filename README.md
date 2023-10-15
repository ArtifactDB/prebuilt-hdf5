# Build HDF5 libraries for Python packages

Builds HDF5 libraries (version 1.12.2) so that they can be used for linking in various Python packages.
This attempts to match the build process used by [`cibuildwheel`](https://github.com/pypa/cibuildwheel):

- For `manylinux_x86_64`, we create a Docker image based on `quay.io/pypa/manylinux2014_x86_64`. 
- For `musllinux_x86_64`, we create a Docker image based on `quay.io/pypa/musllinux_1_1_x86_64`.
- For `macosx_x86_64`, we build binaries using the `macosx-11` runner.
