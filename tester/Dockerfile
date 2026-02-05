FROM ghcr.io/wirepas/dlms-app-builder:edge

# Define argument for non-root user
ARG user=wirepas

# Install dnsutils and awscli
USER root
RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    dnsutils \
    jq \
    curl \
    unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf aws awscliv2.zip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Switch to non-root user and set working directory
USER ${user}
WORKDIR /home/${user}

CMD ["/bin/bash"]
