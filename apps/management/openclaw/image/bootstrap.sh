#!/usr/bin/env bash
set -e

echo "=== 🛡️ HomeCrew SRE Bootstrap ==="

REPOS_ROOT="/data/repos"
HOMELAB_DIR="$REPOS_ROOT/homelab"
BRAINBOX_DIR="$REPOS_ROOT/brainbox"

SKILLS_SRC="$HOMELAB_DIR/apps/management/openclaw/skills"
SKILLS_DST="/app/skills"

sync_repo() {
    local url=$1
    local dir=$2
    mkdir -p "$REPOS_ROOT"
    if [ ! -d "$dir/.git" ]; then
        echo "[BOOTSTRAP] Cloning $url..."
        git clone "$url" "$dir"
    else
        echo "[BOOTSTRAP] Pulling latest from $url..."
        cd "$dir" && git pull
    fi
}

sync_repo "https://github.com/yordan-marinov/homelab.git" "$HOMELAB_DIR"
sync_repo "https://github.com/yordan-marinov/brainbox-mirror.git" "$BRAINBOX_DIR"

echo "[BOOTSTRAP] Syncing custom skills..."
mkdir -p "$SKILLS_DST"
rsync -av --delete "$SKILLS_SRC/" "$SKILLS_DST/"

echo "[BOOTSTRAP] Current skills:"
ls "$SKILLS_DST"

cd /app

echo "[BOOTSTRAP] Starting OpenClaw..."
exec "$@"
