" GIT

nmap <Leader>vgs :Gstatus<CR>
nmap <Leader>vgl :Glog<CR>
nmap <Leader>vgh :Glog -- %<CR>

" Don't index files listed in gitignore.
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" git grep the word under cursor
nmap <Leader>vgg :Ggrep <cword> .<CR>

let g:gitgutter_enabled = !exists('$CODA_SCREENCAST')
