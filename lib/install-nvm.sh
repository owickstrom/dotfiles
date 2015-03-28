#!/usr/bin/env bash

set -e

if [ -d ~/.nvm ]; then
  exit 0
fi

curl https://raw.githubusercontent.com/creationix/nvm/v0.17.2/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 0.10
nvm alias default 0.10
nvm use default
