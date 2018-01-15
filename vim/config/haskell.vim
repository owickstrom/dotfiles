" HASKELL

let g:neoformat_enabled_haskell = ['hindent', 'stylishhaskell']

let g:neomake_haskell_enabled_makers = ['hlint']

set errorformat=
      \%W%f:%l:%c:\ Warning:%m,
      \%W%f:%l:%c:\ Warning:,
      \%E%f:%l:%c:%m,
      \%E%f:%l:%c:,

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

function! RunHasktagsIfExists()
  " Only regenerate existing tags.
  if filereadable('tags')
    call system('hasktags --ctags .')
  endif
endfunction

augroup HaskellMaps
  au FileType haskell setlocal formatprg=hindent
  au FileType haskell,lhaskell setlocal makeprg=cabal\ new-build
  au BufWritePost *.hs :call RunHasktagsIfExists()
augroup END

let g:intero_start_immediately = 0

function! ReloadGhciIfStarted()
  if exists('g:intero_started')
    :InteroReload
  endif
endfunction

function! GhciDevelUpdate()
  echo 'Updating DevelMain...'
  call intero#repl#eval(':l app/DevelMain.hs')
  call intero#repl#eval('DevelMain.update')
endfunction

function! GhciRunMain()
  call intero#repl#send(':l Main')
  call intero#repl#send(':main')
endfunction

function! ChangeGhciDirectory()
  let curline = getline('.')
  call inputsave()
  let dir = input('Change GHCi Directory: ', fnamemodify(getcwd(), ':p'))
  call inputrestore()
  call intero#repl#eval(':cd ' . dir)
endfunction

augroup ghciMaps
  au!
  " Background process and window management
  au FileType haskell,lhaskell nnoremap <silent> <leader>gs :InteroStart<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gk :InteroKill<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gr :InteroRestart<CR>

  au FileType haskell,lhaskell nnoremap <silent> <leader>gos :InteroOpen<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gov :InteroOpen<CR><C-W>H

  au FileType haskell,lhaskell nnoremap <silent> <leader>gh :InteroHide<CR>

  " Automatically reload on save
  au BufWritePost *.hs :call ReloadGhciIfStarted()

  " Load individual modules
  au FileType haskell,lhaskell nnoremap <silent> <leader>gl :InteroLoadCurrentModule<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gf :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell,lhaskell map <silent> <leader>gt <Plug>InteroGenericType
  au FileType haskell,lhaskell map <silent> <leader>gT <Plug>InteroType
  au FileType haskell,lhaskell map <silent> <leader>gi :InteroInfo<CR>
  au FileType haskell,lhaskell map <silent> <leader>gI :InteroTypeInsert<CR>

  " Update DevelMain for Yesod
  au FileType haskell,lhaskell,hamlet,julius,lucius,cassius nnoremap <silent> <leader>gu :call GhciDevelUpdate()<CR>

  " Change GHCi directory
  au FileType haskell,lhaskell nnoremap <silent> <leader>gcd :call ChangeGhciDirectory()<CR>

  " Run :main
  au FileType haskell,lhaskell nnoremap <silent> <leader>gm :call GhciRunMain()<CR>
augroup END
