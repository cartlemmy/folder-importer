#!/bin/sh

# https://apple.stackexchange.com/questions/82472/what-steps-are-needed-to-create-a-new-user-from-the-command-line/84039#84039

. /etc/rc.common
dscl . create "/Users/$1"
dscl . create "/Users/$1" RealName "$2"
dscl . create "/Users/$1" hint "Password Hint"
#dscl . create "/Users/$1" picture "/Path/To/Picture.png"
dscl . create "/Users/$1" UniqueID 588
dscl . create "/Users/$1" PrimaryGroupID 20
dscl . create "/Users/$1" UserShell /bin/bash
dscl . create "/Users/$1" NFSHomeDirectory "/Users/$1"
cp -R /System/Library/User\ Template/English.lproj "/Users/$1"
chown -R josh:staff "/Users/$1"
dscl . passwd "/Users/$1"
