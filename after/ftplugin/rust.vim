nnoremap <buffer><F5> :Make run<CR>
nnoremap <buffer><F4> :Make test<CR>

" nmap <buffer> gd <Plug>(rust-def)
" nmap <buffer> <leader>gd <Plug>(rust-doc)
"
if strlen(findfile("Cargo.toml", ".;"))
  compiler cargo
else
  compiler rustc
endif
