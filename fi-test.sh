#!/bin/bash

source importer.cfg

echo "UPLOAD_FROM_DIR=$UPLOAD_FROM_DIR"
echo "FROM_SUBFOLDER=$FROM_SUBFOLDER"
echo "TO_SUBFOLDER=$TO_SUBFOLDER"

OPTS="--dry-run -v"
LOCAL_PATH="."

set -x

cd "$UPLOAD_FROM_DIR/$FROM_SUBFOLDER"

rsync -e "ssh -i $HOME/.ssh/media${USER}_rsa.pub" \
        -ri --ignore-existing --prune-empty-dirs \
        --filter="merge $HOME/folder-importer/fi-filter" \
        $OPTS \
        . \
        "paliportal@paliportal.com:/home/paliportal/public_html/data/folder-import/queue/$USER/$TO_SUBFOLDER"
