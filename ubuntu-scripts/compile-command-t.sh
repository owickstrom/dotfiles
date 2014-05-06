#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

# Command-T

cd $DIR/../vim/bundle/Command-T/ruby/command-t

# Configure Command-T

ruby extconf.rb
e_success "Command-T: ruby extconf.rb"

# Make Command-T

make
e_success "Command-T: make"
