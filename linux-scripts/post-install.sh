#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

# Ubuntu-only stuff. Abort if not Ubuntu.
$IS_UBUNTU && exit 0

e_header "Post install for Ubuntu"

echo "xmodmap \$HOME/.Xmodmap" >> $HOME/.xinitrc
e_success "Remap CapsLock to CTRL"

$DIR/setup-gnome-terminal-theme.sh
e_success "Gnome Terminal Colors"

e_success "Post install for Ubuntu done!"
