" Plugin: vimoutliner/vimoutliner
if !plugpac#has_plugin('vimoutliner')
  finish
endif

nnoremap <leader>v :call ben#votl()<CR>
