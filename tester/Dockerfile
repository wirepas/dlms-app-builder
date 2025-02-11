FROM ghcr.io/wirepas/dlms-app-builder:edge

# Define argument for non-root user
ARG user=wirepas

# Install dnsutils and awscli
USER root
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dnsutils \
    awscli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and extract the JLink software
RUN wget --post-data 'accept_license_agreement=accepted&non_emb_ctr=confirmed&submit=Download+software' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.tgz && \
    tar -xvzf JLink_Linux_x86_64.tgz && \
    mv JLink_Linux_V812_x86_64 /home/${user}/jlink && \
    rm JLink_Linux_x86_64.tgz

# Add the JLink executable folder to the PATH
ENV PATH="/home/${user}/jlink:${PATH}"

# Switch to non-root user and set working directory
USER ${user}
WORKDIR /home/${user}

CMD ["/bin/bash"]
