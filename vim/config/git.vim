" GIT

" Don't index files listed in gitignore.
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" git grep the word under cursor
nmap <Leader>gg :Ggrep <cword> .<CR>
