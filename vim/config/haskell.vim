" HASKELL

au FileType haskell setlocal formatprg=hindent
let g:neoformat_enabled_haskell = ['hindent', 'stylishhaskell']

let g:neomake_haskell_enabled_makers = ['hlint']

au FileType haskell setlocal makeprg=cabal\ new-build
set errorformat=
      \%W%f:%l:%c:\ Warning:%m,
      \%W%f:%l:%c:\ Warning:,
      \%E%f:%l:%c:%m,
      \%E%f:%l:%c:,

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
" let g:necoghc_enable_detailed_browse = 1
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

let g:ghci_start_immediately = 0
let g:ghci_command = 'ghci'
let g:ghci_command_line_options = ''

function! ReloadGhciIfStarted()
  if exists("g:ghci_started")
    :GhciReload
  endif
endfunction

function! GhciDevelUpdate()
  echo "Updating DevelMain..."
  call ghci#repl#eval(':l app/DevelMain.hs')
  call ghci#repl#eval('DevelMain.update')
endfunction

function! ChangeGhciDirectory()
  let curline = getline('.')
  call inputsave()
  let dir = input('Change GHCi Directory: ', fnamemodify(getcwd(), ':p'))
  call inputrestore()
  call ghci#repl#eval(':cd ' . dir)
endfunction

augroup ghciMaps
  au!
  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>gs :GhciStart<CR>
  au FileType haskell nnoremap <silent> <leader>gk :GhciKill<CR>
  au FileType haskell nnoremap <silent> <leader>gr :GhciRestart<CR>

  " Open cabalRepl/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>go :GhciOpen<CR>
  " Open cabalRepl/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>gov :GhciOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>gh :GhciHide<CR>

  " Automatically reload on save
  au BufWritePost *.hs :call ReloadGhciIfStarted()

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>gl :GhciLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>gf :GhciLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>gt <Plug>GhciType
  au FileType haskell map <silent> <leader>gi :GhciInfo<CR>
  au FileType haskell map <silent> <leader>gI :GhciTypeInsert<CR>

  " Update DevelMain for Yesod
  au FileType haskell,hamlet,julius,lucius,cassius nnoremap <silent> <leader>gu :call GhciDevelUpdate()<CR>

  " Change GHCi directory
  au FileType haskell nnoremap <silent> <leader>gcd :call ChangeGhciDirectory()<CR>
augroup END
