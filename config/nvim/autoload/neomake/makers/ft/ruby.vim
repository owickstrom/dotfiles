function! neomake#makers#ft#ruby#rdl() abort
  let l:args = ['exec', 'ruby', '-r', 'rubygems', '-r', 'bundler/setup', '-r', 'rdl', '-r', 'empowerment', '-e', 'RDL.do_typecheck :later']
  let l:efm =
      \ '%-Gwarning:%.%#,'.
      \ '%-G%.%#from\ %.%#:in\ %.%#,'.
      \ '%-G%.%#~~~~%.%#,'.
      \ '%E%f:%l:%c:\ error:\ %m,'.
      \ '%-G%f:%l:in\ %.%#,'.
      \ '%-G%f:%l:\ %.%#,'.
      \ '%-Z%.%#'

  return {
        \ 'exe': 'bundle',
        \ 'args': l:args,
        \ 'errorformat': l:efm
        \ }
endfunction
