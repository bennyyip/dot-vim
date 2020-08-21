" Plugin: AndrewRadev/linediff.vim

let g:linediff_buffer_type = 'scratch'

vnoremap zd :Linediff<CR>
autocmd User LinediffBufferReady nnoremap <buffer> gs :LinediffReset<cr>

