vim9script

nmap <buffer> <F5> <cmd>Colortemplate! <BAR> execute $"colorscheme {expand('%:t:r')}"<CR>
