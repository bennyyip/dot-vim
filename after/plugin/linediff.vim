" Plugin: AndrewRadev/linediff.vim
if !ben#has_plugin('linediff.vim')
  finish
endif

vnoremap zd :Linediff<CR>
autocmd User LinediffBufferReady nnoremap <buffer> gs :LinediffReset<cr>

