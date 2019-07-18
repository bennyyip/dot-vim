" Plugin: voldikss/vim-translate-me
if !plugpac#has_plugin('vim-translate-me')
  finish
endif

let g:vtm_default_mapping = 0

nmap gY <Plug>TranslateW
