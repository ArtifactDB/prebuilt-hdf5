FROM quay.io/pypa/manylinux2014_x86_64
WORKDIR /home/root
COPY setup* .
COPY build_linux.sh .
RUN bash build_linux.sh "-DCMAKE_INSTALL_PREFIX=/usr/local"
CMD ["/bin/bash"]
