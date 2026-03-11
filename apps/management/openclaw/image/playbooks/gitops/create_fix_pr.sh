#!/bin/bash
set -e

TITLE="$1"
FILE="$2"
MESSAGE="$3"

WORKDIR=/data/workspace/homelab

cd $WORKDIR

/tools/git/repo_branch.sh "agent-fix-$(date +%s)"

git add $FILE

/tools/git/repo_commit.sh "$MESSAGE"

/tools/git/repo_pr.sh "$TITLE"
