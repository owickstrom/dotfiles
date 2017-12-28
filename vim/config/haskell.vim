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

let g:ghci_start_immediately = 0
let g:ghci_command = 'ghci'
let g:ghci_command_line_options = ''

function! ReloadGhciIfStarted()
  if exists('g:ghci_started')
    :GhciReload
  endif
endfunction

function! GhciDevelUpdate()
  echo 'Updating DevelMain...'
  call ghci#repl#eval(':l app/DevelMain.hs')
  call ghci#repl#eval('DevelMain.update')
endfunction

function! GhciRunMain()
  call ghci#repl#send(':l Main')
  call ghci#repl#send(':main')
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
  au FileType haskell,lhaskell nnoremap <silent> <leader>gs :GhciStart<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gk :GhciKill<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gr :GhciRestart<CR>

  " Open cabalRepl/GHCi split horizontally
  au FileType haskell,lhaskell nnoremap <silent> <leader>go :GhciOpen<CR>
  " Open cabalRepl/GHCi split vertically
  au FileType haskell,lhaskell nnoremap <silent> <leader>gov :GhciOpen<CR><C-W>H
  au FileType haskell,lhaskell nnoremap <silent> <leader>gh :GhciHide<CR>

  " Automatically reload on save
  au BufWritePost *.hs :call ReloadGhciIfStarted()

  " Load individual modules
  au FileType haskell,lhaskell nnoremap <silent> <leader>gl :GhciLoadCurrentModule<CR>
  au FileType haskell,lhaskell nnoremap <silent> <leader>gf :GhciLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell,lhaskell map <silent> <leader>gt <Plug>GhciType
  au FileType haskell,lhaskell map <silent> <leader>gi :GhciInfo<CR>
  au FileType haskell,lhaskell map <silent> <leader>gI :GhciTypeInsert<CR>

  " Update DevelMain for Yesod
  au FileType haskell,lhaskell,hamlet,julius,lucius,cassius nnoremap <silent> <leader>gu :call GhciDevelUpdate()<CR>

  " Change GHCi directory
  au FileType haskell,lhaskell nnoremap <silent> <leader>gcd :call ChangeGhciDirectory()<CR>

  " Run :main
  au FileType haskell,lhaskell nnoremap <silent> <leader>gm :call GhciRunMain()<CR>
augroup END
