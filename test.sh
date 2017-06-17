#!/bin/bash
set -x
eval `ssh-agent -s`
ssh-add "$HOME/.ssh/media${USER}_rsa"

ssh -i "$HOME/.ssh/media${USER}_rsa.pub" paliportal@paliportal.com

set +x
