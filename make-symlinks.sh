#!/bin/bash

############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# Dotfiles directory
dotfiles=~/dotfiles
# Old dotfiles backup directory
dotfiles_old=~/.dotfiles.old

# List of files/folders to symlink in homedir
files="bashrc vimrc vim gitconfig gitignore tmux.conf" 

# Create .dotfiles.old in homedir
mkdir -p $dotfiles_old

# Change to the dotfiles directory
cd $dotfiles

# Move any existing dotfiles in homedir, then create symlinks 
echo "Moving any existing dotfiles from ~ to $dotfiles_old"
for file in $files; do
    target=~/.$file
    if [ ! -h $target ]; then
        # Not a symlink, let's fix that

        # First backup the original file any
        if [ -e $target ]; then
            mv $target $dotfiles_old/
            echo $(tput setaf 3)"Created backup of $target in $dotfiles_old/"$(tput sgr0)
        fi

        ln -s $dotfiles/$file $target
        if [ $? ]; then
            echo $(tput setaf 2)"Created symlink to $file."$(tput sgr0)
        fi
    else
        echo $(tput setaf 3)"$file already symlinked to dotfiles."$(tput sgr0)
    fi
done
