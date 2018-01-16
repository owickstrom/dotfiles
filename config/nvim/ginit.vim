let s:font = 'GuiFont Iosevka Term Medium'

function! SetFontSize(n)
  exec (s:font . ':h' . a:n)
endfunction

function! ModifyFontSize(mod)
  let s:current_font_size = a:mod(s:current_font_size)
  call SetFontSize(s:current_font_size)
endfunction

function! IncreaseFontSize()
  call ModifyFontSize({n -> (n + 1)})
endfunction

function! DecreaseFontSize()
  call ModifyFontSize({n -> (n - 1)})
endfunction

if $CODA_SCREENCAST
  call SetFontSize(20)
else
  call SetFontSize(11)
endif

map <F11> :call rpcnotify(0, 'Gui', 'WindowFullScreen', !g:GuiWindowFullScreen)<CR>
