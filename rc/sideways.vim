vim9script
# Plugin: AndrewRadev/sideways.vim

g:sideways_add_item_cursor_restore = true

nnoremap <c-left>  :SidewaysLeft<cr>
nnoremap <c-right> :SidewaysRight<cr>
nnoremap <s-left>  :SidewaysLeft<cr>
nnoremap <s-right> :SidewaysRight<cr>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
nmap <leader>si <Plug>SidewaysArgumentInsertBefore
nmap <leader>sa <Plug>SidewaysArgumentAppendAfter
nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
nmap <leader>sA <Plug>SidewaysArgumentAppendLast
