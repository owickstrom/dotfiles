" PATHOGEN
"
call plug#begin('~/.config/nvim/plugged')

" General/Editing
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'
Plug 'nelstrom/vim-qargs'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround'
Plug 'sbdchd/neoformat'
Plug 'kien/ctrlp.vim'

" URLs
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Misc Languages/Syntax
Plug 'vim-ruby/vim-ruby'
Plug 'klen/python-mode'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'purescript-contrib/purescript-vim'
Plug 'frigoeu/psc-ide-vim'
Plug 'owickstrom/vim-dataflow'
Plug 'ekalinin/Dockerfile.vim'
Plug 'klen/python-mode'
Plug 'idris-hackers/idris-vim'
Plug 'leafgarland/typescript-vim'

" HTML, CSS etc
Plug 'groenewege/vim-less'
Plug 'digitaltoad/vim-jade'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mattn/emmet-vim'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }

" Javascript
Plug 'elzr/vim-json'
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }

" Colors
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'pbrisbin/vim-colors-off'
Plug 'owickstrom/vim-colors-paramount'

for fpath in split(globpath('~/Projects/vim', '*'), '\n')
  Plug fpath
endfor

for fpath in split(globpath('~/projects/vim', '*'), '\n')
  Plug fpath
endfor

call plug#end()

for fpath in split(globpath('~/.config/nvim/config', '*.vim'), '\n')
  exe 'source' fpath
endfor
