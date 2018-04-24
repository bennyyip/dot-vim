nnoremap <F5> :Make run<CR>
nnoremap <F6> :Make test<CR>

if has('nvim')
  " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  " nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
else
  nmap gd <Plug>(rust-def)
  nmap gs <Plug>(rust-def-split)
  nmap gx <Plug>(rust-def-vertical)
  nmap <leader>gd <Plug>(rust-doc)
endif

let b:surround_{char2nr('|')} = '| \r '

if strlen(findfile("Cargo.toml", ".;"))
	compiler cargo
else
	compiler rustc
endif
