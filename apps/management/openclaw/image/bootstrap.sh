#!/bin/bash

set -e

echo "=== HomeCrew SRE Bootstrap Starting ==="

WORKDIR=${OPENCLAW_WORKSPACE_DIR:-/data/workspace}

mkdir -p "$WORKDIR"
cd "$WORKDIR"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

echo "$GITHUB_TOKEN" | gh auth login --with-token

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

exec "$@"
