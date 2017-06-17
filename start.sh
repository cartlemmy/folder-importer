#!/bin/bash

#if pidof -x "upload-check-loop.sh" >/dev/null; then
if pgrep -xq -- "upload-check-loop.sh"; then
        echo "already running"
        exit
else
        cd ~/folder-importer; nohup ./upload-check-loop.sh >./log.txt 2>&1 &
fi

