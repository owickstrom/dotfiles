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

e_info "Post install for OSX done!"
