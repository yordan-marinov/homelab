FROM ghcr.io/openclaw/openclaw:latest

USER root

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

########################################
# Kubernetes CLI
########################################

RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

########################################
# Helm
########################################

RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

########################################
# GitHub CLI
########################################

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
 | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
 && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
 | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
 && apt-get update \
 && apt-get install gh -y

########################################
# Agent Identity
########################################

COPY image/agent /agent
RUN chown -R 1000:1000 /agent

########################################
# Create OpenClaw workspace
########################################

RUN mkdir -p /data/workspace \
 && mkdir -p /data/.openclaw/workspace \
 && mkdir -p /data/.openclaw/workspace/skills

########################################
# Copy Custom Skills
########################################

COPY skills /data/.openclaw/workspace/skills

RUN chmod -R +x /data/.openclaw/workspace/skills \
 && chown -R 1000:1000 /data/.openclaw

########################################
# Bootstrap
########################################

COPY image/bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

USER 1000

ENTRYPOINT ["/bootstrap.sh"]
CMD ["node","dist/index.js","gateway"]

