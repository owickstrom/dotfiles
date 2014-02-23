#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../logging.sh

e_header "Post install for Ubuntu"

echo "xmodmap \$HOME/.Xmodmap" >> $HOME/.xinitrc
e_success "Remap CapsLock to CTRL"

e_info "Post install for Ubuntu done!"
