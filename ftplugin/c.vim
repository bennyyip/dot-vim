if &ft == "cpp"
  nnoremap <leader>R :w<CR>:AsyncRun clang++ -std=c++14 % -o /tmp/%< && /tmp/%< <CR>
else
  nnoremap <leader>R :w<CR>:AsyncRun clang -std=c99 % -o /tmp/%< && /tmp/%< <CR>
endif

" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

