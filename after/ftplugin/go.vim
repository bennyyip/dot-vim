setl tabstop=4 shiftwidth=4 noexpandtab

if ben#has_plugin('vim-go')
  nnoremap <buffer> <silent> gd :GoDef<cr>
  nnoremap <buffer> <silent> <LocalLeader>d :GoDef<cr>
  nnoremap <buffer> <silent> <LocalLeader>v :<C-u>call go#def#Jump("split")<CR>
  nnoremap <buffer> <silent> <LocalLeader>t :<C-U>call go#def#StackPop(v:count1)<cr>
endif
