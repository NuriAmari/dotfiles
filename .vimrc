" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set relativenumber
set number
set nowrap
set background=light
set laststatus=2
syntax enable
colorscheme srcery 

nnoremap <F5> :CtrlP<space>.<CR>
nnoremap <F6> <C-w>h
nnoremap <F7> <C-w>j
nnoremap <F8> <C-w>k
nnoremap <F9> <C-w>l
nnoremap <F10> <C-w>q
nnoremap <F11> :NERDTreeToggle<CR>
nnoremap <C-r> py regression.py<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1

set encoding=UTF-8
set guifont=Fura\ Mono\ Nerd\ Font\ Mono:h14

execute pathogen#infect()

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=magenta
  elseif a:mode == 'r'
    hi statusline guibg=blue
  else
    hi statusline guibg=red
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=green

" default the statusline to green when entering Vim
hi statusline guibg=green

call plug#begin('~/.vim/plugged')

"javascript syntax highlighting
Plug 'https://github.com/pangloss/vim-javascript.git'
"react syntax highlighting
Plug 'https://github.com/mxw/vim-jsx.git'
"html auto complete
Plug 'https://github.com/mattn/emmet-vim.git'
"colour schemes
Plug 'flazz/vim-colorschemes'
Plug 'srcery-colors/srcery-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
call plug#end()

if $TERM == "xterm-256color"
  set t_Co=256
endif

set rtp+=/usr/local/opt/fzf
set runtimepath^=~/.vim/bundle/ctrlp.vim

