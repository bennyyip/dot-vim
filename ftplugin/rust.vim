nnoremap <buffer><Leader>cf :<C-u>RustFmt<CR>
vnoremap <buffer><Leader>cf :RustFmtRange<CR>
nnoremap <Leader>R :w<CR>:AsyncRun cargo run <CR>
nnoremap <Leader>T :w<CR>:AsyncRun cargo test <CR>
nmap gd <Plug>(rust-def)
nmap K <Plug>(rust-doc)
let g:racer_cmd='racer'
