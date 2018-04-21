if &ft == "cpp"
  nnoremap <leader>R :w<CR>:AsyncRun clang++ -std=c++14 % -o /tmp/%< && /tmp/%< <CR>
else
  nnoremap <leader>R :w<CR>:AsyncRun clang -std=c99 % -o /tmp/%< && /tmp/%< <CR>
endif

" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd BufLeave *.{c,cpp} mark C
autocmd BufLeave *.h       mark H

imap <c-l> <Plug>CompletorCppJumpToPlaceholder

ALEDisable
