#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if which brew; then
  brew install pkg-config haskell-stack
else
  sudo apt-get install pkg-config haskell-stack
fi

stack setup
stack install

~/.local/bin/dotfiles
