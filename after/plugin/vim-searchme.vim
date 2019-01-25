" Plugin: voldikss/vim-searchme
if !plugpac#has_plugin('vim-searchme')
  finish
endif

noremap  gG :<C-u>SearchCurrentText<CR>
vnoremap gG :<C-u>SearchVisualText<CR>
noremap  gW :<C-u>SearchCurrentText wikipedia<CR>
vnoremap gW :<C-u>SearchVisualText wikipedia<CR>
noremap  <Leader>sm :SearchInGoogle<Space>
