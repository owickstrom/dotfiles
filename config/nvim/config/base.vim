" BASE

" General
set nocompatible            " get rid of Vi compatibility mode. SET FIRST!
filetype plugin indent on   " filetype detection[ON] plugin[ON] indent[ON]
syntax enable               " enable syntax highlighting (previously syntax on).

" Navigation
set scrolloff=3             " some lines around scroll for context

" Cursor/Line
set number
set colorcolumn=80          " ruler at 80 chars width
set cursorline              " highlight the current line

" Status/History
set history=200             " remember a lot of stuff
set ruler                   " Always show info along bottom.
set cmdheight=1

" Scrolling
set ttyfast

" Files
set autoread                   " auto-reload files changed on disk
set updatecount=0              " disable swap files
set wildmode=longest,list,full " :e completion mode

" Vimdiff
set diffopt=filler,vertical

" Conceal (disabled by default)
set conceallevel=0

" Wrapping
set nowrap                  " don't wrap text

" Leader
let mapleader = ','
let maplocalleader = ','

" Make F1 work like Escape.
map <F1> <Esc>
imap <F1> <Esc>

" Mouse issue (https://github.com/neovim/neovim/wiki/Following-HEAD#20170403)
set mouse=a

" Use system clipboard for yanks.
set clipboard+=unnamedplus

" Use ,t for 'jump to tag'.
nnoremap <Leader>t <C-]>
