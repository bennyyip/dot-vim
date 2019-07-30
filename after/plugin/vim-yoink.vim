" Plugin: svermeulen/vim-yoink
if !plugpac#has_plugin('vim-yoink')
  finish
endif

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

