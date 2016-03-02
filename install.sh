#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if which brew; then
  brew install pcre pkg-config
else
  sudo apt-get install libpcre3-dev pkg-config
fi

cabal update
cabal install ansi-terminal pcre-heavy

cd $DIR/src && runhaskell Main.hs
