" for the start of a word
noremap <leader>w <Cmd>call stargate#OKvim('\<')<CR>
" for the end of a word
noremap <leader>e <Cmd>call stargate#OKvim('\S\>')<CR>
" for the start of a line
noremap <leader>l <Cmd>call stargate#OKvim('\_^')<CR>
" for the last character on the line
noremap <leader>E <Cmd>call stargate#OKvim('\S\s*$')<CR>
" for the end of a line
noremap <leader>$ <Cmd>call stargate#OKvim('$')<CR>
" for any bracket, parentheses or curly bracket
noremap <leader>[ <Cmd>call stargate#OKvim('[(){}[\]]')<CR>

noremap <leader>s <Cmd>call stargate#OKvim(1)<CR>
