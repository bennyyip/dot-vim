setlocal tabstop=4 softtabstop=4 shiftwidth=4

nnoremap <buffer><F5>      :AsyncRun -raw python %<CR>
inoremap <buffer><F5> <ESC>:AsyncRun -raw python %<CR>
xnoremap <buffer><F5>      :AsyncRun -raw python  <CR>

let g:python_highlight_all = 1
let g:jedi#completions_enabled = 0
