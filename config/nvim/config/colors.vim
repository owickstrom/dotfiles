" COLORS

set termguicolors

if exists('$CODA_SCREENCAST')
  set background=light
else
  set background=dark
endif

let g:one_allow_italics = 1
colorscheme one

hi WarningMsg ctermfg=180 guifg=#e5c07b
