#!/bin/bash

if ps aux | grep "upload-check-loop.sh" | grep -vq "grep"; then
	if [ $1 = "force" ]; then
		echo "forcing restart"
		pkill bash
		pkill rsync
	else 
		echo "running"
		exit
	fi
fi

echo "" > ./log.txt
echo "" > ./fi-sync.log.txt

echo "Starting folder importer"
cd ~/folder-importer; nohup ./upload-check-loop.sh > ./log.txt 2>&1 & echo $! > ./upload-check-loop.sh.pid


