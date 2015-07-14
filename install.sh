#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cabal install ansi-terminal
cd $DIR/src && runhaskell Main.hs
