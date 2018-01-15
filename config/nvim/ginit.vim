if $CODA_SCREENCAST
  GuiFont Iosevka Term Medium:h20
else
  GuiFont Iosevka Term Medium:h11
endif

map <F11> :call rpcnotify(0, 'Gui', 'WindowFullScreen', !g:GuiWindowFullScreen)<CR>
