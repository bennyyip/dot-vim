vim9script
imap <C-t>     <Plug>(neosnippet_expand_or_jump)
smap <C-t>     <Plug>(neosnippet_expand_or_jump)
xmap <C-t>     <Plug>(neosnippet_expand_target)

g:neosnippet#disable_runtime_snippets = { '_': 1 }
g:neosnippet#enable_snipmate_compatibility = 0
g:neosnippet#enable_conceal_markers = 0
g:neosnippet#snippets_directory = $v .. '/snippets'

# or (s won't expand s
g:neosnippet#expand_word_boundary = 1

def OpenSnippets(ft: string = null_string)
  const d = g:neosnippet#snippets_directory
  const fname = ft == null_string ? &filetype : ft
  exe $"tabe {d}/{fname}.snippets"
enddef

command -nargs=? Snippets OpenSnippets(<q-args>)
