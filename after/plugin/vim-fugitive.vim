" Plugin: tpope/vim-fugitive
if !plugpac#has_plugin('vim-fugitive')
  finish
endif

nmap <silent> <leader>gg :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>exe 'botright Gstatus'<Bar>else<Bar>ls<Bar>endif<CR>
nnoremap <silent> <leader>gb  :Gblame<CR>
nnoremap <silent> <leader>gd  :Gdiff<CR>
augroup vimrc
  autocmd FileType gitcommit wincmd J
  autocmd BufReadPost fugitive://* setl bufhidden=delete
augroup end

