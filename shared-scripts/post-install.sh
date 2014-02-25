#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../logging.sh

e_header "Post install"

make --directory="$DIR/../vim/bundle/vimproc"
if [[ $? -eq 0 ]]; then
    e_success "Make vimproc"
else
    e_warn "Failed to make vimproc."
fi

e_info "Post install done!"