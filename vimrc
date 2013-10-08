set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

let g:vundle_default_git_proto = 'git'

Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'bundle/vim-gitgutter'
Bundle 'derekwyatt/vim-scala'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'skalnik/vim-vroom'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'wincent/Command-T'
Bundle 'bronson/vim-trailing-whitespace'

filetype plugin indent on

" Do not clear sreen on exit.
"set t_ti= t_te=

set autoindent
set background=light
set backspace=indent,eol,start
set browsedir=current
set directory=/tmp
set enc=utf-8
set expandtab
set guicursor+=a:blinkon0
set guifont=Monaco:h12
set hidden
set history=5000
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:\|\ ,trail:·
set nobackup
set noerrorbells
set nostartofline
set noswapfile
set novisualbell
set nowrap
set number
set ruler
set shiftwidth=4
set showcmd
set softtabstop=4
set t_vb=
set tabstop=4
set tm=500
set ttyfast
set whichwrap+=<
set whichwrap+=>

colorscheme solarized
syntax on

let g:fugitive_github_domains = ['source.xing.com']
let g:gitgutter_enabled = 1
let g:vroom_use_dispatch = 1

map <leader>T :CommandTBuffer<CR>
map <leader>a <Esc>:Ag! 
map <leader>gn :GitGutterNextHunk<CR>
map <leader>gp :GitGutterPrevHunk<CR>
map <leader>j :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>s :Dispatch zeus rspec spec<CR>
map <leader>u :GundoToggle<CR>
map <leader>ws :FixWhitespace<CR>
map <leader>xr :!xing sandbox restart --no-color --app 
map <leader>xs :!xing sandbox sync -c --no-color --app 

autocmd Filetype perl nmap <leader>pt :call DoTidy()<CR>
autocmd Filetype perl vmap <leader>pt :Tidy<CR>

" Navigation between split windows
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Don't use Ex mode, use Q for formatting
map Q gq

cmap w!! w !sudo tee % >/dev/null

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType text setlocal textwidth=78
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" Put these in an autocmd group, so that we can delete them easily.
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
augroup vimrcEx
au!
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    set hlsearch
    set guioptions=egmrt
endif

if ! has("gui_running")
    let g:solarized_termcolors=256
    set t_Co=256
endif
