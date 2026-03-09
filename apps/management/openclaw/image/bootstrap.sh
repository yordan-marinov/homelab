#!/bin/bash

set -e

echo "=== HomeCrew SRE Bootstrap Starting ==="

mkdir -p /data/workspace
cd /data/workspace

# Configure Git identity
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Setup GitHub auth
echo "$GITHUB_TOKEN" | gh auth login --with-token

# Clone repos if not present
if [ ! -d "homelab" ]; then
    echo "Cloning homelab repo"
    git clone https://github.com/mvg-labs/homelab.git
fi

if [ ! -d "brainbox" ]; then
    echo "Cloning brainbox repo"
    git clone https://github.com/mvg-labs/brainbox-mirror.git brainbox
fi

echo "Workspace ready"

kubectl get nodes || true

echo "=== Bootstrap complete ==="
