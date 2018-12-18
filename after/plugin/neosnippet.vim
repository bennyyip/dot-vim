" Plugin: Shougo/neosnippet
if !ben#has_plugin('neosnippet.vim')
  finish
endif
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
