#!/bin/bash
eval `ssh-agent -s`
ssh-add "$HOME/.ssh/media${USER}_rsa"

source importer.cfg

OPTS="--dry-run"
source imp-rsync
