#!/bin/bash

DOTFILES_DIR=$(pwd)

ln -s -f $DOTFILES_DIR/.vimrc ~/.vimrc
ln -s -f $DOTFILES_DIR/.bashrc ~/.bashrc
ln -s -f $DOTFILES_DIR/.yabairc ~/.yabairc
ln -s -f $DOTFILES_DIR/.skhdrc ~/.skhdrc
ln -s -f $DOTFILES_DIR/.bash_profile ~/.bash_profile
ln -s -f $DOTFILES_DIR/open_iterm.sh /usr/local/bin/open_iterm.sh
ln -s -f $DOTFILES_DIR/.clang-format ~/.clang-format
# ln -s -f $DOTFILES_DIR/bin/leet /usr/local/bin/leet
# ln -s -f $DOTFILES_DIR/bin/uw_login /usr/local/bin/uw_login
ln -s -f $DOTFILES_DIR/coc-settings.json ~/.config/nvim/coc-settings.json
