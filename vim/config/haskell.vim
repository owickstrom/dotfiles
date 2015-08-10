" HASKELL

let g:necoghc_enable_detailed_browse = 1

" Use GHC functionality for haskell source files
"au Bufenter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/google-chrome"
let g:ghc = "/usr/local/bin/ghc"

nmap <Leader>gt :GhcModType<CR>
nmap <Leader>gc :GhcModTypeClear<CR>
nmap <Leader>gi :GhcModTypeInsert<CR>
