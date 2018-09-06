" COLORS

set termguicolors

if exists('$CODA_SCREENCAST')
  let g:one_allow_italics = 1
  colorscheme one
  set background=light
else
  "colorscheme PaperColor
  colorscheme monochromatic
  set background=light
endif

"hi WarningMsg ctermfg=180 guifg=#e5c07b
