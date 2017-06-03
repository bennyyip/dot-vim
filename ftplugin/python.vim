setlocal ts=4 sts=4 sw=4
nnoremap <leader>R :w<CR>:AsyncRun python %<CR>
nnoremap <silent><leader>cf :<c-u>Yapf<CR>
let python_highlight_all = 1
let g:jedi#completions_enabled = 0
