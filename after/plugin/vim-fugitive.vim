" Plugin: tpope/vim-fugitive
if !ben#has_plugin('vim-fugitive')
  finish
endif

nmap <silent> <leader>gg :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>exe 'botright Gstatus'<Bar>else<Bar>ls<Bar>endif<CR>
nnoremap <silent> <leader>gb  :Gblame<CR>
nnoremap <silent> <leader>gd  :Gdiff<CR>
augroup vimrc
  autocmd FileType gitcommit wincmd J
augroup end
