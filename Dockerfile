FROM wirepas/sdk-builder:v1.5

# Define argument for non-root user
ARG user=wirepas

# Install Clang-format 18, cppcheck requirements, and git
USER root
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        wget \
        build-essential \
        cmake \
        curl \
        libpcre3 \
        libpcre3-dev \
        libtinyxml2-6a \
        gnupg && \
    wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-18 main" > /etc/apt/sources.list.d/llvm-toolchain-focal.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        clang-format-18 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and extract Cppcheck 2.7 source code
RUN curl -sSL https://github.com/danmar/cppcheck/archive/2.7.tar.gz | tar xz && \
    mv cppcheck-2.7 /home/${user}/cppcheck

# Build and install Cppcheck
WORKDIR /home/${user}/cppcheck
RUN make -j$(nproc) install FILESDIR=/cfg

# Add Cppcheck to PATH
ENV PATH="/home/${user}/cppcheck/bin:${PATH}"

# Switch to non-root user and set working directory
USER ${user}
WORKDIR /home/${user}

CMD ["/bin/bash"]