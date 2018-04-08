" Use deoplete.
let g:deoplete#enable_at_startup = 1

if exists('$CODA_SCREECAST')
  let g:deoplete#disable_auto_complete = 1
else
  let g:deoplete#disable_auto_complete = 0
endif

" Use smartcase.
let g:deoplete#enable_smart_case = 1

let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0

" Use omnifunc for completion.
let g:deoplete#complete_method = 'omnifunc'

inoremap <expr><C-h>
      \ deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>
      \ deoplete#smart_close_popup()."\<C-h>"

inoremap <silent><expr> <C-Space>
  \ <SID>check_back_space() ? "" :
  \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction"}}}
