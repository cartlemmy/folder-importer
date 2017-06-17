#!/bin/bash

cd ~
mv ~/folder-importer-update-num ~/folder-importer-update-num.prev
curl -sS http://10.125.0.17/folder-importer-update-num -o folder-importer-update-num

if cmp -s ~/folder-importer-update-num ~/folder-importer-update-num.prev; then
	echo "no update"
	exit
else
	./Update\ Folder\ Importer.sh
fi
