source ~/.vim/config/yapf.vim
au FileType python nnoremap <leader>R :w<CR>:AsyncRun python %<CR>
au FileType python nnoremap <leader>W :w<CR>:YAPF<CR>
"au FileType python setlocal ts=4 sts=4 sw=4 noet 
au FileType python setlocal ts=4 sts=4 sw=4 
let python_highlight_all = 1

