" RUST

function BuildCargo()
  execute "compiler cargo"
  execute "Make build"
endfunction

nmap <Leader>rb :call BuildCargo()<CR>

let g:racer_cmd = "~/.dotfiles/vim/bundle/racer/target/release/racer"
