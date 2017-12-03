" COLORS
"
" use 24-bit (true-color) mode in vim/neovim when outside tmux.  if you're
" using tmux version 2.2 or later, you can remove the outermost $tmux check
" and use tmux's 24-bit color support (see <
" http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($tmux))
  if (has("nvim"))
  "for neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $nvim_tui_enable_true_color=1
  endif
  "for neovim > 0.1.5 and vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "based on vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/following-head#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark
colorscheme onedark
