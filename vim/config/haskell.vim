" HASKELL

au FileType haskell setlocal formatprg=hindent
let g:neoformat_enabled_haskell = ['hindent', 'stylishhaskell']

let g:neomake_haskell_enabled_makers = ['hlint']

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

function! ChangeInteroDirectory()
  let curline = getline('.')
  call inputsave()
  let dir = input('Change Intero Directory: ', fnamemodify(getcwd(), ':p'))
  call inputrestore()
  call intero#repl#eval(':cd ' . dir)
endfunction

function! ReloadInteroIfStarted()
  if exists("g:intero_started")
    :InteroReload
  endif
endfunction

function! InteroDevelUpdate()
  echo "Updating DevelMain..."
  call intero#repl#eval(':l DevelMain')
  call intero#repl#eval('DevelMain.update')
endfunction

augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Automatically reload on save
  au BufWritePost *.hs :call ReloadInteroIfStarted()

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Update DevelMain for Yesod
  au FileType haskell,hamlet,julius,lucius,cassius nnoremap <silent> <leader>iu :call InteroDevelUpdate()<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>
  au FileType haskell map <silent> <leader>iq <Plug>InteroInfo

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>

  " Changing Intero Directoies
  au FileType haskell nnoremap <silent> <leader>icd :call ChangeInteroDirectory()<CR>
augroup END

" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 0
