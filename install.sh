#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git submodule update --init

$DIR/make-symlinks.sh

$DIR/osx-scripts/install-packages.sh
$DIR/linux-scripts/install-packages.sh
$DIR/linux-scripts/install-fonts.sh

$DIR/shared-scripts/post-install.sh
$DIR/linux-scripts/post-install.sh
$DIR/osx-scripts/post-install.sh
