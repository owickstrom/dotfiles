let g:test#strategy = 'basic'

augroup test_commands
  nmap <silent> <Leader>rn :TestNearest<CR>
  nmap <silent> <Leader>rf :TestFile<CR>
  nmap <silent> <Leader>rs :TestSuite<CR>
  nmap <silent> <Leader>rl :TestLast<CR>
  nmap <silent> <Leader>rv :TestVisit<CR>
augroup END
