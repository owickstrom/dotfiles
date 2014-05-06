#!/usr/bin/env bash

set -e

# Ubuntu-only stuff. Abort if not Ubuntu.
$IS_UBUNTU && exit 0

DEPS="git tmux curl wget vim-nox"
sudo apt-get install $DEPS

$DIR/install-rvm.sh
