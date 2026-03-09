FROM ghcr.io/openclaw/openclaw:latest

USER root

COPY tools /tools
RUN chmod +x /tools/*

RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    yq \
    ansible \
    python3 \
    python3-pip \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
 | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
 && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
 | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
 && apt-get update \
 && apt-get install gh -y

RUN mkdir -p /tools /data /data/workspace

COPY bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

USER 1000

