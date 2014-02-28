#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
$IS_UBUNTU && exit 1

DEPS="git tmux curl wget vim-nox"
sudo apt-get install $DEPS
