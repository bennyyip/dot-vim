setlocal commentstring=//\ %s
if &filetype ==# "cpp"
  nnoremap <leader>R :w<CR>:AsyncRun clang++ -std=c++14 % -o /tmp/%< && /tmp/%< <CR>
else
  nnoremap <leader>R :w<CR>:AsyncRun clang -std=c99 % -o /tmp/%< && /tmp/%< <CR>
endif

imap <c-l> <Plug>CompletorCppJumpToPlaceholder

ALEDisable
