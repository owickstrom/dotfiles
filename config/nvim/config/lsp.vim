let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie-wrapper.sh', '--lsp']
    \ }

nnoremap <silent> K :call LanguageClient_hover_formatted()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Leader>f :call LanguageClient_textDocument_formatting()<CR>

augroup LangClient_signcolumn
  autocmd!
  autocmd FileType haskell setlocal signcolumn=yes
augroup END

function! s:Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : l:result
endfunction

function! s:Text() abort
    let l:lines = getline(1, '$')
    if l:lines[-1] !=# '' && &fixendofline
        let l:lines += ['']
    endif
    return l:lines
endfunction

function! s:IsTrue(v) abort
    if type(a:v) ==# type(0)
        return a:v ==# 0 ? v:false : v:true
    elseif a:v is v:null
        return v:false
    else
        return v:true
    endif
endfunction

function! s:IsFalse(v) abort
    return s:IsTrue(a:v) ? v:false : v:true
endfunction

function! LanguageClient_hover_formatted()
  let l:params = {
              \ 'filename': s:Expand('%:p'),
              \ 'text': s:Text(),
              \ 'line': line('.') - 1,
              \ 'character': col('.') - 1,
              \ 'handle': v:false,
              \ }
  return LanguageClient#Call('textDocument/hover', l:params, function('LanguageClient_hover_callback'))
endfunction

function! LanguageClient_hover_callback(response)
  if len(a:response['result']['contents']) == 0
    echomsg "No hover information available."
    return
  endif

  split view 'LSP Hover'
  setlocal buftype=nofile
  silent! execute 'nnoremap <silent> <buffer> q :q<CR>'

  for l:msg in a:response['result']['contents']
    if type(l:msg) == 4 " dict
      if l:msg['language'] ==# 'haskell'
        setlocal filetype=markdown
        call append(line(0), '**' . l:msg['value'] . '**')
      else
        call append(line('$'), l:msg['value'])
      endif
    elseif type(l:msg) == 1 " string
      call append(line('$'), split(l:msg, '\v\n'))
    endif
  endfor

  setlocal readonly
endfunction
