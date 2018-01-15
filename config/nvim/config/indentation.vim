" INDENTATION

set cindent
set autoindent              " auto-indent
set tabstop=2               " tab spacing
set softtabstop=2           " unify
set shiftwidth=2            " indent/outdent by 2 columns
set shiftround              " always indent/outdent to the nearest tabstop
set expandtab               " use spaces instead of tabs
set smarttab                " use tabs at the start of a line, spaces elsewhere

autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
