"let g:ale_linters = { 'rust': ['rustc'] }
nnoremap <buffer><Leader>cf :<C-u>RustFmt<CR>
vnoremap <buffer><Leader>cf :RustFmtRange<CR>
nnoremap <Leader>R :<C-u>RustFmt<CR>:AsyncRun cargo run<CR>
nnoremap <Leader>T :<C-u>RustFmt<CR>:AsyncRun cargo test<CR>
nmap gd <Plug>(rust-def)
nmap K <Plug>(rust-doc)
let g:racer_cmd='racer'
