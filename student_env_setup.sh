#!/bin/bash

DOTFILES_DIR=$(pwd)

ln -s -f $DOTFILES_DIR/.student_env_vimrc ~/.vimrc
ln -s -f $DOTFILES_DIR/.bashrc ~/.bashrc
ln -s -f $DOTFILES_DIR/.clang-format ~/.clang-format
ln -s -f $DOTFILES_DIR/.gdbinit ~/.gdbinit
ln -s -f $DOTFILES_DIR/coc-settings.json ~/.vim/coc-settings.json

# pip3 install pynvim
# pip3 install flake8
# pip3 install yapf
