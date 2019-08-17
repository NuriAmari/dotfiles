set shell=/bin/bash
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" change to 2 for js
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
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

" non recursive normal mode mappings
" navigating between splits
noremap <F6> <C-w>h
noremap <F7> <C-w>j
noremap <F8> <C-w>k
noremap <F9> <C-w>l
noremap <F10> <C-w>q

" for when not using iterm, probably gonna move towards
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-w> <C-w>q

" toggel file tree
nnoremap <F11> :NERDTreeToggle<CR>
" Fzf keybindings
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>m :FZFMru<CR>
nnoremap <leader>t :Tags<CR>

" use to quick refresh vim
noremap <leader>rr :source ~/.vimrc<CR>


" close vim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:ale_linters = {
\   'javascript': ['prettier'],
\   'python': ['flake8'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'python': ['yapf'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

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

" fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pbogut/fzf-mru.vim'

" color scheme
Plug 'chriskempson/base16-vim', {'do': 'git checkout dict_fix'}

"colour schemes
Plug 'itchyny/lightline.vim'

" async fixing and linting
Plug 'w0rp/ale'

" autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

"jsx synatax highlight
Plug 'mgechev/vim-jsx'

"js sytax highlighting
Plug 'https://github.com/pangloss/vim-javascript'

" quickly comment / uncomment blocks
Plug 'tpope/vim-commentary'

" better grep
Plug 'mileszs/ack.vim'
" theme
Plug 'rakr/vim-one'

Plug 'tpope/vim-surround'

Plug 'rust-lang/rust.vim'

" git integration
Plug 'tpope/vim-fugitive'

call plug#end()

let g:deoplete#enable_at_startup = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


command! Tags call fzf#run(fzf#wrap({
      \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
      \            '| grep --invert-match --text ^!',
      \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index --expect=ctrl-x,ctrl-v',
      \ 'down': '40%',
      \ 'sink*':    function('s:tags_sink'),
      \ }))
command! Buffers call fzf#run(fzf#wrap({
      \ 'source': filter(map(range(1, bufnr('$')), 'bufname(v:val)'), 'len(v:val)'),
      \ }))
command! MRU call fzf#run(fzf#wrap({
      \ 'source': v:oldfiles,
      \ }))

" FZF
let g:fzf_action = {
    \ 'ctrl-t': 'tabedit',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
    \ }


if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" set colorscheme
syntax on
colorscheme one
set background=dark

call one#highlight('jsObjectKey', 'e06c75', '', '')
call one#highlight('javaScriptIdentifier', 'e06c75', '', '')
