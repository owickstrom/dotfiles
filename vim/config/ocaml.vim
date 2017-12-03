let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')

" Vim needs to be built with Python scripting support, and must be
" able to find Merlin's executable on PATH.
if executable('ocamlmerlin') && has('python')
  let s:ocamlmerlin = g:opamshare . "/ocamlmerlin"
  execute "set rtp+=".s:ocamlmerlin."/vim"
  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
endif

let s:ocpindent = g:opamshare."/ocp-indent/vim"
set rtp+=s:ocpindent

function! GenerateMerlinHelptags()
  execute "helptags " . g:opamshare . "/merlin/vim/doc"
endfunction
