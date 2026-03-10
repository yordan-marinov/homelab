#!/bin/bash

set -e

REPO=$1
BRANCH=$2
TITLE=$3

cd /data/workspace/$REPO

git push origin "$BRANCH"

gh pr create \
    --title "$TITLE" \
    --body "Proposed by homecrew-sre agent"
