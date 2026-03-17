#!/usr/bin/env bash
set -e

echo "=== 🛡️ HomeCrew SRE Bootstrap ==="

REPOS_ROOT="/data/repos"
HOMELAB_DIR="$REPOS_ROOT/homelab"
BRAINBOX_DIR="$REPOS_ROOT/brainbox"

SKILLS_SRC="$HOMELAB_DIR/apps/management/openclaw/skills"
SKILLS_DST="/app/skills"

mkdir -p "$REPOS_ROOT"
[ ! -d "$HOMELAB_DIR/.git" ] && git clone https://github.com/yordan-marinov/homelab.git "$HOMELAB_DIR" || (cd "$HOMELAB_DIR" && git pull)
[ ! -d "$BRAINBOX_DIR/.git" ] && git clone https://github.com/yordan-marinov/brainbox-mirror.git "$BRAINBOX_DIR" || (cd "$BRAINBOX_DIR" && git pull)

mkdir -p "$SKILLS_DST"
rsync -av --delete "$SKILLS_SRC/" "$SKILLS_DST/"

ln -sf /data/openclaw.json /app/openclaw.json

cd /app
echo "[BOOTSTRAP] Initialization complete. Starting OpenClaw..."

exec "$@"
