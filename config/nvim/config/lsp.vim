let g:LanguageClient_serverCommands = {
    \ 'haskell': ['stack', 'exec', '--', 'hie', '--lsp']
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
