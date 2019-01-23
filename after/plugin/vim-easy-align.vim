" Plugin: junegunn/vim-easy-align
if !plugpac#has_plugin('vim-easy-align')
  finish
endif
xmap <cr> <plug>(LiveEasyAlign)
