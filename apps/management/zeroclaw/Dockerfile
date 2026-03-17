FROM debian:bookworm-slim

USER root

RUN apt-get update && apt-get install -y \
    git curl jq rsync ca-certificates tar \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install gh -y \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSLO https://github.com/zeroclaw-labs/zeroclaw/releases/latest/download/zeroclaw-x86_64-unknown-linux-gnu.tar.gz \
    && tar xzf zeroclaw-x86_64-unknown-linux-gnu.tar.gz \
    && install -m 0755 zeroclaw /usr/local/bin/zeroclaw \
    && rm zeroclaw-x86_64-unknown-linux-gnu.tar.gz

RUN mkdir -p /work/homelab /work/brainbox /work/infra && chown -R 1000:1000 /work
ENV HOME=/work
WORKDIR /work

USER 1000

ENTRYPOINT ["zeroclaw"]
CMD ["gateway", "--bind", "0.0.0.0", "--port", "18789"]
