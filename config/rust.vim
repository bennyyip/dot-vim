let g:ale_linters = { 'rust': ['rustc'] }
autocmd FileType rust nnoremap <buffer><Leader>cf :<C-u>RustFmt<CR>
autocmd FileType rust vnoremap <buffer><Leader>cf :rustFmt<CR>
autocmd FileType rust nnoremap <Leader>R :<C-u>AsyncRun rustc % --out-dir /tmp && /tmp/%< <CR>
