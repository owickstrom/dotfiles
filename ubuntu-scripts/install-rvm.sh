#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

# Ubuntu-only stuff. Abort if not Ubuntu.
$IS_UBUNTU && exit 0

curl -sSL https://get.rvm.io | bash

source ~/.rvm/scripts/rvm

rvm install 1.8
rvm use 1.8
