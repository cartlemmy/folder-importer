#!/bin/bash

printf "$USER\n$(ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')" > /tmp/fi-uinfo

OPEN_URL=`curl -s --data-binary @/tmp/fi-uinfo https://paliportal.com/fi?a=manage`

echo "Link to import monitor:\n"
echo $OPEN_URL
echo "\n\n"

if hash google-chrome 2>/dev/null; then
	google-chrome $OPEN_URL
elif hash firefox 2>/dev/null; then
	firefox $OPEN_URL
else
	sed 's/[OPEN_URL]/$OPEN_URL/g' <redir.tpl.html >redir.html 
	open redir.html
fi

