#!/bin/bash

DOTFILES_DIR=$(pwd)

ln -s -f $DOTFILES_DIR/.vimrc ~/.vimrc
ln -s -f $DOTFILES_DIR/.bashrc ~/.bashrc
ln -s -f $DOTFILES_DIR/.yabairc ~/.yabairc
ln -s -f $DOTFILES_DIR/.skhdrc ~/.skhdrc
ln -s -f $DOTFILES_DIR/.bash_profile ~/.bash_profile

echo "dot file linking complete"

# install homebrew if you don't already have it
if [ ! $(command -v brew) ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "homebrew already installed"
fi

# install python3 if not already installed
if [ ! $(command -v python3) ]; then
    brew install python
else
    echo "python3 already installed"
fi
