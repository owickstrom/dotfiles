#!/usr/bin/bash

# Symlink powerline fonts

FONTS_DIR=/usr/share/fonts/

sudo ln -s $HOME/.dotfiles/shared-lib/powerline-fonts/UbuntuMono/*.ttf $FONTS_DIR
sudo ln -s $HOME/.dotfiles/shared-lib/powerline-fonts/SourceCodePro/*.otf $FONTS_DIR
sudo ln -s $HOME/.dotfiles/shared-lib/powerline-fonts/Meslo/*.otf $FONTS_DIR

