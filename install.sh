#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

brew install pcre pkg-config

cabal update
cabal install ansi-terminal pcre-heavy

cd $DIR/src && runhaskell Main.hs
