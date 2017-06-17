#!/bin/bash

if ps aux | grep "upload-check-loop.sh" | grep -vq "grep"; then
	echo "running"
fi

echo "Starting folder importer"
cd ~/folder-importer; nohup ./upload-check-loop.sh > ./log.txt 2>&1 & echo $! > ./upload-check-loop.sh.pid


