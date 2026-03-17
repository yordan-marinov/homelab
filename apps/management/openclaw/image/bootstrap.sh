#!/usr/bin/env bash
set -e

REPOS_ROOT="/data/repos"
HOMELAB_DIR="$REPOS_ROOT/homelab"
BRAINBOX_DIR="$REPOS_ROOT/brainbox"
SKILLS_SRC="$HOMELAB_DIR/apps/management/openclaw/skills"
SKILLS_DST="/app/skills"

mkdir -p "$REPOS_ROOT"
[ ! -d "$HOMELAB_DIR/.git" ] && git clone -q https://github.com/yordan-marinov/homelab.git "$HOMELAB_DIR" || (cd "$HOMELAB_DIR" && git pull -q)
[ ! -d "$BRAINBOX_DIR/.git" ] && git clone -q https://github.com/yordan-marinov/brainbox-mirror.git "$BRAINBOX_DIR" || (cd "$BRAINBOX_DIR" && git pull -q)

mkdir -p "$SKILLS_DST"
rsync -a --delete "$SKILLS_SRC/" "$SKILLS_DST/"

cp /data/openclaw.json /app/openclaw.json

echo "[HOME-CREW] SRE Environment Initialized. Repos & Skills Synced."

cd /app
exec "$@"
