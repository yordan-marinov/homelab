#!/bin/bash

set -e

REPO=$1
MESSAGE=$2

cd /data/workspace/$REPO

git add .

git commit -m "$MESSAGE"

echo "Commit created"
