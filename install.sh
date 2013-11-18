#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/make-symlinks.sh
$DIR/install-apt-dependencies.sh

make --directory="$DIR/vim/bundle/vimproc"


