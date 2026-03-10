#!/bin/bash
set -e

echo "=== HomeCrew SRE Bootstrap Starting ==="

WORKSPACE=${WORKSPACE_DIR:-/data/workspace}
AGENT_SRC=/agent
AGENT_DST=/data/.openclaw/workspace

mkdir -p "$WORKSPACE"
mkdir -p "$AGENT_DST"

########################################
# Git configuration
########################################

echo "Configuring git identity"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

echo "Configuring GitHub authentication"

git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

########################################
# Clone repositories
########################################

cd "$WORKSPACE"

if [ ! -d "homelab" ]; then
    echo "Cloning homelab repo"
    git clone https://github.com/mvg-labs/homelab.git
fi

if [ ! -d "brainbox" ]; then
    echo "Cloning brainbox repo"
    git clone https://github.com/mvg-labs/brainbox-mirror.git brainbox
fi

########################################
# Install agent configuration
########################################

echo "Installing agent configuration"

AGENT_SRC=/agent
AGENT_DST=/data/.openclaw/workspace

mkdir -p "$AGENT_DST"

cp $AGENT_SRC/*.md $AGENT_DST/

########################################
# Setup agent workspace
########################################

echo "Installing agent configuration"

cp $AGENT_SRC/*.md $AGENT_DST/

########################################
# Verify cluster access
########################################

echo "Checking Kubernetes access"

kubectl get nodes || true

########################################
# Agent configuration summary
########################################

echo "Agent identity loaded from:"
ls -la $AGENT_DST

echo "=== Bootstrap complete ==="

cd /app
exec "$@"
