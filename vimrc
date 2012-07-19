" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call pathogen#infect()

" Do not clear sreen on exit.
"set t_ti= t_te=

set browsedir  =current
set whichwrap+=>
set whichwrap+=<
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nowrap
set hidden
set expandtab
set noerrorbells
set nostartofline
set history=5000
set backspace=indent,eol,start
set ruler
set showcmd
set incsearch
set guifont=Monaco:h12
set cursorline
set guicursor+=a:blinkon0
set number
set listchars=tab:▸\ ,eol:¬
set list!

if ! has("gui_running")
  set t_Co=256
  colorscheme mac_classic
else
  colorscheme mac_classic
endif

let g:fugitive_github_domains = ['source.xing.com']

nmap <leader>a <Esc>:Ack!
map <leader>n :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Navigation between split windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

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
  filetype plugin indent on

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
