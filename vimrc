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
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'wincent/Command-T'

filetype plugin indent on

" Do not clear sreen on exit.
"set t_ti= t_te=

set autoindent
set backspace=indent,eol,start
set browsedir=current
set enc=utf-8
set expandtab
set guicursor+=a:blinkon0
set guifont=Monaco:h12
set hidden
set history=5000
set incsearch
set laststatus=2
set lazyredraw
set noerrorbells
set nostartofline
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
set directory=/tmp
set background=light

colorscheme solarized

if ! has("gui_running")
  let g:solarized_termcolors=256
  set t_Co=256
endif

let g:fugitive_github_domains = ['source.xing.com']
let g:gitgutter_enabled = 1
let g:vroom_use_dispatch = 1

nmap <leader>a <Esc>:Ag! 
map <leader>n :NERDTreeToggle<CR>
map <leader>j :NERDTreeFind<CR>
map <leader>T :CommandTBuffer<CR>
map <leader>ba :ToggleBookmark<CR>
map <leader>bn :NextBookmark<CR>
map <leader>bp :PreviousBookmark<CR>
map <leader>xs :!xing sandbox sync -c --no-color --app 
map <leader>xr :!xing sandbox restart --no-color --app 
map <leader>gn :GitGutterNextHunk<CR>
map <leader>gp :GitGutterPrevHunk<CR>
map <leader>u :GundoToggle<CR>
map <leader>s :Dispatch zeus rspec spec<CR>

" Navigation between split windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

cmap w!! w !sudo tee % >/dev/null

" Spaces
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" Trailing whitespace killer
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

map <leader>ws :call StripTrailingWhitespaces()<CR>

" Perl tidy
" define :Tidy command to run perltidy on visual selection || entire buffer"
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy -l=160 -q

" run :Tidy on entire buffer and return cursor to (approximate) original position"
fun DoTidy()
    let Pos = line2byte( line( "." ) )
    :Tidy
    exe "goto " . Pos
endfun

" shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <leader>pt :call DoTidy()<CR>

" shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <leader>pt :Tidy<CR>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set guioptions=egmrt
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Highlight trailing whitespace
set list
set listchars=tab:\|\ ,trail:·
hi SpecialKey ctermbg=244 ctermfg=124 guibg=244 guifg=124

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
