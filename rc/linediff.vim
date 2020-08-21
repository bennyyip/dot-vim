" Plugin: AndrewRadev/linediff.vim

vnoremap zd :Linediff<CR>
autocmd User LinediffBufferReady nnoremap <buffer> gs :LinediffReset<cr>

