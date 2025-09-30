vim9script

# disable animation
g:operator#sandwich#set('all', 'all', 'highlight', 0)

g:sandwich#recipes = g:sandwich#default_recipes->extendnew([
  {'buns': ['“', '”'], 'input': ['Q']},
])

omap ik <Plug>(textobj-sandwich-auto-i)
xmap ik <Plug>(textobj-sandwich-auto-i)
omap ak <Plug>(textobj-sandwich-auto-a)
xmap ak <Plug>(textobj-sandwich-auto-a)

nmap ys <Plug>(sandwich-add)
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> yss <Plug>(sandwich-add)<SID>line
nmap ds <Plug>(sandwich-delete)
nmap dss <Plug>(sandwich-delete-auto)
nmap cs <Plug>(sandwich-replace)
nmap css <Plug>(sandwich-replace-auto)
xmap S <Plug>(sandwich-add)

def MarkdownSetup()
  b:sandwich_recipes = g:sandwich#recipes->extendnew([
    {'buns': ['```', '```'], 'nesting': 0, 'cursor': 'headend', 'linewise': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['c']},
    { 'buns': ['```\w*', '```'], 'regex': 1, 'nesting': 0, 'linewise': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'skip_break': 1, 'input': ['c'] },
    {'buns': ['[[', ']]'], 'nesting': 0, 'expand_range': 0, 'input': ['w']},
    {'buns': ['**', '**'], 'input': ['b']},
  ])
enddef

augroup vimrc
  autocmd FileType markdown call MarkdownSetup()
augroup END
