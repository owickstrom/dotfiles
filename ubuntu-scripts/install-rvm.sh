#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

curl -sSL https://get.rvm.io | bash

rvm install ruby-2.0.0-p195

rvm use ruby-2.0.0-p195
