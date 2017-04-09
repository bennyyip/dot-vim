"let g:ale_linters = { 'rust': ['rustc'] }
autocmd FileType rust nnoremap <buffer><Leader>cf :<C-u>RustFmt<CR>
autocmd FileType rust vnoremap <buffer><Leader>cf :rustFmt<CR>
autocmd FileType rust nnoremap <Leader>R :<C-u>AsyncRun cargo run<CR>
autocmd FileType rust nmap gd <Plug>(rust-def)
autocmd FileType rust nmap K <Plug>(rust-doc)
let g:racer_cmd='racer'
