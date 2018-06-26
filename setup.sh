#!/bin/bash

#Install:
#cd ~; rsync -arv paliportal@paliportal.com:/home/paliportal/folder-importer .; cd folder-importer; ./setup.sh

if [ -z "$1" ]
  then
	if [ -f importer.cfg ]
	  then
	    source importer.cfg
	  else
        echo "./setup.sh [upload path]"; exit;
    fi
fi

if [ ! -f importer.cfg ]
  then
	printf "UPLOAD_FROM_DIR=\"${1}\"\n" > importer.cfg
	UPLOAD_FROM_DIR=$1
	echo "FROM_SUBFOLDER=\"4. Summer \$(date +'%Y')/\"" >> importer.cfg
	echo "TO_SUBFOLDER=\"Summer\ \$(date +'%Y')/\"" >> importer.cfg
fi

mkdir "${UPLOAD_FROM_DIR}.fi-sync";
mkdir "${UPLOAD_FROM_DIR}.fi-sync/thumbs";

if [ -e "$HOME/.ssh/media${USER}_rsa" ]
  then
    echo "$HOME/.ssh/media${USER}_rsa already exists, please delete if you want to run setup.sh\n\nExisting key below:\n\n";
    
    cat "$HOME/.ssh/media${USER}_rsa.pub"
    
    echo "\n\n"
    exit
fi

set -x

#generate new
ssh-keygen -t RSA -f "$HOME/.ssh/media${USER}_rsa" -P ""

#For some reason this isn't working for Cpanel:
#ssh-copy-id -i "$HOME/.ssh/media${USER}_rsa.pub" paliportal@paliportal.com

set -x

echo "\n\nPublic Key (${USER}_rsa.pub):"
cat "$HOME/.ssh/media${USER}_rsa.pub"

echo "\n\n"

chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/media${USER}_rsa"*

#eval `ssh-agent -s`
#ssh-add "$HOME/.ssh/media${USER}_rsa"

set +x
