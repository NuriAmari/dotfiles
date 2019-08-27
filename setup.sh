#!/bin/bash

DOTFILES_DIR=$(pwd)

ln -s -f $DOTFILES_DIR/.vimrc ~/.vimrc
ln -s -f $DOTFILES_DIR/.bashrc ~/.bashrc
ln -s -f $DOTFILES_DIR/.yabairc ~/.yabairc
ln -s -f $DOTFILES_DIR/.skhdrc ~/.skhdrc
ln -s -f $DOTFILES_DIR/.bash_profile ~/.bash_profile
ln -s -f $DOTFILES_DIR/open_iterm.sh /usr/local/bin/open_iterm.sh

echo "dot file linking complete"

# install homebrew if you don't already have it
if [ ! $(command -v brew) ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "homebrew installed"
fi

# install latest version of vim
if [ ! $(ls /usr/local/bin/vim) ]; then
    brew install vim
fi

# install python3 if not already installed
if [ ! $(command -v python3) ]; then
    brew install python
    echo "python3 installed"
fi

# install node and nvm
if [ ! $(command -v node) ]; then
    if [ ! -d "/Users/$USER/.nvm" ]; then
        mkdir /Users/$USER/.nvm
    fi
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install node
    echo "node installed, please restart terminal"
fi

npm install -g tldr
npm install -g prettier
