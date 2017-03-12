" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use smartcase.
let g:deoplete#enable_smart_case = 1

" Use omnifunc for completion.
let g:deoplete#complete_method = 'omnifunc'

inoremap <expr><C-h>
      \ deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>
      \ deoplete#smart_close_popup()."\<C-h>"
