" Use deoplete.
let g:deoplete#enable_at_startup = !exists('$CODA_SCREENCAST')

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
