FROM quay.io/pypa/manylinux_2_34_x86_64
WORKDIR /home/root
RUN echo "/usr/local/lib64" | tee -a /etc/ld.so.conf.d/00-manylinux.conf
RUN ldconfig
COPY setup* .
COPY build_linux.sh .
RUN bash build_linux.sh "-DCMAKE_INSTALL_PREFIX=/usr/local"
CMD ["/bin/bash"]
