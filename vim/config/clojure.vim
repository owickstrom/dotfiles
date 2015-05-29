" CLOJURE

function! ReloadUserSystem()
  :Eval (if-let [v (resolve 'user/reset)] (@v) (.println *err* "Not a \"Reloaded\" workflow project. The function user/reset must be specified!"))
endfunction

" Add stuartsierra/component style key binding for reset.
autocmd FileType clojure nmap <Leader>ur :call ReloadUserSystem()<CR>

let g:slimv_disable_clojure=1
