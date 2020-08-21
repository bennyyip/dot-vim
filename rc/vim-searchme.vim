" Plugin: voldikss/vim-searchme

noremap  gG :<C-u>SearchCurrentText<CR>
vnoremap gG :<C-u>SearchVisualText<CR>
noremap  gW :<C-u>SearchCurrentText wikipedia<CR>
vnoremap gW :<C-u>SearchVisualText wikipedia<CR>
noremap  <Leader>sm :SearchInGoogle<Space>
