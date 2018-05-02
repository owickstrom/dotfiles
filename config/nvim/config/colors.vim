" COLORS

set termguicolors

if exists('$CODA_SCREENCAST')
  let g:one_allow_italics = 1
  colorscheme one
  set background=light
else
  colorscheme paramount
  set background=dark
  hi Normal guibg=#181818
endif

hi WarningMsg ctermfg=180 guifg=#e5c07b
