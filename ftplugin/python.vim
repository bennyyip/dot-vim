setlocal tabstop=4 softtabstop=4 shiftwidth=4
nnoremap <buffer><F5> :w<CR>:AsyncRun python %<CR>
let g:python_highlight_all = 1
let g:jedi#completions_enabled = 0
