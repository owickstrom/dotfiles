if !exists('g:ruby_rdl_require')
  throw 'g:ruby_rdl_require must be set!'
endif

function! neomake#makers#ft#ruby#rdl() abort
  if exists('g:ruby_rdl_bundler_gem') && g:ruby_rdl_bundler_gem
    let l:exe = 'bundle'
    let l:args = ['exec', 'ruby', '-r', 'rubygems', '-r', 'bundler/setup', '-r', 'rdl', '-r', g:ruby_rdl_require, '-e', 'RDL.do_typecheck :later']
  else
    let l:exe = 'ruby'
    let l:args = ['-r', 'rdl', '-r', g:ruby_rdl_require, '-e', 'RDL.do_typecheck :later']
  endif

  let l:efm =
      \ '%-Gwarning:%.%#,'.
      \ '%-G%.%#from\ %.%#:in\ %.%#,'.
      \ '%-G%.%#~~~~%.%#,'.
      \ '%E%f:%l:%c:\ error:\ %m,'.
      \ '%E%f:%l:%c-%.%#:\ error:\ %m,'.
      \ '%-G%f:%l:in\ %.%#,'.
      \ '%-G%f:%l:\ %.%#,'.
      \ '%-Z%.%#'

  return {
        \ 'exe': 'bundle',
        \ 'args': l:args,
        \ 'errorformat': l:efm
        \ }
endfunction
