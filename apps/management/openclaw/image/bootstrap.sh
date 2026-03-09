#!/bin/bash
set -e

echo "=== HomeCrew SRE Bootstrap Starting ==="

WORKSPACE=${WORKSPACE_DIR:-/data/workspace}

mkdir -p "$WORKSPACE"
cd "$WORKSPACE"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

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

cd /app
exec "$@"
