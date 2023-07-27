vim9script
# Plugin: AndrewRadev/linediff.vim

g:linediff_buffer_type = 'scratch'

noremap <C-G>d :Linediff<CR>

augroup vimrc
  autocmd User LinediffBufferReady nnoremap <buffer> gs :LinediffReset<cr>
augroup end
