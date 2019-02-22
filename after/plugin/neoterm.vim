" Plugin: kassio/neoterm
if !plugpac#has_plugin('neoterm')
  finish
endif

nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>
nmap <leader>tx  <Plug>(neoterm-repl-send)
xmap <leader>tx  <Plug>(neoterm-repl-send)
nmap <leader>txx <Plug>(neoterm-repl-send-line)
