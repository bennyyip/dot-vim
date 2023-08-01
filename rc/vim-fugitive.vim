vim9script
# Plugin: tpope/vim-fugitive

nmap <silent> <leader>gg :if &previewwindow<Bar>pclose<Bar>elseif exists(':Git')<Bar>exe 'botright Git'<Bar>else<Bar>ls<Bar>endif<CR>
nnoremap <silent> <leader>gb  :Git blame<CR>
nnoremap <silent> <leader>gd  :Gvdiffsplit<CR>
nnoremap <silent> <leader>gD  :Git difftool -y<CR>
augroup vimrc
  autocmd FileType gitcommit wincmd J
  autocmd BufReadPost fugitive://* setl bufhidden=delete
augroup end
