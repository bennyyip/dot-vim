" Plugin: junegunn/vim-easy-align
if !ben#has_plugin('vim-easy-align')
  finish
endif
xmap <cr> <plug>(LiveEasyAlign)
