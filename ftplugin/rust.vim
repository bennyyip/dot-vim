nnoremap <F5> :Make run<CR>
nnoremap <F4> :Make test<CR>

nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap <leader>gd <Plug>(rust-doc)

let b:surround_{char2nr('|')} = '| \r '

if strlen(findfile("Cargo.toml", ".;"))
  compiler cargo
else
  compiler rustc
endif
