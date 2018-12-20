" Plugin: vim-scripts/YankRing.vim
if !ben#has_plugin('YankRing.vim')
  finish
endif

if !exists('##TextYankPost')
  nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
  " slect what I just pasted
  nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
  omap <expr> H YRMapsExpression("<SID>", "^", "1")
  omap <expr> L YRMapsExpression("<SID>", "$", "1")
endif

nnoremap <leader>y :YRShow<CR>
