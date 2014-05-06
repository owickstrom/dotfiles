#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

# RVM

source ~/.rvm/scripts/rvm

# Deps

sudo apt-get install libxslt1-dev

# Command-T

cd $DIR/../vim/bundle/Command-T/ruby/command-t

bundle install
rake make
e_success "Command-T: rake make"
