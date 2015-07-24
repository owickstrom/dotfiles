" RUST

function! CargoBuild()
  execute "compiler cargo"
  execute "Make build"
endfunction

function! CargoTest()
  execute "compiler cargo"
  execute "Make test"
endfunction


nmap <Leader>rb :call CargoBuild()<CR>
nmap <Leader>rt :call CargoTest()<CR>

let g:racer_cmd = "~/.dotfiles/vim/bundle/racer/target/release/racer"
