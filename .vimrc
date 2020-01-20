set shell=/bin/bash
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" change to 2 for js
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript.tsx setlocal shiftwidth=2 tabstop=2
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

call plug#end()

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

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

set termguicolors

" set colorscheme
set background=dark
set t_Co=256
colorscheme one

call one#highlight('jsObjectKey', 'e06c75', '', '')
call one#highlight('javaScriptIdentifier', 'e06c75', '', '')
