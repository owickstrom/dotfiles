" JSON

autocmd FileType json command! FmtJson %!jq -M .
let g:vim_json_syntax_conceal = 0

