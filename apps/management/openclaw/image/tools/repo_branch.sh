#!/bin/bash

set -e

REPO=$1
BRANCH=$2

cd /data/workspace/$REPO

git checkout -b "$BRANCH"

echo "Branch $BRANCH created in $REPO"
