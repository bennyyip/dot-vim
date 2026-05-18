vim9script
g:UltiSnipsEnableSnipMate = 0

g:UltiSnipsExpandOrJumpTrigger = "<c-t>"
g:UltiSnipsJumpForwardTrigger = "<c-g><c-n>"
g:UltiSnipsJumpBackwardTrigger = "<c-g><c-p>"
g:UltiSnipsListSnippets = "<c-g>t"

augroup vimrc
  autocmd FileType snippets nnoremap <buffer> <F1> <CMD>help UltiSnips-basic-syntax<CR>
augroup end
