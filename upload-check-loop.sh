#!/bin/bash

# add below crontab entry
# @reboot nohup [path to this script] &>/dev/null &

eval `ssh-agent -s`
ssh-add "$HOME/.ssh/media${USER}_rsa"


while [ 1 ]
do

./upload-check.sh

sleep 5

done
