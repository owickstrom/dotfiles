" GOLANG

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <Leader>ti <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

function! GoToggleAlternate()
  let path = expand('%:r')
  if path =~ ".*_test$"
    " From *_test.go to *.go
    let impl_path = fnamemodify(path, ":s?_test?.go?")
    if filereadable(impl_path)
      execute "e " . impl_path
    endif
  else
    " From *.go to *_test.go
    let test_path = path . "_test.go"
    if filereadable(test_path)
      execute "e " . test_path
    endif
  endif
endfunction

au FileType go nnoremap <leader>a :call GoToggleAlternate()<CR>

let $GOPATH = $HOME . "/Projects/go:" . fnamemodify('.', ':p') . ':' . fnamemodify('./vendor', ':p')

set wildignore+=*/vendor/*
