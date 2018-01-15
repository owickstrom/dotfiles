" FILETYPES

" .ejs as HTML
au BufNewFile,BufRead *.ejs set filetype=html
" Markdown syntax
au BufRead,BufNewFile *.md set filetype=markdown
" .zap as Clojure
au BufNewFile,BufRead *.zap set filetype=clojure
