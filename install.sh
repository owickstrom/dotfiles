#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/make-symlinks.sh

$DIR/osx-scripts/install-packages.sh
$DIR/ubuntu-scripts/install-packages.sh

$DIR/shared-scripts/post-install.sh
$DIR/ubuntu-scripts/post-install.sh
$DIR/osx-scripts/post-install.sh
