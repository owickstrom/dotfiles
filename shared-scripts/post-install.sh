#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

e_header "Post install"

make --directory="$DIR/../vim/bundle/vimproc.vim"
if [[ $? -eq 0 ]]; then
    e_success "Make vimproc"
else
    e_warn "Failed to make vimproc."
fi

e_info "Post install done!"
