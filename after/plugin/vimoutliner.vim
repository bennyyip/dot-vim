" Plugin: vimoutliner/vimoutliner
if !ben#has_plugin('vimoutliner')
  finish
endif

nnoremap <leader>v :call ben#votl()<CR>
