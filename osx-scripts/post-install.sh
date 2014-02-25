#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../logging.sh
e_header "Post install for OSX"

osascript $DIR/remap-capslock-to-ctrl.scpt
if [[ $? -eq 0 ]]; then
    e_success "Remap CapsLock to CTRL"
else
    e_warn "Failed to remap CapsLock to CTRL in System Preferences."
fi

# Command-T

cd $DIR/../vim/bundle/Command-T/ruby/command-t

# Configure Command-T

/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby extconf.rb
if [[ $? -eq 0 ]]; then
    e_success "Command-T: ruby extconf.rb"
else
    e_warn "Command-T: ruby extconf.rb failed"
fi

# Make Command-T

make
if [[ $? -eq 0 ]]; then
    e_success "Command-T: ruby extconf.rb"
else
    e_warn "Command-T: ruby extconf.rb failed"
fi


e_info "Post install for OSX done!"
