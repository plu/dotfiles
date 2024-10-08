set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'Keithbsmiley/rspec.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'derekwyatt/vim-scala'
Plugin 'dgryski/vim-godef'
Plugin 'kien/ctrlp.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'rizzatti/dash.vim'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rking/ag.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'skalnik/vim-vroom'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'fatih/vim-go'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()
filetype plugin indent on

" Do not clear sreen on exit.
"set t_ti= t_te=

set autoindent
set background=light
set backspace=indent,eol,start
set browsedir=current
set clipboard+=unnamed
set directory=/tmp
set enc=utf-8
set expandtab
set foldmethod=manual
set guicursor+=a:blinkon0
set guifont=Monaco:h12
set hidden
set history=5000
set incsearch
set laststatus=2
set lazyredraw
"set list
"set listchars=tab:\|\ ,trail:·
set mouse=a
set nobackup
set noerrorbells
set nofoldenable
set nostartofline
set noswapfile
set novisualbell
set nowrap
set nowritebackup
set number
set ruler
set shiftwidth=4
set showcmd
set softtabstop=4
set splitbelow
set splitright
set synmaxcol=256
set t_vb=
set tabstop=4
set tm=500
set ttyfast
set ttymouse=xterm
set whichwrap+=<
set whichwrap+=>

try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
endtry

syntax on
syntax sync minlines=256

let NERDChristmasTree = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize=60
let g:gitgutter_eager = 0
let g:gitgutter_enabled = 1
let g:gitgutter_realtime = 0
let g:go_version_warning = 1
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:vroom_detect_spec_helper = 1
let g:vroom_use_binstubs = 1
let g:vroom_use_colors = 0
let g:vroom_use_dispatch = 1
let g:vroom_use_spring = 1

map <leader>T :CtrlPBuffer<CR>
map <leader>a <Esc>:Ag! 
map <leader>d <Plug>DashSearch
map <leader>gn :GitGutterNextHunk<CR>
map <leader>gp :GitGutterPrevHunk<CR>
map <leader>j :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>t :CtrlP<CR>
map <leader>u :GundoToggle<CR>
map <leader>ws :FixWhitespace<CR>
map <F1> :!clear<CR><CR>:redraw!<CR>:GitGutterAll<CR>:SyntasticCheck<CR>
map <F2> :VimuxRunLastCommand<CR>
map <F3> :set nofoldenable<CR>

" Navigation between split windows
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Don't use Ex mode, use Q for formatting
map Q gq

cmap w!! w !sudo tee % >/dev/null

if has("autocmd")
    autocmd! BufRead,BufNewFile *.god set filetype=ruby
    autocmd! BufRead,BufNewFile Vagrantfile set filetype=ruby
    autocmd! BufRead,BufNewFile Podfile set filetype=ruby
    autocmd! BufRead,BufNewFile *.podspec set filetype=ruby
    autocmd! BufRead,BufNewFile Jenkinsfile set filetype=groovy
    autocmd! BufRead,BufNewFile Fastfile set filetype=ruby
    autocmd! BufRead,BufNewFile BUCK set filetype=python

    autocmd Filetype perl nmap <leader>pt :call DoTidy()<CR>
    autocmd Filetype perl vmap <leader>pt :Tidy<CR>
    autocmd Filetype ruby,eruby,rspec nmap <leader>rr :Dispatch spring rspec spec<CR>
    autocmd Filetype go nmap <leader>r :GoRun<CR>

    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType text setlocal textwidth=78
    autocmd Filetype css,eruby,haml,html,ruby,yaml,xml setlocal ts=2 sts=2 sw=2
    autocmd Filetype gitcommit setlocal textwidth=72

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
end

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
