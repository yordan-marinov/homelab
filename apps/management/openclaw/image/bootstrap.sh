#!/usr/bin/env bash
set -e

REPO_DIR="/data/repos/homelab"
SKILLS_SRC="apps/management/openclaw/skills"
SKILLS_DST="/app/skills"

if [ ! -d "$REPO_DIR/.git" ]; then
    git clone https://github.com/yordan-marinov/homelab.git "$REPO_DIR"
else
    cd "$REPO_DIR" && git pull
fi

mkdir -p "$SKILLS_DST"
rsync -av "$REPO_DIR/$SKILLS_SRC/" "$SKILLS_DST/"

cd /app

exec "$@"
