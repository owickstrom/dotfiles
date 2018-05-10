" HASKELL

let g:haskell_indent_case_alternative = 1
let g:haskell_indent_in = 0
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2

let g:neoformat_enabled_haskell = ['brittany', 'stylishhaskell']

let g:neomake_haskell_enabled_makers = ['hlint']

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

function! RunHasktagsIfExists()
  " Only regenerate existing tags.
  if filereadable('tags')
    call system('hasktags --ctags .')
  endif
endfunction

let g:haskell_project_errorformat = '%E%f:%l:%c:\ error:%#,' .
      \ '%W%f:%l:%c:\ warning:%#,' .
      \ '%W%f:%l:%c:\ warning:\ [-W%.%#]%#,' .
      \ '%f:%l:%c:\ %trror: %m,' .
      \ '%f:%l:%c:\ %tarning: %m,' .
      \ '%E%f:%l:%c:%#,' .
      \ '%E%f:%l:%c:%m,' .
      \ '%W%f:%l:%c:\ Warning:%#,' .
      \ '%C\ \ %m%#,' .
      \ '%-G%.%#'

augroup HaskellMaps
  au FileType haskell setlocal formatprg=hindent
  au FileType haskell,lhaskell setlocal makeprg=cabal\ new-build
  au FileType haskell,lhaskell setlocal errorformat=g:haskell_project_errorformat
  au BufWritePost *.hs :call RunHasktagsIfExists()
augroup END
