#!/bin/bash

############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/logging.sh

# Dotfiles directory
dotfiles=$DIR
# Old dotfiles backup directory
dotfiles_old=$HOME/.dotfiles.old
# Shared dotfiles
shared=$dotfiles/shared-dotfiles
# OS specific dotfiles
os_specific=""

if [[ "$OSTYPE" =~ ^darwin ]]; then
    os_specific=$dotfiles/osx-dotfiles
fi

if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
    os_specific=$dotfiles/ubuntu-dotfiles
fi

# Create .dotfiles.old in homedir
mkdir -p $dotfiles_old

# Change to the dotfiles directory
cd $dotfiles

FILES="$shared/* $os_specific/*"
echo $FILES

# Move any existing dotfiles in homedir, then create symlinks
echo "Moving any existing dotfiles from ~ to $dotfiles_old"
for file in $FILES; do
    target=$HOME"/."$(basename $file)

    if [ ! -h $target ]; then
        # Not a symlink, let's fix that

        # First backup the original file any
        if [ -e $target ]; then
            mv $target $dotfiles_old/
            e_info "Created backup of $target in $dotfiles_old/"
        fi

        ln -s $file $target
        if [ $? ]; then
            e_success "Created symlink to $file."
        fi
    else
        e_info "$file already symlinked to dotfiles."
    fi
done
