#!/bin/bash
cd ~
curl -LOk https://github.com/cartlemmy/folder-importer/archive/master.zip -o master.zip
unzip master.zip
rsync -arv folder-importer-master/ folder-importer
rm master.zip
rm -rf master.zip folder-importer-master
cd ~/folder-importer
