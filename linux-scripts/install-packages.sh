#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

if [ $(command -v apt-get) ]; then
  DEPS="git tmux curl wget vim-nox irssi exuberant-ctags pandoc golang mercurial"
  sudo apt-get install $DEPS

  # Install Source Code Pro
  curl -L https://gist.githubusercontent.com/lucasdavila/3875946/raw/f62c8a26ad6648b00cd379704617d0b61338f59f/install_source_code_pro.sh | bash
fi

if [ $(command -v yum) ]; then
  e_warn "This installation will not have golang and mercurial installed. Please update dotfiles."
  DEPS="git tmux curl wget vim-enhanced irssi ctags pandoc"
  sudo yum install $DEPS
fi

if [ $(command -v pacman) ]; then
  e_warn "This installation will not have golang and mercurial installed. Please update dotfiles."
  DEPS="git tmux curl wget vim irssi ctags base-devel pandoc"
  sudo pacman -S $DEPS
fi
