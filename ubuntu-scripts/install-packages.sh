#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || exit 1

DEPS="git tmux curl wget"
sudo apt-get install $DEPS
