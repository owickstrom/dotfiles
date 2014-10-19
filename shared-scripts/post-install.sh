#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../common.sh

e_header "Post install"

e_info "Installing nvm..."
curl https://raw.githubusercontent.com/creationix/nvm/v0.17.2/install.sh | bash
if [[ $? -eq 0 ]]; then
    source ~/.nvm/nvm.sh
    nvm install 0.10
    nvm alias default 0.10
    nvm use default
    e_success "Installed nvm."
else
    e_warn "Failed to install nvm."
fi

e_info "Making vimproc..."
make --directory="$DIR/../vim/bundle/vimproc.vim"
if [[ $? -eq 0 ]]; then
    e_success "Make vimproc"
else
    e_warn "Failed to make vimproc."
fi

e_info "Post install done!"
