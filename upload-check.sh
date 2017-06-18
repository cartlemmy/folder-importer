#!/bin/bash

source importer.cfg

mv /tmp/upload-files-state /tmp/upload-files-state.prev

OPTS="--dry-run"
source cmd-rsync > /tmp/upload-files-state
	
#rsync -e "ssh -i $HOME/.ssh/media${USER}_rsa.pub" -arv  --include-from rsync-include --exclude-from rsync-exclude --delete "$UPLOAD_FROM_DIR" "paliportal@paliportal.com:/home/paliportal/public_html/data/folder-import/queue/$USER/" | grep -v 'bytes/sec' | grep -v 'speedup' > /tmp/upload-files-state

if hash pidof 2>/dev/null; then
	if ! pidof -x "fi-sync.sh" >/dev/null; then
		nohup ./fi-sync.sh "$UPLOAD_FROM_DIR" >./fi-sync.log.txt 2>&1 &
	fi
else
	if ! pgrep -xq -- "fi-sync.sh"; then
		nohup ./fi-sync.sh "$UPLOAD_FROM_DIR" >./fi-sync.log.txt 2>&1 &
	fi
fi

	printf "$USER\n$(/sbin/ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')\n\ndiff:" > /tmp/upload-files-diff
if cmp -s /tmp/upload-files-state /tmp/upload-files-state.prev
then
	curl -sS --data-binary "@/tmp/upload-files-diff" https://paliportal.com/fi?a=heartbeat
	exit
else
	cat /tmp/upload-files-state >> /tmp/upload-files-diff
	printf "cd \"${UPLOAD_FROM_DIR}\"\n" > fi-cmds
	curl -sS --data-binary "@/tmp/upload-files-diff" https://paliportal.com/fi?a=status >> fi-cmds
	cat fi-cmds
	chmod +x fi-cmds
	./fi-cmds

fi

sleep 10
