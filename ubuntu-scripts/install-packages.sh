#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

# Ubuntu-only stuff. Abort if not Ubuntu.
$IS_UBUNTU && exit 0

DEPS="git tmux curl wget vim-nox"
sudo apt-get install $DEPS

$DIR/install-rvm.sh
