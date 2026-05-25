vim9script

augroup vimrc
  autocmd InsertEnter * g:cursorword = 0
  autocmd InsertLeave * g:cursorword = 1
augroup END


