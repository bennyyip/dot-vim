vim9script
imap <C-t>     <Plug>(neosnippet_expand_or_jump)
smap <C-t>     <Plug>(neosnippet_expand_or_jump)
xmap <C-t>     <Plug>(neosnippet_expand_target)

g:neosnippet#disable_runtime_snippets = { '_': 1}
g:neosnippet#enable_snipmate_compatibility = 0
g:neosnippet#snippets_directory = $v .. '/snippets'
