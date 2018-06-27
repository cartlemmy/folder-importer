#!/bin/bash

source importer.cfg

TMP_PATH="$(pwd)/tmp"
mv "$TMP_PATH/upload-files-state" "$TMP_PATH/upload-files-state.prev"

OPTS="--dry-run"
FI_TYPE="LOCAL"

source cmd-rsync > "$TMP_PATH/upload-files-state"
	
#rsync -e "ssh -i $HOME/.ssh/media${USER}_rsa.pub" -arv  --include-from rsync-include --exclude-from rsync-exclude --delete "$UPLOAD_FROM_DIR" "paliportal@paliportal.com:/home/paliportal/public_html/data/folder-import/queue/$USER/" | grep -v 'bytes/sec' | grep -v 'speedup' > /tmp/upload-files-state

if ps aux | grep "fi-sync.sh" | grep -vq "grep"; then
	echo "fi-sync.sh running"
else
	echo "Spawning fi-sync.sh, sync from $UPLOAD_FROM_DIR"
	nohup ./fi-sync.sh "$UPLOAD_FROM_DIR" >> ./fi-sync.log.txt 2>&1 &
fi

printf "$USER\n$(/sbin/ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')\n\ndiff:" > "$TMP_PATH/upload-files-diff"

if cmp -s "$TMP_PATH/upload-files-state" "$TMP_PATH/upload-files-state.prev"
then
	curl -sS --data-binary "@$TMP_PATH/upload-files-state" https://paliportal.com/fi?a=heartbeat
	exit
else
	cat "$TMP_PATH/upload-files-state" >> "$TMP_PATH/upload-files-diff"
	#printf "cd \"${UPLOAD_FROM_DIR}\"\n" > fi-cmds
	curl -sS --data-binary "$TMP_PATH/upload-files-diff" https://paliportal.com/fi?a=status
	#cat fi-cmds
	#chmod +x fi-cmds
	#./fi-cmds

fi

sleep 20
