" SEARCH

set hlsearch                " highlight all results
set incsearch               " but do highlight as you type your search.
set ignorecase              " make searches case-insensitive...
set smartcase               " ... unless they contain at least one capital letter
set gdefault                " have :s///g flag by default on"

" Reset search with ,n
noremap <Leader>n :noh<CR>
