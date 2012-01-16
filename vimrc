
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"do not clear sreen on exit
"set t_ti= t_te=

"source $HOME/.vim/plugin/selectbuf.vim
set gfn=Courier:h15

"set statusline=%f\ [Format\ %{&fileformat}]\ [Encoding\ %{&fileencoding}]\ %=\ %l/%L,%-5c\ %P\

" colorscheme dusk
set browsedir  =current

"damit man mit pfeiltasten l/r zwischen zeilen springen kann
set whichwrap+=>
set whichwrap+=<
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nowrap

"erlaube versteckte fenster (:unhide etc)
set hidden

"strg+tab / strg+shift+tab zum buffer wechseln
nnoremap <C-Tab> :bnext<CR>
nnoremap <S-C-Tab> :bprevious<CR>

"leerzeichen statt tabs
set expandtab

"keine beeps
set noerrorbells

" don't jump cursor around, stay in current column
set nostartofline

" make the history longer
set history=500

" open buffer explorer
nnoremap <F2> :SelectBuf<CR>

" show last opened files
nnoremap <F3> :MRU<CR>

" commentify current line
nnoremap <F4> <Esc><Plug>Traditionalj

" save current buffer
nnoremap <F5> :w<CR>

" show file explorer
nnoremap <F6> :Explore<CR>

" show functions list (ctags)
nnoremap <F7> :Tlist<CR>

" buffer delete
nnoremap <F10> :%!perltidy -l=160 -q<CR>

"F11 drücken > text einfügen > F11 drücken ;)
set pastetoggle=<F11>

"F12 führt script aus
"nnoremap <F12> :w<CR>:!%<CR>
nnoremap <F12> :w<CR>:!g++ % -o %.out<CR>:!%.out<CR>:!rm %.out<CR>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set binary

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
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
