#!/bin/bash

# add below crontab entry
# @reboot nohup [path to this script] &>/dev/null &

while [ 1 ]
do

./upload-check.sh

sleep 5

done
