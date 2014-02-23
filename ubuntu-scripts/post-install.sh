#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || exit 1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../logging.sh

e_header "Post install for Ubuntu"

echo "xmodmap \$HOME/.Xmodmap" >> $HOME/.xinitrc
e_success "Remap CapsLock to CTRL"

e_info "Post install for Ubuntu done!"
