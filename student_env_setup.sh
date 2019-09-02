#!/bin/bash

DOTFILES_DIR=$(pwd)

ln -s -f $DOTFILES_DIR/.vimrc ~/.vimrc
ln -s -f $DOTFILES_DIR/.bashrc ~/.bashrc

pip3 install pynvim
pip3 install flake8
pip3 install yapf
