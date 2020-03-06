set shell=/bin/bash
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" change to 2 for js
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript.tsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
" set wrap for markdown
autocmd FileType md setlocal wrap
" set tabwidth for c
autocmd FileType c setlocal shiftwidth=8 tabstop=8
" replace tabs with spaces
set expandtab
" relative line numbers
set relativenumber
" line numbers
set number
" no linewrap
set nowrap
" always display the status bar
set laststatus=2
" syntax highlight
syntax enable
" autoindenting
set autoindent
set noshowmode
set mouse=a
" highlight search terms
set hlsearch
" show results as you type
set incsearch

set tags=tags;

" persistent undo
set undofile
set undodir=~/.vim/undo//

if exists('*mkdir')
  for s:dir in [ '/.vim/backup', '/.vim/swp', '/.vim/undo', '/.vim/tags', '/.vim/viminfo' ]
    if !isdirectory($HOME.s:dir)
      call mkdir($HOME.s:dir, 'p')
    endif
  endfor
endif

autocmd BufNewFile,BufRead * setlocal formatoptions-=r

set clipboard=unnamed

" set leader to space
map <Space> <Nop>
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

" better line navigation when linewrapping is one
nnoremap j gj
nnoremap k gk

" split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-w> <C-w>q

" nerd tree commands
noremap <C-n> :NERDTreeToggle<CR>
noremap <C-f> :NERDTreeFind<CR>

" tag bar command
noremap <C-t> :TagbarToggle<CR>

" tab keybindings
nnoremap tn :tabnew<CR>
nnoremap tj :tabp<CR>
nnoremap tk :tabn<CR>
nnoremap tw :tabclose<CR>

" Fzf keybindings
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>m :FZFMru<CR>
nnoremap <leader>t :Tags<CR>

" use to quick refresh vim
noremap <leader>rr :source ~/.vimrc<CR>

" coc configuration

" tab and shift tab to iterate suggestions, enter to confirm
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
vmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction)

command! -nargs=0 Format :call CocAction('format')

" close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" light line configuration
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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pbogut/fzf-mru.vim'
Plug 'junegunn/fzf.vim'

"colour schemes
Plug 'itchyny/lightline.vim'

"jsx synatax highlight
Plug 'mgechev/vim-jsx'

"typescript syntax
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

"js sytax highlighting
Plug 'pangloss/vim-javascript'

" quickly comment / uncomment blocks
Plug 'tpope/vim-commentary'

" change double quotes to single quotes fast
Plug 'tpope/vim-surround'

" rust syntax highlighting
Plug 'rust-lang/rust.vim'

" git integration
Plug 'tpope/vim-fugitive'

" file tree viewer
Plug 'scrooloose/nerdtree'

" coc for lsp support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" one dark theme
Plug 'rakr/vim-one'

" shows context based on tags
Plug 'majutsushi/tagbar'

" gruvbox colorscheme
Plug 'morhetz/gruvbox'

" ale for whitespace removal and spell check
Plug 'dense-analysis/ale'

call plug#end()

function! s:tags_sink(lines) abort
  if empty(a:lines)
    return
  endif
  let l:cmd = get({
        \ 'ctrl-t': 'tabedit',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit',
        \ }, remove(a:lines, 0), 'e')
  let l:query = a:lines[0]
  let l:parts = split(l:query, '\t\zs')
  let l:excmd = matchstr(l:parts[2:], '^.*\ze;"\t')
  execute 'silent ' l:cmd l:parts[1][:-2]
  let [l:magic, &magic] = [&magic, 0]
  execute l:excmd
  let &magic = l:magic
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \     'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
      \ },
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified', 'tagbar' ] ],
      \ },
      \ }

set termguicolors

" set colorscheme
set background=dark
set t_Co=256
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

" colorscheme one

" call one#highlight('jsObjectKey', 'e06c75', '', '')
" call one#highlight('javaScriptIdentifier', 'e06c75', '', '')

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<CR>

" Bookmarks
function Bookmark(bookmark_name)
    let l:current_file = expand("%:p")
    let l:current_line = line(".")
    redir >> ~/.vim/Bookmarks
    echo a:bookmark_name .. ": " .. l:current_file .. ":" .. l:current_line
    redir END
endfunction

command! -nargs=1 Book call Bookmark(<f-args>)

" Return to last position in files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Ale configuration
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'cpp': ['clang-format'],
\ 'typescript': ['prettier'],
\ 'typescript.jsx': ['prettier'],
\ 'js': ['prettier'],
\}

let g:ale_linters = {
\ 'python': ['pylint'],
\ 'typescript': ['tslint'],
\ 'typescript.jsx': ['tslint'],
\ 'cpp': ['clang'],
\}

let g:ale_linters_explicit = 1

let g:python_host_prog='/usr/bin/local/docker_python'

set spell
