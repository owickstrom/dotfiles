" HASKELL

let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']

let g:necoghc_enable_detailed_browse = 1

" Use GHC functionality for haskell source files
"au Bufenter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/google-chrome"
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
