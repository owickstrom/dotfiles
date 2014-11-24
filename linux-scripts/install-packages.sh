#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

if [ $(command -v apt-get) ]; then
  DEPS="git tmux curl wget vim-nox irssi exuberant-ctags"
  sudo apt-get install $DEPS
fi

if [ $(command -v yum) ]; then
  DEPS="git tmux curl wget vim-enhanced irssi ctags"
  sudo yum install $DEPS
fi


# $DIR/install-rvm.sh
