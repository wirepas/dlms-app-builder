FROM ghcr.io/wirepas/dlms-app-builder:edge

# Define argument for non-root user
ARG user=wirepas

# Install dnsutils and awscli
USER root
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dnsutils \
    jq \
    awscli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch to non-root user and set working directory
USER ${user}
WORKDIR /home/${user}

CMD ["/bin/bash"]
