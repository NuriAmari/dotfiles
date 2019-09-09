#!/bin/bash

# symlink everything where it should be
source $PWD/symlink.sh

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

if [ ! $(command -v clang-format) ]; then
    brew install clang-format
    echo "clang-format installed"
fi

if [ ! $(command -v ccls) ]; then
    brew install ccls
    echo "ccls installed"
fi

pip3 install pynvim
pip3 install flake8
pip3 install yapf
pip3 install ranger-fm
pip3 install python-language-server

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

# install global npm packages
npm list -g | grep tldr || npm install -g tldr
npm list -g | grep prettier || npm install -g prettier
npm list -g | grep leetcode || npm install -g leetcode-cli
