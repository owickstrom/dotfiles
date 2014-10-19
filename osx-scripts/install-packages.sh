#!/usr/bin/env bash

#set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

# OSX-only stuff. Abort if not OSX.
if $IS_OSX; then
  exit 0
fi

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    sudo xcode-select -switch /usr/bin
fi

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    e_header "Installing Homebrew"
    true | ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

if [[ "$(type -P brew)" ]]; then
    e_header "Updating Homebrew"
    #brew doctor
    #brew update

    # Install Homebrew recipes.
    recipes="
        bash
        bash-completion
        git
        macvim
        tmux
        nvm
        leiningen
        heroku-toolbelt
        ctags-exuberant
        ghc
        cabal-install
    "

    for recipe in $recipes; do
        brew list $recipe > /dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            e_success "$recipe is already installed"
        else
            brew install $recipe
        fi
    done
fi
