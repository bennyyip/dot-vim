" nmap <leader>c <Plug>OSCYankOperator
" nmap <leader>cc <leader>c_
" vmap <leader>c <Plug>OSCYankVisual
" vmap <A-w> <Plug>OSCYankVisual

command! -nargs=+ OpenBrowser OSCYank <args>
xnoremap <silent><C-c> <plug>OSCYankVisual


