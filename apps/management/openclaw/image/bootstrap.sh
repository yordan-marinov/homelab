#!/usr/bin/env bash
set -e

echo "=== OpenClaw Bootstrap ==="

REPO_DIR="/data/repos/homelab"
SKILLS_SRC="apps/management/openclaw/skills"

SKILLS_DST="/app/skills"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "[BOOTSTRAP] Cloning repo..."
    git clone https://github.com/yordan-marinov/homelab.git "$REPO_DIR"
else
    echo "[BOOTSTRAP] Pulling latest..."
    cd "$REPO_DIR"
    git pull
fi

echo "[BOOTSTRAP] Installing custom skills..."

rsync -av \
    "$REPO_DIR/$SKILLS_SRC/" \
    "$SKILLS_DST/"

echo "[BOOTSTRAP] Final skills list:"
ls "$SKILLS_DST"

exec "$@"
