" HASKELL

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

" Use GHC functionality for haskell source files
"au Bufenter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/google-chrome"
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
