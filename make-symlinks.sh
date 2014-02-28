#!/bin/bash

###########################################################
# This script creates symlinks from the home directory to #
# files in osx-dotfiles and ubuntu-dotfiles.              #
###########################################################

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/common.sh

# Dotfiles directory
DOTFILES=$DIR
# Old dotfiles backup directory
DOTFILES_OLD=$HOME/.dotfiles.old
# Shared dotfiles
SHARED=$DOTFILES/shared-dotfiles
# OS specific dotfiles
OS_SPECIFIC=""

if [[ "$OSTYPE" =~ ^darwin ]]; then
    OS_SPECIFIC=$DOTFILES/osx-dotfiles
fi

if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
    OS_SPECIFIC=$DOTFILES/ubuntu-dotfiles
fi

# Create .dotfiles.old in homedir
mkdir -p $DOTFILES_OLD

# Change to the dotfiles directory
cd $DOTFILES

# Include the vim directory, shared dotfiles and those specific for the OS.
FILES="$DOTFILES/vim $SHARED/* $OS_SPECIFIC/*"
echo $FILES

# Move any existing dotfiles in homedir, then create symlinks
echo "Moving any existing dotfiles from ~ to $DOTFILES_OLD"
for file in $FILES; do
    target=$HOME"/."$(basename $file)

    if [ ! -h $target ]; then
        # Not a symlink, let's fix that

        # First backup the original file any
        if [ -e $target ]; then
            mv $target $DOTFILES_OLD/
            e_info "Created backup of $target in $DOTFILES_OLD/"
        fi

        ln -s $file $target
        if [ $? ]; then
            e_success "Created symlink to $file."
        fi
    else
        e_info "$file already symlinked to dotfiles."
    fi
done
