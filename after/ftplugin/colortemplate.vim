vim9script

if exists(":Colortemplate") > 0
  nmap <buffer> <F5> <cmd>Colortemplate! <BAR> execute $"colorscheme {expand('%:t:r')}"<CR>
endif
unmap <buffer> gx
unmap <buffer> gs
